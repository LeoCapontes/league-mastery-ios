//
//  Rewards.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 19/01/2025.
//

enum RewardType {
    case masteryMark, crestHighlight
}

struct MilestoneReward {
    var reward: RewardType
    var quantity: Int
}

// Reward config not available in api
// TODO: move this server side, account for milestones after 4
let rewardConfig: [Int:[MilestoneReward]] = [
    1 : [MilestoneReward(reward: .masteryMark, quantity: 1)],
    2 : [MilestoneReward(reward: .masteryMark, quantity: 1)],
    3 : [MilestoneReward(reward: .masteryMark, quantity: 2)],
    4 : [
        MilestoneReward(reward: .masteryMark, quantity: 2),
        MilestoneReward(reward: .crestHighlight, quantity: 1)
    ]
]
