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

struct ChampionScreen: View {
    var championData: MasteryResponse
    
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
    
    var body: some View {
        ZStack{
            Image("background-mastery")
                .resizable()
                .aspectRatio(contentMode: .fill)
                .frame(minWidth: 0, maxWidth: .infinity)
                .edgesIgnoringSafeArea(.all)
            VStack{
                ChampionImage(
                    championId: championData.championId, blurred: false)
                    .frame(width: 500)
                    .mask(gradientMask)
                Spacer()
            }
            VStack{
                Spacer()
                Spacer()
                HStack{
                    VideoPlayer(url: videoUrl)
                        .frame(width: 250*crestScale, height: 250*crestScale)
                        .shadow(color: .black, radius: 40)
                }
                .frame(width: 250, height: 250)
                .padding(-40)
                
                MasteryMarks(
                    requiredMarks: championData.markRequiredForNextLevel,
                    earnedMarks: championData.tokensEarned)
                .frame(width:.infinity, height: 40)
                .padding(.bottom, -6)
                
                Text(namesFromChampId[championData.championId]!)
                    .foregroundStyle(.white)
                    .bold()
                    .font(.system(size: 28))
                Text("Mastery Level \(championData.championLevel)")
                    .foregroundStyle(.white)
                    .bold()
                    .font(.system(size: 18))
                Text("\(championData.championPointsSinceLastLevel) / \(championData.pointsInLevel) pts")
                    .foregroundStyle(.white)
                Text("Milestone: \(championData.championSeasonMilestone)")
                    .foregroundStyle(.white)
                ProgressBar(
                    total: championData.pointsInLevel,
                    progress: championData.championPointsSinceLastLevel)
                    .frame(width: 200, height: 12)
                GradesContainer(
                    requiredGrades: championData.requiredGrades,
                    achievedGrades: championData.achievedGrades)
                Spacer()
                Spacer()
                Spacer()
                Spacer()
            }
            .padding()
        }
        .ignoresSafeArea()
        
    }
}

struct GradeBox: View {
    var requiredGrade: String
    var achievedGrade: String
    
    var body: some View {
        ZStack{
            Text(requiredGrade)
            if(gradeRank(achievedGrade) <= gradeRank(requiredGrade)) {
                Image(systemName: "checkmark")
            }
        }
        .padding(.horizontal, 6)
        .padding(.vertical, 2)
        .background(
            (gradeRank(achievedGrade) <= gradeRank(requiredGrade))
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

#Preview {
    let mock = mockMasteryResponse
    ChampionScreen(championData: mock[1])
}
