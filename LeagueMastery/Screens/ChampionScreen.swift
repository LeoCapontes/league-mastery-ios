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
    
    var requiredGrades: [String] {
        let gradecounts = championData.nextSeasonMilestone.requireGradeCounts
        var reqGrades: [String] = []
        for grade in gradecounts{
            reqGrades += Array(repeating: grade.key, count: grade.value)
        }
        return reqGrades.sorted(by: { gradeRank($0) < gradeRank($1) })
    }
    
    var achievedGrades: [String] {
        // actual achieved grades will always less or equal to number of
        // required grades. Fill with impossibly low grades to ensure equal
        // array sizes.
        let tempGrades = Array(repeating: "F", count: requiredGrades.count)
        if var grades = championData.milestoneGrades {
            grades += Array(
                repeating: "F", count: (tempGrades.count - grades.count))
            return grades.sorted(by: { gradeRank($0) < gradeRank($1) })
        } else {
            return tempGrades
        }
    }
    
    var pointsInLevel: Int {
        return championData.championPointsSinceLastLevel + championData.championPointsUntilNextLevel
    }
    
    var pointsProgress: Int {
        return championData.championPointsSinceLastLevel
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
                MasteryCrestImage(
                    masteryLevel: championData.championLevel, mini: false)
                    .frame(width: 250)
                    .padding(-44)
                    .shadow(color: .black, radius: 40)
                Text(namesFromChampId[championData.championId]!)
                    .foregroundStyle(.white)
                    .bold()
                    .font(.system(size: 28))
                Text("Mastery Level \(championData.championLevel)")
                    .foregroundStyle(.white)
                    .bold()
                    .font(.system(size: 18))
                Text("\(pointsProgress) / \(pointsInLevel)")
                    .foregroundStyle(.white)
                ProgressBar(total: pointsInLevel, progress: pointsProgress)
                    .frame(width: 200, height: 12)
                GradesContainer(
                    requiredGrades: requiredGrades,
                    achievedGrades: achievedGrades)
                
                // Temp val checking
//                HStack{
//                    ForEach(0..<achievedGrades.count) {index in
//                        Text(achievedGrades[index])
//                    }
//                }
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

func gradeRank(_ grade: String) -> Int {
    let gradeRanks: [String: Int] = [
        "S+": 0, "S": 1, "S-": 2,
        "A+": 3, "A": 4, "A-": 5,
        "B+": 6, "B": 7, "B-": 8,
        "C+": 9, "C": 10, "C-": 11,
        "D+": 12, "D": 13, "D-": 14,
        "F": 15
    ]
    
    return gradeRanks[grade] ?? Int.max
}

#Preview {
    let mock = mockMasteryResponse
    ChampionScreen(championData: mock[1])
}
