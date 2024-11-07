//
//  MockModel.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 08/07/2024.
//

import Foundation
let mockPuuidJson = "{\"puuid\": \"Q46FXYK5hAgW61CqZ9IiQqyR6e3nbTns_iR3cgTTeSD3XN-TpnFq_QYbrbPyd10Jrg-HT-aCZ5zBxg\",\"gameName\": \"leeoo\", \"tagLine\": \"EUW\"}"

func mockTopMasteryRequest(_ quantity: Int, _ puuid: String, _ server: String) -> String {
    return "https://\(server).api.riotgames.com/lol/champion-mastery/v4/champion-masteries/by-puuid/\(puuid)/top?count=\(quantity)&api_key=\(Settings.shared.key)"
}


let mockTopResponse = """
[
    {
        "puuid": "Q46FXYK5hAgW61CqZ9IiQqyR6e3nbTns_iR3cgTTeSD3XN-TpnFq_QYbrbPyd10Jrg-HT-aCZ5zBxg",
        "championId": 85,
        "championLevel": 27,
        "championPoints": 321278,
        "lastPlayTime": 1729803565000,
        "championPointsSinceLastLevel": 58678,
        "championPointsUntilNextLevel": -47678,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 0,
        "championSeasonMilestone": 1,
        "milestoneGrades": [
          "B-",
          "A-",
          "A+"
        ],
        "nextSeasonMilestone": {
          "requireGradeCounts": {
            "A-": 1,
            "C-": 4
          },
          "rewardMarks": 1,
          "bonus": false,
          "totalGamesRequires": 5
        }
      },
      {
        "puuid": "Q46FXYK5hAgW61CqZ9IiQqyR6e3nbTns_iR3cgTTeSD3XN-TpnFq_QYbrbPyd10Jrg-HT-aCZ5zBxg",
        "championId": 268,
        "championLevel": 22,
        "championPoints": 257399,
        "lastPlayTime": 1728172699000,
        "championPointsSinceLastLevel": 49799,
        "championPointsUntilNextLevel": -38799,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "milestoneGrades": [
          "S-",
          "S-"
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
          },
          "totalGamesRequires": 5
        }
      },
      {
        "puuid": "Q46FXYK5hAgW61CqZ9IiQqyR6e3nbTns_iR3cgTTeSD3XN-TpnFq_QYbrbPyd10Jrg-HT-aCZ5zBxg",
        "championId": 41,
        "championLevel": 15,
        "championPoints": 181024,
        "lastPlayTime": 1729719238000,
        "championPointsSinceLastLevel": 50424,
        "championPointsUntilNextLevel": -39424,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "milestoneGrades": [
          "B-"
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
          },
          "totalGamesRequires": 5
        }
      },
      {
        "puuid": "Q46FXYK5hAgW61CqZ9IiQqyR6e3nbTns_iR3cgTTeSD3XN-TpnFq_QYbrbPyd10Jrg-HT-aCZ5zBxg",
        "championId": 150,
        "championLevel": 13,
        "championPoints": 156095,
        "lastPlayTime": 1729721592000,
        "championPointsSinceLastLevel": 47495,
        "championPointsUntilNextLevel": -36495,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "milestoneGrades": [
          "A",
          "A-",
          "C+",
          "A-"
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
          },
          "totalGamesRequires": 5
        }
      },
      {
        "puuid": "Q46FXYK5hAgW61CqZ9IiQqyR6e3nbTns_iR3cgTTeSD3XN-TpnFq_QYbrbPyd10Jrg-HT-aCZ5zBxg",
        "championId": 14,
        "championLevel": 11,
        "championPoints": 130389,
        "lastPlayTime": 1726797160000,
        "championPointsSinceLastLevel": 43789,
        "championPointsUntilNextLevel": -32789,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
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
          },
          "totalGamesRequires": 5
        }
      },
      {
        "puuid": "Q46FXYK5hAgW61CqZ9IiQqyR6e3nbTns_iR3cgTTeSD3XN-TpnFq_QYbrbPyd10Jrg-HT-aCZ5zBxg",
        "championId": 13,
        "championLevel": 11,
        "championPoints": 105117,
        "lastPlayTime": 1730840390000,
        "championPointsSinceLastLevel": 18517,
        "championPointsUntilNextLevel": -7517,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 0,
        "championSeasonMilestone": 1,
        "milestoneGrades": [
          "A-"
        ],
        "nextSeasonMilestone": {
          "requireGradeCounts": {
            "A-": 1,
            "C-": 4
          },
          "rewardMarks": 1,
          "bonus": false,
          "totalGamesRequires": 5
        }
      },
      {
        "puuid": "Q46FXYK5hAgW61CqZ9IiQqyR6e3nbTns_iR3cgTTeSD3XN-TpnFq_QYbrbPyd10Jrg-HT-aCZ5zBxg",
        "championId": 266,
        "championLevel": 10,
        "championPoints": 95520,
        "lastPlayTime": 1729617032000,
        "championPointsSinceLastLevel": 19920,
        "championPointsUntilNextLevel": -8920,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "milestoneGrades": [
          "B-",
          "A-"
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
          },
          "totalGamesRequires": 5
        }
      },
      {
        "puuid": "Q46FXYK5hAgW61CqZ9IiQqyR6e3nbTns_iR3cgTTeSD3XN-TpnFq_QYbrbPyd10Jrg-HT-aCZ5zBxg",
        "championId": 103,
        "championLevel": 10,
        "championPoints": 92385,
        "lastPlayTime": 1727302929000,
        "championPointsSinceLastLevel": 16785,
        "championPointsUntilNextLevel": -5785,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "milestoneGrades": [
          "S-"
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
          },
          "totalGamesRequires": 5
        }
      }
]
""".data(using: .utf8)

var mockMasteryResponse: [MasteryResponse] {
    do {
        let response = try JSONDecoder().decode(
            [MasteryResponse].self, from: mockTopResponse!)
        return response
    } catch {
        return []
    }
}
