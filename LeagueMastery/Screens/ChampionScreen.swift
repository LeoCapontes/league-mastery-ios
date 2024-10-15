//
//  ChampionScreen.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 29/09/2024.
//

import SwiftUI
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
    
    var body: some View {
        ZStack{
            VStack{
                Text(namesFromChampId[championData.championId]!)
                GradesContainer(requiredGrades: requiredGrades, achievedGrades: achievedGrades)
                // Temp val checking
                HStack{
                    ForEach(0..<achievedGrades.count) {index in
                        Text(achievedGrades[index])
                    }
                }
            }
        }
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
            (gradeRank(achievedGrade) <= gradeRank(requiredGrade)) ? Color.green : Color.clear)
    }
}

struct GradesContainer: View {
    var requiredGrades: [String]
    var achievedGrades: [String]
    
    var body: some View {
        ZStack{
            HStack(spacing: 0){
                ForEach(0..<requiredGrades.count) {index in
                    GradeBox(
                        requiredGrade: requiredGrades[index],
                        achievedGrade: achievedGrades[index]
                    )
                }
            }
        }
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 4))
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
    ChampionScreen(championData: mock[0])
}
