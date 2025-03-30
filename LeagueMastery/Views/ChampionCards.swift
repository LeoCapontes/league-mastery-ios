//
//  ChampionCards.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 09/07/2024.
//

import Foundation
import SwiftUI
import Kingfisher

struct MasteryCrestImage: View {
    var masteryLevel: Int
    var mini: Bool
    
    var assetPath: String {
        let path = ((masteryLevel >= 10)
                    ? "mastery-10"
                    : "mastery-\(masteryLevel)")
        
        return (mini ? path.appending("_mini") : path)
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
            KFImage(URL(string: splashFromChampId(championId)))
                .resizable()
                .aspectRatio(contentMode: .fit)
                .blur(radius: (blurred ? 2 : 0))
                .frame(width: .infinity)
        }
    }
}

struct ChampionPortrait: View {
    var championId: Int
    
    var body: some View {
        KFImage(URL(string: portraitFromChampId(championId)))
            .resizable()
            .aspectRatio(contentMode: .fit)
            .clipShape(/*@START_MENU_TOKEN@*/Circle()/*@END_MENU_TOKEN@*/)
            .scaleEffect(0.8)
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

struct LargeChampionRow: View {
    var entry: MasteryResponse
    
    
    let rowSplashMask = LinearGradient(
        stops: [
            Gradient.Stop(color: .black, location: 0.1),
            Gradient.Stop(color: .black.opacity(0.1), location: 0.6),
            Gradient.Stop(color: .clear, location: 1)
        ],
        startPoint: .trailing,
        endPoint: .leading)

    
    var body: some View{
        ZStack{
            GeometryReader{ geometry in
                ChampionImage(championId: entry.championId, blurred: false)
                    .aspectRatio(contentMode: .fill)
                    .mask(rowSplashMask)
                    .offset(y: -25)
                ZStack{
                    MasteryFrame(
                        championId: entry.championId,
                        masteryLevel: entry.championLevel
                    )
                    .position(
                        x:geometry.size.width*0.15,
                        y:geometry.size.height*0.5
                    )
                    VStack(alignment: .leading){
                        Text("\(namesFromChampId[entry.championId]!)")
                            .bold()
                            .font(.title2)
                        Text("Level \(entry.championLevel)")
                            .font(.system(size: 14))
                        Text("\(entry.championPoints) pts")
                            .font(.system(size: 14))
                    }
                    .foregroundStyle(.white)
                    .frame(width: 150, alignment: .leading)
                    .position(
                        x: geometry.size.width*0.5,
                        y: geometry.size.height*0.5
                    )
                }.frame(width:nil)
            }
            .background(
                .ultraThinMaterial
                    .opacity(0.5)
            )
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .frame(width: nil, height:100)
        }
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
                        y: geometry.size.height * 0.5
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
        .frame(width: .infinity, height: 56)
        .clipped()
    }
}

#Preview {
    let mock = mockMasteryResponse
    ZStack {
        ScrollView{
            LargeChampionCard(entry: mock[1])
//            HStack{
//                MediumChampionCard(entry: mock[1])
//                MediumChampionCard(entry: mock[2])
//                MediumChampionCard(entry: mock[0])
//            }
            LargeChampionRow(entry: mock[1])
            LargeChampionRow(entry: mock[0])
            LargeChampionRow(entry: mock[2])
            VStack(spacing: 2){
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


