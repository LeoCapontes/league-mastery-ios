//
//  AccountScreen.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 13/07/2024.
//

import Foundation
import SwiftUI

struct AccountScreen: View{
    var masteryData: [MasteryResponse]
    
    var sortOptions = ["Score", "Level"]
    @State private var toSortBy = "Score"
    
    var byLevel: [MasteryResponse] {
        return masteryData.sorted{$0.championLevel > $1.championLevel}
    }
    
    var selectedSort: [MasteryResponse] {
        switch toSortBy{
        case "Score":
            return masteryData
        case "Level":
            return byLevel
        default:
            return masteryData
        }
    }
    
    var body: some View {
            ZStack{
                VStack{
                    ScrollView(showsIndicators: false) {
                        NavigationLink(value: selectedSort[0]){
                            LargeChampionCard(entry: selectedSort[0])
                        }
                        HStack{
                            ForEach(1..<4){ index in
                                NavigationLink(value: selectedSort[index]){
                                    MediumChampionCard(entry: selectedSort[index])
                                }
                            }
                        }
                        VStack{
                            ForEach(4..<selectedSort.count){index in
                                NavigationLink(value: selectedSort[index]){
                                    ChampionRow(entry: selectedSort[index])
                                }
                            }
                        }
                        .clipShape(RoundedRectangle(cornerRadius: 16))
                    }
                    Picker("Sort by: ", selection: $toSortBy) {
                        ForEach(sortOptions, id: \.self){ option in
                            Text(option)
                        }
                    }
                }
            }
            .navigationDestination(for: MasteryResponse.self){ entry in
                ChampionScreen(championData: entry)
            }
    }

}
