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
        if(masteryLevel >= 4) {
            Image(masteryLevel >= 10 ? "masterycrest_level_10_art" : "masterycrest_level_\(masteryLevel)_art")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(12)
        } else {
            Image("masterycrest_level_0_art")
                .resizable()
                .aspectRatio(contentMode: .fit)
                .padding(12)
        }
    }
}

struct ChampionImage: View {
    var championId: Int
    
    var body: some View {
        AsyncImage(url: URL(string: ChampionIdConversions.init().urlsFromChampId[championId] ?? "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Aatrox_0.jpg"))
        { image in image
                .image?
                .resizable()
                .aspectRatio(contentMode: .fill)
                .clipped()
        }
        .frame(width: 200, height: 200)
    }
}

struct LargeChampionCard: View {
    var masteryLevel: Int
    var championId: Int
    
    var body: some View {
        ZStack(){
            HStack{
                MasteryCrestImage(masteryLevel: masteryLevel)
                ChampionImage(championId: 4)
            }
        }
        .background(.regularMaterial)
        .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
        
    }
}

#Preview {
    LargeChampionCard(masteryLevel: 6, championId: 1)
}


