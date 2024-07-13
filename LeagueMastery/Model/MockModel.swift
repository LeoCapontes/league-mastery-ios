//
//  MockModel.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 08/07/2024.
//

import Foundation

let mockPuuidJson = "{\"puuid\": \"Q46FXYK5hAgW61CqZ9IiQqyR6e3nbTns_iR3cgTTeSD3XN-TpnFq_QYbrbPyd10Jrg-HT-aCZ5zBxg\",\"gameName\": \"leeoo\", \"tagLine\": \"EUW\"}"

func mockTopMasteryRequest(_ quantity: Int) -> String {
    return "https://euw1.api.riotgames.com/lol/champion-mastery/v4/champion-masteries/by-puuid/Q46FXYK5hAgW61CqZ9IiQqyR6e3nbTns_iR3cgTTeSD3XN-TpnFq_QYbrbPyd10Jrg-HT-aCZ5zBxg/top?count=\(quantity)&api_key=\(Settings.shared.key)"
}


let mockTopThreeResponse = """
[
    {
        "puuid": "Q46FXYK5hAgW61CqZ9IiQqyR6e3nbTns_iR3cgTTeSD3XN-TpnFq_QYbrbPyd10Jrg-HT-aCZ5zBxg",
        "championId": 85,
        "championLevel": 26,
        "championPoints": 310877,
        "lastPlayTime": 1720312597000,
        "championPointsSinceLastLevel": 59277,
        "championPointsUntilNextLevel": -48277,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 1,
        "championSeasonMilestone": 1,
        "milestoneGrades": [
            "A+"
        ],
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1,
                "C-": 4
            },
            "rewardMarks": 1,
            "bonus": false
        }
    },
    {
        "puuid": "Q46FXYK5hAgW61CqZ9IiQqyR6e3nbTns_iR3cgTTeSD3XN-TpnFq_QYbrbPyd10Jrg-HT-aCZ5zBxg",
        "championId": 268,
        "championLevel": 21,
        "championPoints": 251696,
        "lastPlayTime": 1720139806000,
        "championPointsSinceLastLevel": 55096,
        "championPointsUntilNextLevel": -44096,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 1,
        "championSeasonMilestone": 1,
        "milestoneGrades": [
            "C+",
            "S",
            "B+"
        ],
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1,
                "C-": 4
            },
            "rewardMarks": 1,
            "bonus": false
        }
    },
    {
        "puuid": "Q46FXYK5hAgW61CqZ9IiQqyR6e3nbTns_iR3cgTTeSD3XN-TpnFq_QYbrbPyd10Jrg-HT-aCZ5zBxg",
        "championId": 41,
        "championLevel": 15,
        "championPoints": 180161,
        "lastPlayTime": 1717019680000,
        "championPointsSinceLastLevel": 49561,
        "championPointsUntilNextLevel": -38561,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "milestoneGrades": [
            "A+",
            "C-"
        ],
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "B-": 1,
                "C-": 4
            },
            "rewardMarks": 1,
            "bonus": false,
            "rewardConfig": {
                "rewardValue": "5f4333db-e90d-4705-903b-08dbf5e61006",
                "rewardType": "HEXTECH_CHEST",
                "maximumReward": 6
            }
        }
    },
    {
        "puuid": "Q46FXYK5hAgW61CqZ9IiQqyR6e3nbTns_iR3cgTTeSD3XN-TpnFq_QYbrbPyd10Jrg-HT-aCZ5zBxg",
        "championId": 150,
        "championLevel": 12,
        "championPoints": 144594,
        "lastPlayTime": 1719615909000,
        "championPointsSinceLastLevel": 46994,
        "championPointsUntilNextLevel": -35994,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "milestoneGrades": [
            "A-",
            "B-",
            "A-",
            "B"
        ],
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "B-": 1,
                "C-": 4
            },
            "rewardMarks": 1,
            "bonus": false,
            "rewardConfig": {
                "rewardValue": "5f4333db-e90d-4705-903b-08dbf5e61006",
                "rewardType": "HEXTECH_CHEST",
                "maximumReward": 6
            }
        }
    }
]
""".data(using: .utf8)
