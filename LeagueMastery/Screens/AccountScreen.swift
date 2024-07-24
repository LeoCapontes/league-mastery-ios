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
    
    var body: some View {
        ZStack{
            ScrollView(showsIndicators: false) {
                LazyVStack{
                    LargeChampionCard(
                        masteryLevel: masteryData[0].championLevel,
                        points: masteryData[0].championPoints,
                        championId: masteryData[0].championId)
                    HStack{
                        ForEach(1..<4){ index in
                            MediumChampionCard(
                                masteryLevel: masteryData[index].championLevel,
                                points: masteryData[index].championPoints,
                                championId: masteryData[index].championId
                            )
                        }
                    }
                    ForEach(4..<masteryData.count){index in
                        ChampionRow(
                            masteryLevel: masteryData[index].championLevel,
                            points: masteryData[index].championPoints,
                            championId: masteryData[index].championId
                        )
                    }
                }
            }
        }
    }
    

}
