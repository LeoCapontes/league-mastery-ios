//
//  ChampionScreen.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 29/09/2024.
//

import SwiftUI
import AVKit
import Variablur

let gradientMask = LinearGradient(
    stops: [
        Gradient.Stop(color: .black, location: 0.66),
        Gradient.Stop(color: .clear, location: 1)
    ],
    startPoint: .top,
    endPoint: .bottom)


func avgGradient(_ color: Color) -> LinearGradient{
    return LinearGradient(
        stops: [
            Gradient.Stop(color: .clear, location: 0.3),
            Gradient.Stop(color: color, location: 1)
        ],
        startPoint: .top,
        endPoint: .bottom
    )
}

let radialGradientMask = RadialGradient(
    stops: [
        Gradient.Stop(color: .black, location: 0.66),
        Gradient.Stop(color: .clear, location: 1)
    ],
    center: .top,
    startRadius: 150,
    endRadius: 375
)

let leftScrollMask = LinearGradient(
    stops: [
        Gradient.Stop(color: .black, location: 0.85),
        Gradient.Stop(color: .clear, location: 1)
    ],
    startPoint: .trailing,
    endPoint: .leading)

let rightScrollMask = LinearGradient(
    stops: [
        Gradient.Stop(color: .black, location: 0.85),
        Gradient.Stop(color: .clear, location: 1)
    ],
    startPoint: .leading,
    endPoint: .trailing)

struct ChampionScreen: View {
    var championData: MasteryResponse
    
    init(championData: MasteryResponse) {
        self.championData = championData
    }
    
    @State var bgColor: Color = Color("BGColor")
    @State var champImage: ChampionImage? = nil
    
    // Animation states
    @State var barFilled: Bool = false
    
    var videoUrl: String {
        let level: Int
        if championData.championLevel > 10 {
            level = 10
        } else {
            level = championData.championLevel
        }
        return "\(level)-loop"
    }
    
    var crestScale: CGFloat {
        return vidScale(lvl: championData.championLevel)
    }
    
    var auroraUnlocked: Bool {
        return (championData.championSeasonMilestone >= 4)
    }
    
    var body: some View {
        ZStack{
            Rectangle()
                .edgesIgnoringSafeArea(.all)
                .foregroundStyle(Color(
                    red: bgColor.components()[0] * 0.25,
                    green: bgColor.components()[1] * 0.25,
                    blue: bgColor.components()[2] * 0.25
                ))
            
            VStack(spacing: 0){
                ChampionImage(
                    championId: championData.championId, averageColor: $bgColor, withAvgColor: true)
                    .frame(width: 550)
                ChampionImage(
                    championId: championData.championId, averageColor: $bgColor, withAvgColor: true)
                    .frame(width: 550)
                    .scaleEffect(x: 1, y: -1)
                    .mask(gradientMask)
                    .mask(radialGradientMask)
                Spacer()
            }
            .drawingGroup()
            .overlay(avgGradient(Color(
                red: bgColor.components()[0] * 0.25,
                green: bgColor.components()[1] * 0.25,
                blue: bgColor.components()[2] * 0.25
            )))
            .variableBlur(radius: 180) { geometryProxy, context in
                // add a blur to the mask to smooth out where the variable blur begins
                context.addFilter(.blur(radius: 50))
                
                context.fill(
                    Path(CGRect(origin: .zero, size: geometryProxy.size)),
                    with: .linearGradient(
                        .init(colors: [.clear, .white]),
                        startPoint: .init(x: 0, y: geometryProxy.size.height - 600),
                        endPoint: .init(x: 0, y: geometryProxy.size.height)
                    )
                )
            }
            VStack{
                Spacer()
                Spacer()
                Spacer()
                ZStack{
                    if(auroraUnlocked) {
                        VideoPlayer(url: "crest-aurora-loop-new")
                            .padding(-50)
                            .frame(width: 300, height: 300)
                            .offset(x:0 ,y: 15)
                            .shadow(color: .black, radius: 30)
                    }
                    MasteryCrestImage(masteryLevel: championData.championLevel, mini: false)
                        
                }
                .shadow(color: auroraUnlocked ? .clear : .black, radius: 30)
                .frame(width: 300, height: 300)
                .padding(-40)
                
                MasteryMarks(
                    requiredMarks: championData.markRequiredForNextLevel,
                    earnedMarks: championData.tokensEarned)
                .frame(width: nil, height: 40)
                .padding(.bottom, -6)
                
                InfoContainer(championData: championData)
                
                VStack() {
                    ProgressBar(
                        total: championData.pointsInLevel(),
                        progress: championData.championPointsSinceLastLevel,
                        finishedAnimation: $barFilled
                    )
                    .frame(width: 200, height: 12)
                    if canLevelUp(championData){
                        if(barFilled) {
                            LevelUpBadge()
                                .fixedSize()
                        }
                    }
                }
                .frame(height: 32)
                .padding(.bottom)
                .animation(.snappy, value: barFilled)
                
                GradesContainer(
                    requiredGrades: championData.requiredGrades(),
                    achievedGrades: championData.achievedGrades())
            
                ScrollView(.horizontal){
                    ZStack{
                        HStack{
                            MilestoneProgress(
                                currentMilestone: championData.championSeasonMilestone
                            )
                            .frame(width: 500, height: 100)
                            .padding(.horizontal, 30)
                            .padding(.trailing, 60)
                            
                        }
                        HStack{
                            Spacer()
                        }
                    }
                }
                .scrollIndicators(.hidden)
                .frame(width: 400, height: 150)
                .mask(leftScrollMask)
                .mask(rightScrollMask)
                Spacer()
                Spacer()
            }
            .padding()
        }
        .ignoresSafeArea()
    }
    
    func canLevelUp(_ entry: MasteryResponse) -> Bool{
        return (entry.championPointsUntilNextLevel < 100 && (entry.markRequiredForNextLevel - entry.tokensEarned == 1))
    }
}

struct LevelUpBadge: View {
    var body: some View {
        ZStack{
            Capsule()
                .foregroundStyle(.orange)
                .overlay(
                    Capsule()
                        .stroke()
                        .foregroundStyle(.white)
                )
            Text("Level up ready!")
                .foregroundStyle(.white)
                .font(.caption2)
                .padding(.vertical, 4)
                .padding(.horizontal)
        }
    }
}

struct InfoContainer: View {
    var championData: MasteryResponse
    
    var body: some View{
        Text(getNameFromId(id: championData.championId))
            .foregroundStyle(.white)
            .bold()
            .font(.system(size: 28))
        Text("Mastery Level \(championData.championLevel)")
            .foregroundStyle(.white)
            .bold()
            .font(.system(size: 18))
        Text("\(championData.championPointsSinceLastLevel) / \(championData.pointsInLevel()) pts")
            .foregroundStyle(.white)

    }
}

struct GradeBox: View {
    var requiredGrade: String
    var achievedGrade: String
    
    var body: some View {
        ZStack{
            Text(requiredGrade)
            if(GradeRank(achievedGrade) <= GradeRank(requiredGrade)) {
                Image(systemName: "checkmark")
            }
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 2)
        .background(
            (GradeRank(achievedGrade) <= GradeRank(requiredGrade))
            ? Color.green
            : Color.clear
        )
    }
}

struct GradesContainer: View {
    var requiredGrades: [String]
    var achievedGrades: [String]
    
    var body: some View {
        ZStack{
            VStack{
                HStack(spacing: 0){
                    ForEach(0..<requiredGrades.count, id: \.self) {index in
                        GradeBox(
                            requiredGrade: requiredGrades[index],
                            achievedGrade: achievedGrades[index]
                        )
                    }
                }
            }
        }
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 4))
    }
}

struct ProgressBar: View {
    var total: Int
    var progress: Int
    @State var fillBar: Bool = false
    @Binding var finishedAnimation: Bool
    
    var barPercentage: CGFloat {
        if (progress >= total) {
            return 1
        }
        return (CGFloat(progress) / CGFloat(total))
    }
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack(alignment: .leading){
                Capsule()
                    .frame(width: geometry.size.width)
                    .foregroundStyle(.gray)
                Capsule()
                    .frame(
                        width: fillBar ? (geometry.size.width * barPercentage) : 0)
                    .foregroundStyle(.white)
            }
        }
        .onAppear (perform: {
            withAnimation(Animation.timingCurve(0.0, 0.0, 0.0, 0.99, duration: 1.25).delay(0.2)) {
                fillBar = true
            } completion: {
                finishedAnimation = true
            }
        })
    }
}

struct MasteryMarks: View {
    var requiredMarks: Int
    var earnedMarks: Int
    
    var emptyToShow: Int {
        let diff = requiredMarks-earnedMarks
        if diff >= 0 {
            return diff
        }
        return 0
    }
    
    var body: some View {
        if (earnedMarks > 3 && earnedMarks > requiredMarks) {
            ZStack(alignment: .bottomTrailing){
                Image("mastery-mark")
                    .resizable()
                    .aspectRatio(contentMode: .fit)
                Text("x\(earnedMarks)").bold()
                    .foregroundStyle(.white)
            }
            
        } else {
            HStack{
                ForEach(0..<earnedMarks, id: \.self){ mark in
                    Image("mastery-mark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                ForEach(0..<emptyToShow, id: \.self){ mark in
                    Image("mastery-mark-empty")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
            }
        }
    }
}

#Preview {
    let mock = mockMasteryResponse
    ChampionScreen(championData: mock[10])
}
