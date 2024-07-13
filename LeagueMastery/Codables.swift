//
//  Codables.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 13/07/2024.
//

import Foundation

struct MasteryResponse: Codable {
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
    let milestoneGrades: [String]
    let nextSeasonMilestone: NextSeasonMilestone
    
    struct NextSeasonMilestone: Codable {
        let requireGradeCounts: [String: Int]
        let rewardMarks: Int
        let bonus: Bool
        
        let rewardConfig: RewardConfig?

        struct RewardConfig: Codable {
            let rewardValue: String
            let rewardType: String
            let maximumReward: Int
        }
    }
}

struct Champions: Codable {
    let data: [String: Champion]
    
    struct Champion: Codable {
        let id: String
        let key: String
        let name: String
    }
}
