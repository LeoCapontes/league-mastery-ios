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
                    LargeChampionCard(entry: masteryData[0])
                    HStack{
                        ForEach(1..<4){ index in
                            MediumChampionCard(entry: masteryData[index])
                        }
                    }
                    ForEach(4..<masteryData.count){index in
                        ChampionRow(entry: masteryData[index])
                    }
                }
            }
        }
    }
    
   
    

}
