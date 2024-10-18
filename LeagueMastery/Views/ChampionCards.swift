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
                    .aspectRatio(contentMode: .fit)
                    .blur(radius: (blurred ? 8 : 0))
            }
            .frame(width: .infinity)
        }
    }
}

struct ChampionPortrait: View {
    var championId: Int
    
    var body: some View {
        AsyncImage(url: URL(string: portraitFromChampId(championId))
        ) {
            image in image
                .image?
                .resizable()
                .aspectRatio(contentMode: .fit)
                .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
                .scaleEffect(0.8)
        }
    }
}

struct MasteryBanner: View {
    var masteryLevel: Int
    
    var body: some View{
        Image(
            (masteryLevel>=10) ?
              "mastery-banner-3" : (
                (masteryLevel>=4) ? 
                "mastery-banner-2" : "mastery-banner-1"
              )
        )
        .resizable()
        .aspectRatio(contentMode: .fit)
    }
}

struct MasteryFrame: View {
    var championId: Int
    var masteryLevel: Int
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack{
                VStack{
                    MasteryBanner(masteryLevel: masteryLevel)
                }
                .frame(height: geometry.size.height * 0.5)
                .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.7)
                ZStack {
                    ChampionPortrait(championId: championId)
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
                    .frame(height: geometry.size.height * 0.5)
                    .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.8)
            }
        }
        .padding(EdgeInsets(top: 10, leading: 3, bottom: 6, trailing: 2))
    }
}

struct LargeChampionCard: View {
    var entry: MasteryResponse
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack(){
                // negative padding removes negative space around edges
                // caused by blurring
                ChampionImage(championId: entry.championId, blurred: true)
                    .aspectRatio(contentMode: .fill)
                    .padding(-8)

                MasteryCrestImage(masteryLevel: entry.championLevel, mini: false)
                    .frame(height: geometry.size.height * 0.9)
                    .position(
                        x: geometry.size.width * 0.25,
                        y: geometry.size.height * 0.45)
                
                ZStack {
                    ChampionPortrait(championId: entry.championId)
                        .padding(-4)
                    Image("mastery_framecomplete")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                .frame(height: geometry.size.height*0.9)
                .position(
                    x: geometry.size.width * 0.725,
                    y: geometry.size.height * 0.5
                )
                
                Text("Points: \(entry.championPoints)")
                    .padding(.horizontal, 12)
                    .padding(.vertical, 2)
                    .background(.ultraThinMaterial)
                    .clipShape(Capsule())
                    .position(
                        x: geometry.size.width * 0.25,
                        y: geometry.size.height * 0.8
                    )

            }
        }
        .frame(width: .infinity ,height: 200)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 16))
    }
}

struct MediumChampionCard: View {
    var entry: MasteryResponse
    
    var body: some View {
        ZStack(){
            MasteryFrame(championId: entry.championId, masteryLevel: entry.championLevel)
        }
        .frame(width: .infinity ,height: 124)
        .background{
            Color.gray
                .opacity(0.2)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .padding(1)
    }
}

struct ChampionRow: View {
    var entry: MasteryResponse
    
    var body: some View {
        GeometryReader { geometry in
            ZStack(alignment: .leading) {
                Text(namesFromChampId[entry.championId]!)
                    .foregroundStyle(.white)
                    .multilineTextAlignment(.leading)
                    .bold()
                    .padding()
                
                MasteryCrestImage(masteryLevel: entry.championLevel, mini: true)
                    .padding(4)
                    .position(
                        x: geometry.size.width * 0.45,
                        y: geometry.size.height * 0.6
                    )
                
                Text("\(entry.championPoints) pts")
                    .foregroundStyle(.white)
                    .position(
                        x: geometry.size.width * 0.7,
                        y: geometry.size.height * 0.5
                    )
                Image(systemName: "")
            }
            .background{
                Color.gray
                    .opacity(0.2)
            }
        }
        .frame(width: .infinity, height: 50)
        .clipped()
    }
}

#Preview {
    let mock = mockMasteryResponse
    ZStack {
        ScrollView{
            LargeChampionCard(entry: mock[0])
            HStack{
                MediumChampionCard(entry: mock[1])
                MediumChampionCard(entry: mock[2])
                MediumChampionCard(entry: mock[0])
            }
            VStack{
                ForEach(3..<45) { index in
                    ChampionRow(entry: mock[0])
                }
            }
            .clipShape(RoundedRectangle(cornerRadius: 16))
        }
        .padding()
    }
    
    .frame(width: .infinity, height:.infinity)
    .background(
        Image("background-mastery").resizable().aspectRatio(contentMode: .fill)
    )
    .ignoresSafeArea()
}


