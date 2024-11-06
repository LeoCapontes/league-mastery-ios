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
        // required grades. Fill with impossibly low grades to ensure equal
        // array sizes.
        let tempGrades = Array(repeating: "F", count: requiredGrades.count)
        if var grades = milestoneGrades {
            grades += Array(
                repeating: "F", count: (tempGrades.count - grades.count))
            return grades.sorted(by: { gradeRank($0) < gradeRank($1) })
        } else {
            return tempGrades
        }
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
