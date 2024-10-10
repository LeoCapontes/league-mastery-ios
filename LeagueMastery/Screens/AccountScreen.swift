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
    
    var byLevel: [MasteryResponse] {
        return masteryData.sorted{$0.championLevel < $1.championLevel}
    }
    
    var selectedSort: [MasteryResponse] {
        //placeholder
        return masteryData
    }
    
    let sortOptions = ["Score", "Level"]
    
    var body: some View {
            ZStack{
                ScrollView(showsIndicators: false) {
                    LazyVStack{
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
                        ForEach(4..<selectedSort.count){index in
                            NavigationLink(value: selectedSort[index]){
                                ChampionRow(entry: selectedSort[index])
                            }
                        }
                    }
                }
            }
            .navigationDestination(for: MasteryResponse.self){ entry in
                ChampionScreen(championData: entry)
            }
    }

}
