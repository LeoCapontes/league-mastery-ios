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
    let expandUser: (String, String, String, String) -> Void
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
        return entries.map { entriesArray in
            Array(
                entriesArray
                    .sorted{ $0.championSeasonMilestone > $1.championSeasonMilestone }
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
    
    var currentChampId: Int {
        guard let currentArray = currentArray else {
            return 0
        }
        return currentArray[currentEntryIndex].championId
    }
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                if let _ = entries, let user = user, let currentArray = currentArray {
                    HStack{
                        KFImage(URL(string: profileIconUrl(profileIconId: user.profileIconId)))
                            .resizable()
                            .frame(width: 36, height: 36)
                            .aspectRatio(contentMode: .fit)
                            .background(.gray)
                            .clipShape(RoundedRectangle(cornerRadius: 4))
                        
                        UserInfoHeader(user: user)
                        Spacer()
                        
                    }
                    .frame(minWidth: 0, maxWidth: nil, alignment: .leading)
                    .padding(.horizontal)
                    .padding(.vertical, 8)
                    .onTapGesture {
                        expandUser(user.name, user.tagline, user.region, user.server)
                    }
                    
                    ZStack(){
                        Rectangle().foregroundStyle(.clear)
                        .background(alignment: .trailing) {
                            ZStack{
                                BackgroundChampionImage(
                                    championId: currentChampId
                                )
                                .id(slideShowCounter)
                                .transition(.opacity.animation(.easeOut))
                                .padding(-10)
                            }
                        }
                        .variableBlur(radius: 40) { geometryProxy, context in
                            // add a blur to the mask to smooth out where the variable blur begins
                            context.addFilter(.blur(radius: 0))
                            
                            context.fill(
                                Path(CGRect(origin: .zero, size: geometryProxy.size)),
                                with: .linearGradient(
                                    .init(colors: [.clear, .white]),
                                    startPoint: .init(x: geometryProxy.size.width - (geometryProxy.size.width*0.5), y: 0),
                                    endPoint: .init(x: geometryProxy.size.width - (geometryProxy.size.width*0.8), y: 0)
                                )
                            )
                        }
                        HStack{
                            VStack(alignment: .leading, spacing: 18){
                                Label("Can Level", systemImage: "")
                                    .onTapGesture {
                                        selectedMetric = .canLevel
                                        slideShowCounter = 0
                                    }
                                Divider()
                                    .frame(width: 100)
                                Label("Top 3", systemImage: "")
                                    .onTapGesture {
                                        selectedMetric = .topScore
                                    }
                                Divider()
                                    .frame(width: 100)
                                Label("Top Milestones", systemImage: "")
                                    .onTapGesture {
                                        selectedMetric = .topMilestone
                                    }
                                    
                            }
                            .foregroundStyle(.white)
                            .padding(.vertical, 20)
                            .padding(.horizontal)
//                            .border(.purple)
                            Spacer()
                            VStack(){
                                Spacer()
                                VStack(spacing: 0){
                                    Text("\(getNameFromId(id: currentChampId))")
                                        .bold()
                                        .font(.title3)
                                        .foregroundStyle(.white.opacity(0.75))
                                    GlanceableMetric(
                                        entry: currentArray[currentEntryIndex],
                                        selectedMetric: $selectedMetric
                                    )
                                }
                                .background{
                                    Rectangle()
                                        .foregroundStyle(.black.opacity(0.5))
                                        .blur(radius: 12)
                                }
                            }
                            .padding(.bottom, 4)
//                            .border(.red)
                            Spacer()
                        }
//                        .border(.blue)
                        .overlay {
                            cardOverlay
                                .overlay{
                                    RoundedRectangle(cornerRadius: 10)
                                        .frame(height: 48)
                                        .padding(8)
                                        .offset(x: 0, y: maskYOffset)
                                        .blendMode(.destinationOut)
                                }
                                .compositingGroup()
                                .allowsHitTesting(false)
                        }
                        .animation(.snappy.speed(2), value: maskYOffset)
                    }
                    .clipShape(RoundedRectangle(cornerRadius: 16))
                    
//                    .border(.yellow)
                } else {
                    Text("Favourite a user to see their stats here")
                        .padding()
                        .frame(minWidth: nil, maxWidth: .infinity, minHeight: 200)
                }
            }
            .background(.ultraThinMaterial.opacity(entries == nil ? 0.7 : 0.4))
            .onChange(of: isSettingUp) {
                Logger.views.debug("Pinned User: isSettingUp changed to: \(isSettingUp)")
            }
//            .border(.purple)
            
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

struct UserInfoHeader: View {
    var user: User
    
    var body: some View {
        VStack(alignment:.leading){
            HStack(alignment: .lastTextBaseline){
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
        .frame(alignment: .trailing)
        .offset(x: splashOffset.x, y: 0)
        .drawingGroup()
        .mask(cardMask)
    }
}

struct PinnedUserPreviewWrapper: View {
    @State private var settingUp: Bool = false

    var body: some View {
        ZStack {
            BackgroundImage()
            PinnedUser(
                expandUser: { _, _, _, _ in },
                entries: mockMasteryResponse,
                user: User(
                    puuid: "d",
                    name: "Hide on Bush",
                    tagline: "KR1",
                    region: "Korea",
                    server: "Asia",
                    profileIconId: 1,
                    summonerLevel: 999,
                    masteryScore: 999
                ),
                isSettingUp: $settingUp
            )
            .frame(height: 200)
            .padding(.horizontal)
        }
    }
}

struct PinnedUserPreviews: PreviewProvider {
    static var previews: some View {
        PinnedUserPreviewWrapper()
            .previewDevice(PreviewDevice(rawValue: "iPhone 13 mini"))
            .previewDisplayName("Pinned User: 13 Mini")
        PinnedUserPreviewWrapper()
            .previewDevice(PreviewDevice(rawValue: "iPhone 17 Pro"))
            .previewDisplayName("Pinned User: 17 Pro")
        PinnedUserPreviewWrapper()
            .previewDevice(PreviewDevice(rawValue: "iPhone 17 Pro Max"))
            .previewDisplayName("Pinned User: 17 Pro Max")
    }
}
