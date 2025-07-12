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

struct SummonerResponse: Codable {
    let puuid: String
    let profileIconId: Int
    let revisionDate: Int
    let summonerLevel: Int
}
