//
//  PinnedUser.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 04/01/2026.
//
import SwiftUI
import Foundation
import Kingfisher
import OSLog

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
    var entries: [MasteryResponse]?
    var user: User?
    @Binding var isSettingUp: Bool
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
    
    var top3Entries: [MasteryResponse]? {
        return entries.map { Array($0.prefix(3))}
    }
    
    var canLevelEntries: [MasteryResponse]? {
        return entries.map { array in
            array.filter { canLevelUp($0) }
        }
    }
    
    var topMilestoneEntries: [MasteryResponse]? {
        return  entries.map { entriesArray in
            Array(
                entriesArray
                    .sorted{ $0.championSeasonMilestone < $1.championSeasonMilestone }
                    .prefix(3)
            )
        }
    }
    
    var currentArray: [MasteryResponse]? {
        switch selectedMetric {
        case .canLevel:
            return canLevelEntries
        case .topScore:
            return top3Entries
        case .topMilestone:
            return topMilestoneEntries
        }
    }
    
    var currentEntryIndex: Int {
        guard let currentArray = currentArray else{
            return 0
        }
        return (slideShowCounter % currentArray.count)
    }
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                if let entries = entries, let user = user {
                    HStack{
                        KFImage(URL(string: profileIconUrl(profileIconId: user.profileIconId)))
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
                        Spacer()
                        
                    }
                    .frame(minWidth: 0, maxWidth: nil, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    //            .border(.green)
                    
                    ZStack(){
                        BackgroundChampionImage(
                            championId: currentArray![currentEntryIndex].championId
                        )
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
                            .padding()
                            Spacer()
                            VStack(){
                                Spacer()
                                VStack(spacing: 0){
                                    Text("\(getNameFromId(id: currentArray![currentEntryIndex].championId))")
                                        .bold()
                                        .font(.title3)
                                        .scaledToFill()
                                        .foregroundStyle(.white.opacity(0.75))
                                    //                                    .border(.green)
                                    GlanceableMetric(
                                        entry: currentArray![currentEntryIndex],
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
                            .padding(.bottom, 4)
                            Spacer()
                        }
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    .frame(minHeight: 186, maxHeight: .infinity)
//                            .border(.green)
                } else {
                    Text("Favourite a user to see their stats here")
                        .padding()
                        .frame(minWidth: nil, maxWidth: .infinity, minHeight: 200, maxHeight: .infinity)
                }
            }
            .background(.ultraThinMaterial.opacity(entries == nil ? 0.7 : 0.4))
            .onChange(of: isSettingUp) {
                Logger.views.debug("Pinned User: isSettingUp changed to: \(isSettingUp)")
            }
            
//            .border(.red)
            Rectangle()
                .background(.clear)
                .foregroundStyle(.ultraThinMaterial.opacity(isSettingUp ? 1 : 0))
                .animation(.default, value: isSettingUp)
        }
        .clipShape(RoundedRectangle(cornerRadius: 16))
        .onChange(of: isSettingUp) {
            slideShowCounter = 0
        }
//        .border(.green)
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
        }
    }
    
    func canLevelUp(_ entry: MasteryResponse) -> Bool{
        return (entry.championPointsUntilNextLevel < 100 && (entry.markRequiredForNextLevel - entry.tokensEarned == 1))
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
                .padding(.bottom)
        case .topMilestone:
            TopMilestonesMetric(entry: entry)
                .padding(.bottom)
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
            GradesContainer(
                requiredGrades: entry.requiredGrades(),
                achievedGrades: entry.achievedGrades()
            )
            Image(systemName: "arrow.right")
            VStack(spacing: 0){
                if(noChangeInIcon) {
                    Text("\(entry.championLevel + 1)")
                        .padding(.bottom, -16)
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
    @Previewable @State var settingUp: Bool = false
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
        PinnedUser(entries: mock, user: user, isSettingUp: $settingUp)
            .frame(height: 200)
            .padding(.horizontal)
    }
}
