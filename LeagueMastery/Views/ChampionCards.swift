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
            return (mini ? path.appending("_mini") : path)
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
            AsyncImage(url: URL(
                    string: splashFromChampId(
                        championId
                    )
                )
            ) { image in image
                    .image?
                    .resizable()
                    .aspectRatio(contentMode: .fill)
                    .blur(radius: (blurred ? 12 : 0))
            }
            .frame(width: .infinity)
        }
    }
}

struct MasteryFrame: View {
    var championId: Int
    var masteryLevel: Int
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                VStack{
                    Image("mastery-banner-3")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(height: geometry.size.height * 0.5)
                .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.7)
                ZStack {
                    AsyncImage(url: URL(string: portraitFromChampId(championId))
                    ) {
                        image in image
                            .image?
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .scaleEffect(0.8)
                    }
                    Image("mastery_framecomplete")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(height: geometry.size.height * 0.85)
                .position(
                    CGPoint(
                        x: geometry.size.width * 0.5,
                        y: geometry.size.height * 0.35)
                )
                MasteryCrestImage(masteryLevel: masteryLevel, mini: false)
                    .frame(height: geometry.size.height * 0.75)
                    .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.8)
            }
        }
        .padding(EdgeInsets(top: 10, leading: 3, bottom: 6, trailing: 2))
    }
}

struct LargeChampionCard: View {
    var masteryLevel: Int
    var points: Int
    var championId: Int
    
    var body: some View {
        ZStack(){
            ChampionImage(championId: championId, blurred: true)
            HStack{
                MasteryCrestImage(masteryLevel: masteryLevel, mini: false)
                ZStack {
                    AsyncImage(url: URL(string: portraitFromChampId(championId))
                    ) {
                        image in image
                            .image?
                            .resizable()
                            .aspectRatio(contentMode: .fit)
                            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                            .scaleEffect(0.8)
                    }
                    Image("mastery_framecomplete")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
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
            MasteryFrame(championId: championId, masteryLevel: masteryLevel)
        }
        .frame(width: .infinity ,height: 124)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: /*@START_MENU_TOKEN@*/25.0/*@END_MENU_TOKEN@*/))
        .padding(1)
    }
}

#Preview {
    ZStack {
        VStack{
            Spacer()
            LargeChampionCard(masteryLevel: 10, points: 10000, championId: 4)
            HStack{
                MediumChampionCard(masteryLevel: 9, points: 1, championId: 1)
                MediumChampionCard(masteryLevel: 8, points: 2, championId: 2)
                MediumChampionCard(masteryLevel: 7, points: 3, championId: 3)
            }
            Spacer()
        }
        .padding()
    }
    .frame(width: .infinity, height:.infinity)
    .background(
        Image("background-mastery").resizable().aspectRatio(contentMode: .fill)
    )
    .ignoresSafeArea()
}


