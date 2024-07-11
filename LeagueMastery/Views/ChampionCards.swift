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
    var mini: Bool
    
    var assetPath: String {
        if(masteryLevel >= 4) {
            let path = ((masteryLevel >= 10)
                        ? "masterycrest_level_10_art"
                        : "masterycrest_level_\(masteryLevel)_art")
            
            return (mini ? path.appending("_mini") : path)
        } else {
            let path = "masterycrest_level_0_art"
            return (mini ? path.appending("mini") : path)
        }
    }
    
    var body: some View {
        Image(assetPath)
            .resizable()
            .aspectRatio(contentMode: .fit)
            .padding(12)
    }
}

struct ChampionImage: View {
    var championId: Int
    var blurred: Bool
    
    var body: some View {
        ZStack{
            AsyncImage(url: URL(string: ChampionIdConversions.init().urlsFromChampId[championId] ?? "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/Aatrox_0.jpg"))
            { image in image
                    .image?
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .blur(radius: (blurred ? 10 : 0))
            }
            .frame(height: .infinity)
            .padding(EdgeInsets(top: 0, leading: 0, bottom: 0, trailing: 8))
        }
    }
}

struct LargeChampionCard: View {
    var masteryLevel: Int
    var points: Int
    var championId: Int
    
    var body: some View {
        ZStack(){
            HStack{
                ChampionImage(championId: championId, blurred: true)
            }
            HStack{
                MasteryCrestImage(masteryLevel: masteryLevel)
                ChampionImage(championId: championId, blurred: false)
            }
            .frame(width: .infinity, height: .infinity)
            HStack {
                VStack{
                    Spacer()
                    Spacer()
                    Text("  Points: \(points)  ")
                        .background(.ultraThinMaterial)
                        .clipShape(Capsule())
                }
                Spacer()
            }
            .padding(EdgeInsets(top: 0, leading: 28, bottom: 24, trailing: 0))
        }
        .frame(width: .infinity ,height: 200)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
    }
}

struct MediumChampionCard: View {
    var masteryLevel: Int
    var points: Int
    var championId: Int
    
    var body: some View {
        ZStack(){
            HStack{
                MasteryCrestImage(masteryLevel: masteryLevel)
                ChampionImage(championId: championId, blurred: false)
            }
            .frame(width: .infinity, height: .infinity)
            .padding(12)
            HStack {
                Spacer()
                VStack{
                    Spacer()
                    Spacer()
                    Spacer()
                    Spacer()
                    Text("  Points: \(points)  ")
                        .background(.ultraThinMaterial)
                        .clipShape(Capsule())
                    Spacer()
                }
                Spacer()
            }
        }
        .frame(width: .infinity ,height: 124)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
        .padding(1)
    }
}

#Preview {
    VStack{
        Spacer()
        LargeChampionCard(masteryLevel: 9, points: 10000, championId: 3)
        HStack{
            MediumChampionCard(masteryLevel: 8, points: 800, championId: 2)
            MediumChampionCard(masteryLevel: 7, points: 700, championId: 3)
        }
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
        Spacer()
    }
    .padding()
    .background(Image("background-mastery").resizable().aspectRatio(contentMode: /*@START_MENU_TOKEN@*/.fill/*@END_MENU_TOKEN@*/))
    .ignoresSafeArea()
}


