//
//  PinnedUser.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 04/01/2026.
//
import SwiftUI
import Foundation
import Kingfisher

let cardMask = LinearGradient(
    stops: [
        Gradient.Stop(color: .black, location: 0.5),
        Gradient.Stop(color: Color.black.opacity(0.25), location: 1)
    ],
    startPoint: .trailing,
    endPoint: .leading)

let cardOverlay = LinearGradient(
    stops: [
        Gradient.Stop(color: .clear, location: 0.4),
        Gradient.Stop(color: .black.opacity(0.6), location: 0.8),
        Gradient.Stop(color: Color.black.opacity(0.7), location: 1)
    ],
    startPoint: .trailing,
    endPoint: .leading)

enum UserMetric {
    case canLevel
    case topScore
    case topMilestone
}


struct PinnedUser: View {
    var entries: [MasteryResponse]
    var user: User
    @State var slideShowCounter: Int = 0
    @State var selectedMetric: UserMetric = .canLevel
    
    var maskYOffset: Double {
        switch selectedMetric {
        case .canLevel:
            return -58
        case .topScore:
            return 0
        case .topMilestone:
            return 58
        }
    }
    
    var top3Entries: [MasteryResponse] {
        return Array(entries.prefix(3))
    }
    
    var canLevelEntries: [MasteryResponse] {
        return entries.filter { $0.championPointsUntilNextLevel < 0}
    }
    
    var topMilestoneEntries: [MasteryResponse] {
        return Array(
            entries
                .sorted{ $0.championSeasonMilestone < $1.championSeasonMilestone }
                .prefix(3)
        )
    }
    
    var currentArray: [MasteryResponse] {
        switch selectedMetric {
        case .canLevel:
            return canLevelEntries
        case .topScore:
            return top3Entries
        case .topMilestone:
            return topMilestoneEntries
        }
    }
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                HStack{
                    KFImage(URL(string: profileIconUrl(profileIconId: 1)))
                        .resizable()
                        .frame(width: 36, height: 36)
                        .background(.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                    
                    VStack(alignment:.leading){
                        HStack(alignment: .top){
                            Text(user.name)
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(.white)
                            Text("#\(user.tagline)")
                                .font(.system(size: 10))
                                .foregroundStyle(.gray)
                        }
                        Text("Score: \(user.masteryScore)")
                            .font(.system(size: 14))
                            .foregroundStyle(.gray)
                    }
                    
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.vertical, 8)
    //            .border(.green)

                ZStack(){
                    BackgroundChampionImage(championId: currentArray[(slideShowCounter % currentArray.count)].championId)
                        .id(slideShowCounter)
                        .transition(.opacity.animation(.easeOut))
                        .padding(-10)
                    //            .border(.green)
                        .overlay {
                            cardOverlay
                                .overlay{
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(width: 360, height: 48)
                                        .offset(x: 0, y: maskYOffset)
                                        .blendMode(.destinationOut)
                                }
                                .compositingGroup()
                        }
                        .animation(.snappy.speed(2), value: maskYOffset)
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 18){
                            Label("Can Level", systemImage: "")
                                .onTapGesture {
                                    selectedMetric = .canLevel
                                    slideShowCounter = 0
                                }
                                .foregroundStyle(selectedMetric == .canLevel ? .white : .gray)
                            Divider()
                                .frame(width: 100)
                            Label("Top 3", systemImage: "")
                                .onTapGesture {
                                    selectedMetric = .topScore
                                }
                                .foregroundStyle(selectedMetric == .topScore ? .white : .gray)
                            Divider()
                                .frame(width: 100)
                            Label("Top Milestones", systemImage: "")
                                .onTapGesture {
                                    selectedMetric = .topMilestone
                                }
                                .foregroundStyle(selectedMetric == .topMilestone ? .white : .gray)
                        }
                        Spacer()
                        VStack(){
                            Spacer()
                            VStack(spacing: 0){
                                Text("\(getNameFromId(id: currentArray[(slideShowCounter % currentArray.count)].championId))")
                                    .bold()
                                    .font(.title3)
                                    .scaledToFill()
                                    .foregroundStyle(.white.opacity(0.75))
//                                    .border(.green)
                                GlanceableMetric(
                                    entry: currentArray[(slideShowCounter % currentArray.count)],
                                    selectedMetric: $selectedMetric
                                )
//                                    .border(.green)
                            }
                            .background{
                                Rectangle()
                                    .foregroundStyle(.black.opacity(0.5))
                                    .blur(radius: 12)
                            }
                        }
                        Spacer()
                    }
                    .padding()
                }
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .frame(minWidth: nil, maxWidth: nil, minHeight: 186, maxHeight: .infinity)
                //        .border(.green)
            }
            .background(.ultraThinMaterial.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal)
    //        .border(.red)
        }
        .task(delayText)
        
    }
    
    func delayText() async {
        while !Task.isCancelled {
            do {
                try await Task.sleep(nanoseconds: 3_500_000_000)
            } catch {
                break
            }

            slideShowCounter += 1
            print("incremented")
        }
    }
}

struct GlanceableMetric: View {
    var entry: MasteryResponse
    @Binding var selectedMetric: UserMetric
    
    var body: some View {
        switch selectedMetric {
        case .canLevel:
            LevelUpReadyMetric(entry: entry)
        case .topScore:
            TopLevelMetric(entry: entry)
        case .topMilestone:
            TopMilestonesMetric(entry: entry)
        }
    }
}

struct LevelUpReadyMetric: View {
    var entry: MasteryResponse
    
    var noChangeInIcon: Bool {
        entry.championLevel > 9
    }
    
    var body: some View {
        HStack{
            VStack(spacing: 0){
                if(noChangeInIcon) {
                    Text("\(entry.championLevel)")
                        .padding(.bottom, -6)
                }
                MasteryCrestImage(masteryLevel: entry.championLevel, mini: false)
            }
            Image(systemName: "arrow.right")
            VStack(spacing: 0){
                if(noChangeInIcon) {
                    Text("\(entry.championLevel + 1)")
                        .padding(.bottom, -6)
                }
                MasteryCrestImage(masteryLevel: entry.championLevel + 1, mini: false)
            }
        }
        .foregroundStyle(.white)
        .bold()
        .frame(maxWidth: 125)
    }
}

struct TopLevelMetric: View {
    var entry: MasteryResponse
    
    var body: some View {
        HStack {
            Text("Level \(entry.championLevel)")
            Text("\(entry.championPoints) pts")
        }
//        .frame(maxWidth: 125)
        .foregroundStyle(.white.opacity(0.9))
        .font(.subheadline)
        .padding(.horizontal)
    }
}

struct TopMilestonesMetric: View {
    var entry: MasteryResponse
    
    var body: some View {
        HStack {
            Text("Milestone \(entry.championSeasonMilestone)")
            Spacer()
            Image("mastery-mark")
                .resizable()
                .scaledToFit()
                .frame(width: 28)
            Text("x\(entry.tokensEarned)")
        }
        .foregroundStyle(.white.opacity(0.9))
        .font(.subheadline)
        .padding(.horizontal)
    }
}

struct BackgroundChampionImage: View {
    @State var bgColor: Color = .black
    
    var championId: Int
    var splashOffset: Offset {
        return splashOffsets[championId] ?? Offset()
    }
    
    var body: some View {
        HStack(spacing: 0){
            ChampionImage(
                championId: championId)
            .scaleEffect(x:-1, y: 1)
            ChampionImage(
                championId: championId)
        }
        .aspectRatio(contentMode: .fill)
        .offset(x: splashOffset.x, y: 0)
        .frame(width: 400, alignment: .trailing)
        .drawingGroup()
        //            .overlay(avgGradient(Color(
        //                red: bgColor.components()[0] * 0.25,
        //                green: bgColor.components()[1] * 0.25,
        //                blue: bgColor.components()[2] * 0.25
        //            )))
        .variableBlur(radius: 10) { geometryProxy, context in
            // add a blur to the mask to smooth out where the variable blur begins
            context.addFilter(.blur(radius: 0))
            
            context.fill(
                Path(CGRect(origin: .zero, size: geometryProxy.size)),
                with: .linearGradient(
                    .init(colors: [.clear, .white]),
                    startPoint: .init(x: geometryProxy.size.width - (geometryProxy.size.width*0.5), y: 0),
                    endPoint: .init(x: geometryProxy.size.width - (geometryProxy.size.width*0.75), y: 0)
                )
            )
        }
        .mask(cardMask)
    }
    
}

#Preview {
    @Previewable @State var bgColor: Color = Color("BGColor")
    let mock = mockMasteryResponse
    let user = User(
        puuid: "d",
        name: "Hide on Bush",
        tagline: "KR1",
        region: "Korea",
        server: "Asia",
        profileIconId: 1,
        summonerLevel: 999,
        masteryScore: 999
    )
    let mockIndex = 40
    var splashOffset: Offset {
        return splashOffsets[mock[mockIndex].championId] ?? Offset()
    }
    ZStack{
        BackgroundImage()
        PinnedUser(entries: mock, user: user)
            .frame(height: 200)
    }
}
