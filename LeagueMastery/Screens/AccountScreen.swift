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
    
    var byLevel: [MasteryResponse] {
        return masteryData.sorted{
            $0.championLevel > $1.championLevel
        }
    }
    
    var byMilestone: [MasteryResponse] {
        return masteryData.sorted{
            $0.championSeasonMilestone > $1.championSeasonMilestone
        }
    }
    
    var byAlphabetical: [MasteryResponse] {
        return masteryData.sorted{
            namesFromChampId[$0.championId]! < namesFromChampId[$1.championId]!
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
            return masteryData
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
                    
                    ForEach(0..<selectedSort.count ,id: \.self){ index in
                        let entry = selectedSort[index]
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
                }
            }
            Menu {
                ForEach(sortOptions, id: \.self){ option in
                    Button(option, action: {toSortBy = option})
                }
            } label : {
                ZStack{
                    HStack{
                        Image(systemName: "arrow.up.arrow.down")
                        Text("\(toSortBy)")
                    }
                    .foregroundStyle(.blue)
                    .padding()
                    .background(.regularMaterial)
                    .clipShape(Capsule())
                }
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

#Preview {
    let mock = mockMasteryResponse
    AccountScreen(
        masteryData: mock,
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
}
