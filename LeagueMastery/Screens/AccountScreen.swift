//
//  AccountScreen.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 13/07/2024.
//

import Foundation
import SwiftUI
import OSLog

struct AccountScreen: View{
    let gradient = LinearGradient(
        stops: [
            Gradient.Stop(color: Color.black.opacity(0.75), location: 0),
            Gradient.Stop(color: .clear, location: 0.15),
            Gradient.Stop(color: .clear, location: 1)
        ],
        startPoint: .bottom,
        endPoint: .top)
    
    let motionManager = MotionManager()
    let masteryData: [MasteryResponse]
    var addToWatchlist: (User, Int) -> Void
    var removeFromWatchlist: (User, Int) -> Void
    
    @Bindable var user: User
    
    @State public var selectedPinnedMetric: String = "Season Milestone"
    @State var champSearchString: String = ""
    @State var showingNavTitle: Bool = false
    @FocusState var champSearchFocus: Bool

    init(
        masteryData: [MasteryResponse],
        user: User,
        addToWatchlist: @escaping (User, Int) -> Void,
        removeFromWatchlist: @escaping (User, Int) -> Void
    ) {
        self.masteryData = masteryData
        self.user = user
        self.addToWatchlist = addToWatchlist
        self.removeFromWatchlist = removeFromWatchlist
    }
    
    @State private var isFavourite = false
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
        Logger.views.debug("Watched champions retrieved: \(watchedChampions.map { $0.championId })")
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
            Logger.views.debug("Searching for: \(champSearchString)")
            return selectedSort.filter{
                getNameFromId(id: $0.championId).contains(champSearchString)
            }
        }
    }
    
    var masteryTens: Int {
        return masteryData.count(where: { $0.championLevel > 9 })
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            VStack{
                StickyHeaderScrollView(
                    isScrolled: $showingNavTitle,
                    name: user.name,
                    tag: user.tagline,
                    iconId: user.profileIconId,
                    score: user.masteryScore,
                    tens: masteryTens
                ){
                    if (user.championWatchlist.count > 0){
                        Watchlist(content: {
                            ForEach(watchedChampions, id: \.self){ entry in
                                NavigationLink(value: Route.champion(entry)){
                                    WatchlistItem(
                                        entry: entry,
                                        metric: selectedPinnedMetric,
                                        removeCallback: removeFromWatchlistCallback
                                    )
                                }
                            }
                        }, selectedMetric: $selectedPinnedMetric)
                        .padding(.horizontal, 6)
                    }
                    
                    ForEach(Array(searchResult.enumerated()), id: \.element) { (index, entry) in
                        NavigationLink(value: Route.champion(entry)) {
                            LargeChampionRow(entry: entry, addToWatchList: addToWatchlistCallback)
                                .if(canLevelUp(entry)) { view in
                                    view.modifier(LevelUpIndicator(offset: CGFloat(index)))
                                }
                        }
                    }
                    .padding(.horizontal, 6)
                    Rectangle().frame(height: 72).foregroundStyle(.clear)
                }
            }
            .ignoresSafeArea(.all)
            Rectangle()
                .foregroundStyle(gradient)
                .edgesIgnoringSafeArea(.bottom)
                .allowsHitTesting(false)
            SortSearchContainer(
                searchString: $champSearchString, toSortBy: $toSortBy, sortAsc: $sortAsc
            )
            .padding(.horizontal)
            .padding(.vertical, -8)
            .ignoresSafeArea(edges: .bottom)
        }
        .environmentObject(motionManager)
        .containerBackground(.clear, for: .navigation)
        .navigationBarTitleDisplayMode(.automatic)
        .navigationTitle(showingNavTitle ? "\(user.name) #\(user.tagline)" : "")
        .animation(.default, value: showingNavTitle)
        
    }
    
    func addToWatchlistCallback(champId: Int) {
        addToWatchlist(user, champId)
    }
    
    func removeFromWatchlistCallback(champId: Int) {
        removeFromWatchlist(user, champId)
    }
    
}

func canLevelUp(_ entry: MasteryResponse) -> Bool{
    return (entry.championPointsUntilNextLevel < 100 && (entry.markRequiredForNextLevel - entry.tokensEarned == 1))
}

func callbackPlaceholder(_ x: User, _ y: Int) -> Void {
    
}

struct SortSearchContainer: View {
    @Binding var searchString: String
    @Binding var toSortBy: String
    @Binding var sortAsc: Bool
    
    let sortOptions = ["Score", "Level", "Milestone", "Alphabetical"]
    
    var body: some View{
        if #available(iOS 26.0, *){
            GlassEffectContainer(){
                HStack(){
                    TextField("", text: $searchString, prompt: Text("Search Champions..."))
                        .padding()
                        .padding(.vertical, -2)
                        .clipShape(Capsule())
                        .scrollDismissesKeyboard(.interactively)
                        .glassEffect()
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
                            .padding(.vertical, -2)
                        }
                    }
                    .glassEffect()
                }
            }
        } else {
            HStack{
                TextField("", text: $searchString, prompt: Text("Search Champions..."))
                    .padding()
                    .padding(.vertical, -2)
                    .modifier(GlassOrMaterial(materialType: .regularMaterial))
                    .clipShape(Capsule())
                    .scrollDismissesKeyboard(.interactively)
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
                        .padding(.vertical, -2)
                    }
                }
                .modifier(GlassOrMaterial(materialType: .regularMaterial))
                .clipShape(Capsule())
            }
        }
    }
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
    @Previewable @State var path = [Route]()
    let mock = mockMasteryResponse
    NavigationStack(path: $path) {
        ZStack{
            BackgroundImage()
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
//            .ignoresSafeArea(.all)
        }
    }
}
