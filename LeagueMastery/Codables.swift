//
//  Codables.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 13/07/2024.
//

import Foundation

struct MasteryResponse: Codable, Hashable {
    let puuid: String
    let championId: Int
    let championLevel: Int
    let championPoints: Int
    let lastPlayTime: Int
    let championPointsSinceLastLevel: Int
    let championPointsUntilNextLevel: Int
    let markRequiredForNextLevel: Int
    let tokensEarned: Int
    let championSeasonMilestone: Int
    let milestoneGrades: [String]?
    let nextSeasonMilestone: NextSeasonMilestone
    
    struct NextSeasonMilestone: Codable, Hashable {
        let requireGradeCounts: [String: Int]
        let rewardMarks: Int
        let bonus: Bool
        
        let rewardConfig: RewardConfig?

        struct RewardConfig: Codable, Hashable {
            let rewardValue: String
            let rewardType: String
            let maximumReward: Int
        }
    }
    
    var pointsInLevel: Int {
        return championPointsSinceLastLevel + championPointsUntilNextLevel
    }
    
    var requiredGrades: [String] {
        let gradecounts = nextSeasonMilestone.requireGradeCounts
        var reqGrades: [String] = []
        for grade in gradecounts{
            reqGrades += Array(repeating: grade.key, count: grade.value)
        }
        return reqGrades.sorted(by: { gradeRank($0) < gradeRank($1) })
    }
    
    var achievedGrades: [String] {
        // actual achieved grades will always less or equal to number of
        // required grades if below the final milestone level. Fill with
        // impossibly low grades to ensure equal array sizes.
        let tempGrades = Array(repeating: "F", count: requiredGrades.count)
        
        if var grades = milestoneGrades {
            let sortedAchievedGrades = grades.sorted(by: {
                gradeRank($0) < gradeRank($1)
            })
            
            // Cover final milestone case where all grades are recorded, and
            // therefore can exceed the number of required grades
            if (grades.count > requiredGrades.count) {
                return Array(sortedAchievedGrades[..<requiredGrades.count])
            }
            
            grades += Array(
                repeating: "F", count: (tempGrades.count - grades.count))
            return grades
        } else {
            return tempGrades
        }
    }

    // This assumes a chest is rewarded at milestone 2 and 4, which is true
    // as of November 2024
    var gradesToChest: Int {
        // Chests no longer earnable
        if (championSeasonMilestone>4) { return 999 }
        
        let targetMilestone = (championSeasonMilestone < 2) ? 2 : 4
        let gradesPerMilestone = requiredGrades.count
        let gradeCount = (gradesPerMilestone*championSeasonMilestone) + achievedGrades.count
        let requiredGradeCount = gradesPerMilestone*targetMilestone
        return requiredGradeCount-gradeCount
    }
}

struct Champions: Codable {
    let data: [String: Champion]
}

struct Champion: Codable {
    let id: String
    let key: String
    let name: String
}

struct PuuidResponse: Codable {
    let puuid: String
    let gameName: String
    let tagLine: String
}
