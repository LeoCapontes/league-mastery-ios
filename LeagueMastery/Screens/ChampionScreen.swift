//
//  ChampionScreen.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 29/09/2024.
//

import SwiftUI
import AVKit
let gradientMask = LinearGradient(
    stops: [
        Gradient.Stop(color: .black, location: 0.66),
        Gradient.Stop(color: .clear, location: 1)
    ],
    startPoint: .top,
    endPoint: .bottom)

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
    var metrics: MasteryResponseMetrics
    
    @State var bgColor: Color = Color("BGColor")
    @State var champImage: ChampionImage? = nil
    
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

//            Old Background Image
//            Image("background-mastery")
//                .resizable()
//                .aspectRatio(contentMode: .fill)
//                .frame(minWidth: 0, maxWidth: .infinity)
//                .edgesIgnoringSafeArea(.all)
            VStack{
                ChampionImage(
                    championId: championData.championId, averageColor: $bgColor, withAvgColor: true)
                    .frame(width: 550)
                    .mask(gradientMask)
                    .mask(radialGradientMask)
                Spacer()
            }
            VStack{
                Spacer()
                Spacer()
                Spacer()
                ZStack{
                    if(auroraUnlocked) {
                        VideoPlayer(url: "crest-aurora-loop")
                            .padding(-50)
                            .frame(width: 250, height: 250)
                            .shadow(color: .black, radius: 40)
                    }
//                    The following is for the old animated mastery crest
//                    Keeping in case a new animated crest is added
//                    VideoPlayer(url: videoUrl)
//                        .frame(width: 250*crestScale, height: 250*crestScale)
//                        // shadow effectively removed if aurora is unlocked
//                        .shadow(color: .black, radius: auroraUnlocked ? 0 : 40)
//                    GeometryReader{ geometry in
//                        if championData.championLevel > 9 {
//                            Text("\(championData.championLevel)")
//                                .bold()
//                                .foregroundStyle(.black)
//                                .opacity(0.65)
//                                .position(
//                                    x:geometry.size.width*0.5,
//                                    y:geometry.size.height*0.72)
//                        }
//                    }
                    MasteryCrestImage(masteryLevel: championData.championLevel, mini: false)
                }
                .frame(width: 300, height: 300)
                .padding(-40)
                
                MasteryMarks(
                    requiredMarks: championData.markRequiredForNextLevel,
                    earnedMarks: championData.tokensEarned)
                .frame(width:.infinity, height: 40)
                .padding(.bottom, -6)
                
                InfoContainer(championData: championData, metrics: metrics)
                
                ProgressBar(
                    total: metrics.pointsInLevel,
                    progress: championData.championPointsSinceLastLevel)
                    .frame(width: 200, height: 12)
                GradesContainer(
                    requiredGrades: metrics.requiredGrades,
                    achievedGrades: metrics.achievedGrades)
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
//        .onAppear{
//            bgColor = ChampionImage(championId: championData.championId, blurred: false).averageColor
//            print("Set color to: ", bgColor)
//        }
    }
}

struct InfoContainer: View {
    var championData: MasteryResponse
    var metrics: MasteryResponseMetrics
    
    var body: some View{
        Text(namesFromChampId[championData.championId]!)
            .foregroundStyle(.white)
            .bold()
            .font(.system(size: 28))
        Text("Mastery Level \(championData.championLevel)")
            .foregroundStyle(.white)
            .bold()
            .font(.system(size: 18))
        Text("\(championData.championPointsSinceLastLevel) / \(metrics.pointsInLevel) pts")
            .foregroundStyle(.white)
//        Text("Milestone: \(championData.championSeasonMilestone)")
//            .foregroundStyle(.white)
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
                    ForEach(0..<requiredGrades.count) {index in
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
                        width: (geometry.size.width * barPercentage))
                    .foregroundStyle(.white)
            }
        }
    }
}

struct MasteryMarks: View {
    var requiredMarks: Int
    var earnedMarks: Int
    
    var emptyToShow: Int {
        var diff = requiredMarks-earnedMarks
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
            }
            
        } else {
            HStack{
                ForEach(0..<earnedMarks){ mark in
                    Image("mastery-mark")
                        .resizable()
                        .aspectRatio(contentMode: .fit)
                }
                ForEach(0..<emptyToShow){ mark in
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
    ChampionScreen(championData: mock[40], metrics: GetResponseMetrics(mock)[1])
}
