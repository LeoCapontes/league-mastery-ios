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
    var withAvgColor: Bool
    @Binding var averageColor: Color
    
    init(championId: Int, averageColor: Binding<Color> = .constant(.clear), withAvgColor: Bool) {
        self.championId = championId
        self.blurred = false
        self._averageColor = averageColor
        self.withAvgColor = withAvgColor
    }
    
    init(championId: Int, averageColor: Binding<Color> = .constant(.clear)) {
        self.championId = championId
        self.blurred = false
        self._averageColor = averageColor
        self.withAvgColor = false
    }

    var body: some View {
        ZStack{
            if(withAvgColor){
                KFImage(URL(string: loadingScreenFromChampId(championId)))
                    .onSuccess { result in
                        let uiImage = result.image
                        if let avgUIColor = uiImage.dominantColor() {
                            averageColor = Color(avgUIColor)
                        } else {
                            print("failed")
                        }
                    }
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .blur(radius: (blurred ? 2 : 0))
                    .frame(width: 1, height: 1)
            }
            
            KFImage(URL(string: splashFromChampId(championId)))
                .onSuccess { result in
                    if(withAvgColor){
                        let uiImage = result.image
                        if let avgUIColor = uiImage.averageColor() {
                            //averageColor = Color(avgUIColor)
                            print(averageColor)
                        } else {
                            print("failed")
                        }
                    }
                }
                .resizable()
                .aspectRatio(contentMode: .fit)
                .blur(radius: (blurred ? 2 : 0))
                .frame(width: nil)
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
                .frame(height: geometry.size.height * 0.55)
                .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.75)
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
                    .frame(height: geometry.size.height * 0.75)
                    .position(x: geometry.size.width * 0.5, y: geometry.size.height * 0.75)
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
                ChampionImage(championId: entry.championId)
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
    var splashOffset: Offset {
        return splashOffsets[entry.championId] ?? Offset()
    }
    var addToWatchList: (Int) -> Void = placeholder
    
    let rowSplashMask = LinearGradient(
        stops: [
            Gradient.Stop(color: .black, location: 0.1),
            Gradient.Stop(color: .black.opacity(0.3), location: 0.8),
            Gradient.Stop(color: .clear, location: 1)
        ],
        startPoint: .trailing,
        endPoint: .leading)

    init(entry: MasteryResponse, addToWatchList: @escaping (Int) -> Void) {
        self.entry = entry
        self.addToWatchList = addToWatchList
    }
    
    init(entry: MasteryResponse) {
        self.entry = entry
    }
    
    var body: some View{
        ZStack{
            GeometryReader{ geometry in
                ZStack{
                    ChampionImage(championId: entry.championId)
                        .aspectRatio(contentMode: .fill)
                        .mask(rowSplashMask)
                        .offset(x: splashOffset.x, y: splashOffset.y)
                }
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
        .contextMenu{
            Button{
                addToWatchList(entry.championId)
            } label: {
                Label("Add to pinned", systemImage: "rectangle.stack.badge.plus")
            }
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

struct WatchlistItem: View {
    var entry: MasteryResponse
    var metric: String
    
    var removeCallback: (Int) -> Void
    
    var toDisplay: String {
        switch metric{
        case "Mastery Points":
            return entry.championPoints.compact()
        case "Season Milestone":
            return String(entry.championSeasonMilestone)
        case "Mastery Level":
            return String(entry.championLevel)
        default:
            return entry.championPoints.compact()
        }
    }
    
    var body: some View {
        GeometryReader{ geo in
            ZStack(alignment: .top){
                ZStack(alignment: .bottom){
                    Rectangle()
                        .frame(width: 52, height: 72)
                        .clipShape(
                            UnevenRoundedRectangle(
                                cornerRadii: RectangleCornerRadii(
                                    topLeading: 18,
                                    bottomLeading: 12,
                                    bottomTrailing: 12,
                                    topTrailing: 18
                                )
                            )
                        )
                        .foregroundStyle(.ultraThinMaterial)
                    Text(toDisplay)
                        .font(.system(size: 14))
                        .foregroundStyle(.white.opacity(0.9))
                        .padding(.bottom, 2)
                }
                
                KFImage(URL(string: portraitFromChampId(entry.championId)))
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                    .frame(width: 52, height: 52)
                    .clipShape(RoundedRectangle(cornerRadius: 18))
            }
            .contextMenu{
                Button{
                    removeCallback(entry.championId)
                } label: {
                    Label("Remove from pinned", systemImage: "rectangle.stack.badge.minus")
                }
            }        }
        .frame(width: 58)
    }
}

struct Watchlist<Content:View>: View {
    @ViewBuilder let content: Content
    var metrics = ["Mastery Points", "Season Milestone", "Mastery Level"]
    @Binding var selectedMetric: String
    
    var body: some View {
        ZStack{
            VStack(alignment: .leading, spacing: 0){
                HStack{
                    Text("Pinned")
                        .foregroundStyle(.white)
                        .padding(.horizontal, 12)
                        .padding(.top, 4)
                        .padding(.bottom, 2)
                    Spacer()
                    Picker("", selection: $selectedMetric) {
                        ForEach(metrics, id: \.self) {
                            Text($0)
                        }
                    }
                    .pickerStyle(.menu)
                    .accentColor(.gray)

                }
                Divider()
                ScrollView(.horizontal) {
                    HStack{
                        Spacer()
                        content
                        Spacer()
                    }
                }
                .scrollIndicators(.hidden)
                .padding(.top, 4)
                .padding(.bottom, 8)
            }
        }
        .frame(height: 120)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 12))
    }
    
}

func placeholder(_ i: Int) -> Void {
    
}

#Preview {
    @Previewable @State var selectedPinnedMetric: String = "Season Milestone"
    let mock = mockMasteryResponse
    ZStack {
        ScrollView{
            LargeChampionCard(entry: mock[1])
            let watched = Array(mock[0...6])
            Watchlist(content: {
                ForEach(0..<6) {index in
                    WatchlistItem(
                        entry: watched[index],
                        metric: selectedPinnedMetric,
                        removeCallback: placeholder
                    )
                }
            }, selectedMetric: $selectedPinnedMetric)
            LargeChampionRow(entry: mock[1], addToWatchList: placeholder)
            LargeChampionRow(entry: mock[0], addToWatchList: placeholder)
            LargeChampionRow(entry: mock[2], addToWatchList: placeholder)
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


