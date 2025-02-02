//
//  AccountScreen.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 13/07/2024.
//

import Foundation
import SwiftUI

struct AccountScreen: View{
    let masteryData: [MasteryResponse]
    let metrics: [MasteryResponseMetrics]
    
    // two lookup dictionaries that use champion id as a shared key
    let masteryDictionary: [Int: MasteryResponse]
    let metricsDictionary: [Int: MasteryResponseMetrics]
    
    let addFavourite: (String) -> Void

    init(masteryData: [MasteryResponse], addFavourite: @escaping (String) -> Void) {
        self.masteryData = masteryData
        self.metrics = GetResponseMetrics(masteryData)
        self.masteryDictionary = Dictionary(uniqueKeysWithValues: masteryData.map { ($0.championId, $0) })
        self.metricsDictionary = Dictionary(uniqueKeysWithValues: metrics.map { ($0.championId, $0) })
        self.addFavourite = addFavourite
    }
    
    @State private var isFavourite = false
    
    var sortOptions = ["Score", "Level", "Milestone"]
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
    var selectedSort: [MasteryResponse] {
        switch toSortBy{
        case "Score":
            return masteryData
        case "Level":
            return byLevel
        case "Milestone":
            return byMilestone
        default:
            return masteryData
        }
    }
    
    var body: some View {
        ZStack(alignment: .bottomTrailing){
            VStack{
                ScrollView(showsIndicators: false) {
                    LazyVStack{
                        ForEach(0..<selectedSort.count ,id: \.self){ index in
                            NavigationLink(value: selectedSort[index]){
                                LargeChampionRow(entry: selectedSort[index])
                            }
                        }
                    }
//                    VStack(spacing: 2){
//                        ForEach(3..<selectedSort.count, id: \.self){index in
//                            NavigationLink(value: selectedSort[index]){
//                                ChampionRow(entry: selectedSort[index])
//                            }
//                        }
//                    }
//                    .clipShape(RoundedRectangle(cornerRadius: 16))
                }
            }
            HStack{
                    Button{
                        isFavourite.toggle()
                        addFavourite(masteryData[0].puuid)
                    } label: {
                        ZStack{
                            Circle()
                                .frame(width: 48)
                                .foregroundStyle(.regularMaterial)
                            Image(systemName: isFavourite ? "star.fill" : "star")
                            .foregroundStyle(.white)}
                    }
                    .buttonStyle(.plain)
                Menu {
                    ForEach(sortOptions, id: \.self){ option in
                        Button(option, action: {toSortBy = option})
                    }
                } label : {
                    ZStack{
                        Circle()
                            .frame(width: 48)
                            .foregroundStyle(.regularMaterial)
                        Image(systemName: "arrow.up.arrow.down")
                            .foregroundStyle(.white)
                    }
                }.padding()
            }
        }
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
    
}
//
//#Preview {
//    let mock = mockMasteryResponse
//    AccountScreen(masteryData: mock)
//}
