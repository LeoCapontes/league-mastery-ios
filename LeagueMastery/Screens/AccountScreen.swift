//
//  AccountScreen.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 13/07/2024.
//

import Foundation
import SwiftUI

struct AccountScreen: View{
    
    let motionManager = MotionManager()
    
    let masteryData: [MasteryResponse]
    let metrics: [MasteryResponseMetrics]
    
    // two lookup dictionaries that use champion id as a shared key
    let masteryDictionary: [Int: MasteryResponse]
    let metricsDictionary: [Int: MasteryResponseMetrics]
    
    var addToWatchlist: (User, Int) -> Void
    var removeFromWatchlist: (User, Int) -> Void
    
    @Bindable var user: User
    
    @State public var selectedPinnedMetric: String = "Season Milestone"
    
    @State var champSearchString: String = ""

    init(
        masteryData: [MasteryResponse],
        user: User,
        addToWatchlist: @escaping (User, Int) -> Void,
        removeFromWatchlist: @escaping (User, Int) -> Void
    ) {
        self.masteryData = masteryData
        self.metrics = GetResponseMetrics(masteryData)
        self.masteryDictionary = Dictionary(uniqueKeysWithValues: masteryData.map { ($0.championId, $0) })
        self.metricsDictionary = Dictionary(uniqueKeysWithValues: metrics.map { ($0.championId, $0) })
        self.user = user
        self.addToWatchlist = addToWatchlist
        self.removeFromWatchlist = removeFromWatchlist
    }
    
    @State private var isFavourite = false
    
    var sortOptions = ["Score", "Level", "Milestone", "Alphabetical"]
    @State private var toSortBy = "Score"
    @State private var sortAsc = false
    
    var byLevel: [MasteryResponse] {
        if(sortAsc) {
            return masteryData.sorted{
                $0.championLevel < $1.championLevel
            }
        }
        return masteryData.sorted{
            $0.championLevel > $1.championLevel
        }
    }
    
    var byMilestone: [MasteryResponse] {
        if(sortAsc) {
            return masteryData.sorted{
                $0.championSeasonMilestone < $1.championSeasonMilestone
            }
        }
        return masteryData.sorted{
            $0.championSeasonMilestone > $1.championSeasonMilestone
        }
    }
    
    var byAlphabetical: [MasteryResponse] {
        if(sortAsc) {
            return masteryData.sorted{
                getNameFromId(id: $0.championId) > getNameFromId(id: $1.championId)
            }
        }
        return masteryData.sorted{
            getNameFromId(id: $0.championId) < getNameFromId(id: $1.championId)
        }
    }
    
    var watchedChampions: [MasteryResponse] {
        var watchedChampions = [MasteryResponse]()
        let watchlistIds = user.championWatchlist
        
        for id in watchlistIds{
            if let toAdd = masteryData.first(where: { $0.championId == id }) {
                watchedChampions.append(toAdd)
            }
        }
        print("called watched champions")
        return watchedChampions
    }
    
    var selectedSort: [MasteryResponse] {
        switch toSortBy{
        case "Score":
            return sortAsc ? masteryData.reversed() : masteryData
        case "Level":
            return byLevel
        case "Milestone":
            return byMilestone
        case "Alphabetical":
            return byAlphabetical
        default:
            return masteryData
        }
    }

    var searchResult: [MasteryResponse] {
        if(champSearchString == "") {
            return selectedSort
        } else {
            print(champSearchString)
            return selectedSort.filter{
                getNameFromId(id: $0.championId).contains(champSearchString)
            }
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            VStack{
                StickyHeaderScrollView(
                    name: user.name,
                    tag: user.tagline,
                    iconId: user.profileIconId,
                    score: user.masteryScore
                ){
                    if (user.championWatchlist.count > 0){
                        Watchlist(content: {
                            ForEach(0..<watchedChampions.count, id: \.self){ index in
                                NavigationLink(value: watchedChampions[index]){
                                    WatchlistItem(
                                        entry: watchedChampions[index],
                                        metric: selectedPinnedMetric,
                                        removeCallback: removeFromWatchlistCallback
                                    )
                                }
                            }
                        }, selectedMetric: $selectedPinnedMetric)
                    }
                    
                    ForEach(0..<searchResult.count ,id: \.self){ index in
                        let entry = searchResult[index]
                        NavigationLink(value: entry){
                            LargeChampionRow(entry: entry, addToWatchList: addToWatchlistCallback)
                                .modifier(
                                    // Is holographic if a champion is 1 game from levelling up
                                    Holographic(
                                        visible: (entry.championPointsUntilNextLevel < 100 && (entry.markRequiredForNextLevel - entry.tokensEarned == 1)),
                                        offset: CGFloat(index)
                                    )
                                )
                        }
                    }
                    Rectangle().frame(height: 72).foregroundStyle(.clear)
                }
            }
            HStack{
                TextField("", text: $champSearchString, prompt: Text("Search Champions..."))
                    .padding()
                    .background(.regularMaterial)
                    .clipShape(Capsule())
                Menu {
                    ForEach(sortOptions, id: \.self){ option in
                        Button(option, action: {toSortBy = option})
                    }
                    Section{
                        Button(sortAsc ? "Ascending" : "Descending", action : {sortAsc = !sortAsc})
                    }
                    .menuActionDismissBehavior(.disabled)
                } label : {
                    ZStack{
                        HStack{
                            Image(systemName: sortAsc ? "arrow.up" : "arrow.down")
                            Text("\(toSortBy)")
                        }
                        .foregroundStyle(.blue)
                        .padding()
                    }
                }
                .modifier(GlassOrMaterial(materialType: .regularMaterial))
                .clipShape(Capsule())
            }
            .padding()
        }
        .environmentObject(motionManager)
        .navigationDestination(for: MasteryResponse.self){ entry in
            if let metric = metricsDictionary[entry.championId] {
                ChampionScreen(championData: entry, metrics: metric)
            } else {
                //TODO: this is a placeholder, handle this gracefully
                ChampionScreen(championData: entry, metrics: metrics[0])
            }
        }
        .padding(.horizontal, 10)
    }
    
    func addToWatchlistCallback(champId: Int) {
        addToWatchlist(user, champId)
    }
    
    func removeFromWatchlistCallback(champId: Int) {
        removeFromWatchlist(user, champId)
    }
    
}

func callbackPlaceholder(_ x: User, _ y: Int) -> Void {
    
}

struct GlassOrMaterial: ViewModifier {
    var materialType: Material
    
    func body(content: Content) -> some View {
        if #available(iOS 26.0, *) {
            content.glassEffect()
        } else {
            content.background(materialType)
        }
    }
}

#Preview {
    let mock = mockMasteryResponse
    AccountScreen(
        masteryData: Array<MasteryResponse>(mock[1...12]),
        user: User(
            puuid: "d",
            name: "Hide on Bush",
            tagline: "KR1",
            region: "Korea",
            server: "Asia",
            profileIconId: 1,
            summonerLevel: 999,
            masteryScore: 999
        ),
        addToWatchlist: callbackPlaceholder,
        removeFromWatchlist: callbackPlaceholder
    )
    .ignoresSafeArea(edges: .bottom)
}
