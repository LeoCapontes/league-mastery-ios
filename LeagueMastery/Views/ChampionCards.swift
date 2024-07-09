//
//  ChampionCards.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 09/07/2024.
//

import Foundation
import SwiftUI

struct MasteryCrestImage: View {
    var masteryLevel: Int
    var body: some View {
        Image(masteryLevel >= 10 ? "masterycrest_level_10_art" : "masterycrest_level_\(masteryLevel)_art")
    }
}

struct LargeChampionCard: View {
    var masteryLevel: Int
    var championId: Int
    
    var body: some View {
        ZStack(){
            HStack{
                MasteryCrestImage(masteryLevel: masteryLevel)
                AsyncImage(url: URL(string: ChampionSplashUrls.init().urlsFromChampId[championId] ?? "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Aatrox_0.jpg"))
            }
        }
    }
}

#Preview {
    LargeChampionCard(masteryLevel: 1, championId: 1)
}


