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

var mockMasteryResponse: [MasteryResponse] {
    do {
        let response = try JSONDecoder().decode(
            [MasteryResponse].self, from: mockTopResponse!)
        return response
    } catch {
        return []
    }
}


var mockUser: User = User(
    puuid: "123",
    name: "user",
    tagline: "#region",
    isFavourite: false,
    region: "region",
    server: "server",
    profileIconId: 1,
    summonerLevel: 1,
    masteryScore: 999
)

let mockTopResponse = """
[
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 7,
        "championLevel": 58,
        "championPoints": 608541,
        "lastPlayTime": 1768929829000,
        "championPointsSinceLastLevel": 4941,
        "championPointsUntilNextLevel": 6059,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 2,
        "championSeasonMilestone": 1,
        "milestoneGrades": [
            "B"
        ],
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 268,
        "championLevel": 36,
        "championPoints": 372227,
        "lastPlayTime": 1769011840000,
        "championPointsSinceLastLevel": 10627,
        "championPointsUntilNextLevel": 373,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 22,
        "championSeasonMilestone": 1,
        "milestoneGrades": [
            "C+"
        ],
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 517,
        "championLevel": 33,
        "championPoints": 332828,
        "lastPlayTime": 1768320833000,
        "championPointsSinceLastLevel": 4228,
        "championPointsUntilNextLevel": 6772,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 19,
        "championSeasonMilestone": 1,
        "milestoneGrades": [],
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 84,
        "championLevel": 29,
        "championPoints": 285653,
        "lastPlayTime": 1769272951000,
        "championPointsSinceLastLevel": 1053,
        "championPointsUntilNextLevel": 9947,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 6,
        "championSeasonMilestone": 4,
        "milestoneGrades": [],
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "S-": 2
            },
            "rewardMarks": 1,
            "bonus": true,
            "totalGamesRequires": 2
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 134,
        "championLevel": 23,
        "championPoints": 271686,
        "lastPlayTime": 1765388580000,
        "championPointsSinceLastLevel": 53086,
        "championPointsUntilNextLevel": -42086,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 142,
        "championLevel": 26,
        "championPoints": 269256,
        "lastPlayTime": 1769710573000,
        "championPointsSinceLastLevel": 17656,
        "championPointsUntilNextLevel": -6656,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 0,
        "championSeasonMilestone": 3,
        "milestoneGrades": [
            "C+",
            "A"
        ],
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "S-": 1
            },
            "rewardMarks": 2,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 236,
        "championLevel": 24,
        "championPoints": 261247,
        "lastPlayTime": 1746789161000,
        "championPointsSinceLastLevel": 31647,
        "championPointsUntilNextLevel": -20647,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 39,
        "championLevel": 23,
        "championPoints": 254037,
        "lastPlayTime": 1765371208000,
        "championPointsSinceLastLevel": 35437,
        "championPointsUntilNextLevel": -24437,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 13,
        "championLevel": 25,
        "championPoints": 243622,
        "lastPlayTime": 1769098236000,
        "championPointsSinceLastLevel": 3022,
        "championPointsUntilNextLevel": 7978,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 7,
        "championSeasonMilestone": 3,
        "milestoneGrades": [],
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "S-": 1
            },
            "rewardMarks": 2,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 777,
        "championLevel": 24,
        "championPoints": 236454,
        "lastPlayTime": 1769275411000,
        "championPointsSinceLastLevel": 6854,
        "championPointsUntilNextLevel": 4146,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 20,
        "championSeasonMilestone": 4,
        "milestoneGrades": [
            "A",
            "A+",
            "S+"
        ],
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "S-": 2
            },
            "rewardMarks": 1,
            "bonus": true,
            "totalGamesRequires": 2
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 163,
        "championLevel": 23,
        "championPoints": 228598,
        "lastPlayTime": 1768225109000,
        "championPointsSinceLastLevel": 9998,
        "championPointsUntilNextLevel": 1002,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 13,
        "championSeasonMilestone": 1,
        "milestoneGrades": [],
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 157,
        "championLevel": 20,
        "championPoints": 215554,
        "lastPlayTime": 1765648133000,
        "championPointsSinceLastLevel": 29954,
        "championPointsUntilNextLevel": -18954,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 64,
        "championLevel": 17,
        "championPoints": 183172,
        "lastPlayTime": 1765649906000,
        "championPointsSinceLastLevel": 30572,
        "championPointsUntilNextLevel": -19572,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 103,
        "championLevel": 18,
        "championPoints": 165015,
        "lastPlayTime": 1755155373000,
        "championPointsSinceLastLevel": 1415,
        "championPointsUntilNextLevel": 9585,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 9,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 112,
        "championLevel": 17,
        "championPoints": 162511,
        "lastPlayTime": 1768149088000,
        "championPointsSinceLastLevel": 9911,
        "championPointsUntilNextLevel": 1089,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 13,
        "championSeasonMilestone": 1,
        "milestoneGrades": [],
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 238,
        "championLevel": 15,
        "championPoints": 160776,
        "lastPlayTime": 1767803785000,
        "championPointsSinceLastLevel": 30176,
        "championPointsUntilNextLevel": -19176,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 18,
        "championLevel": 16,
        "championPoints": 147577,
        "lastPlayTime": 1757692018000,
        "championPointsSinceLastLevel": 5977,
        "championPointsUntilNextLevel": 5023,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 6,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 61,
        "championLevel": 14,
        "championPoints": 128231,
        "lastPlayTime": 1769268861000,
        "championPointsSinceLastLevel": 8631,
        "championPointsUntilNextLevel": 2369,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 17,
        "championSeasonMilestone": 2,
        "milestoneGrades": [
            "A"
        ],
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "S-": 1
            },
            "rewardMarks": 2,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 69,
        "championLevel": 11,
        "championPoints": 121279,
        "lastPlayTime": 1769795166000,
        "championPointsSinceLastLevel": 34679,
        "championPointsUntilNextLevel": -23679,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 1,
        "championSeasonMilestone": 1,
        "milestoneGrades": [
            "B"
        ],
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 126,
        "championLevel": 14,
        "championPoints": 121215,
        "lastPlayTime": 1765262592000,
        "championPointsSinceLastLevel": 1615,
        "championPointsUntilNextLevel": 9385,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 8,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 105,
        "championLevel": 11,
        "championPoints": 118944,
        "lastPlayTime": 1757767914000,
        "championPointsSinceLastLevel": 32344,
        "championPointsUntilNextLevel": -21344,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 4,
        "championLevel": 13,
        "championPoints": 116726,
        "lastPlayTime": 1757782866000,
        "championPointsSinceLastLevel": 8126,
        "championPointsUntilNextLevel": 2874,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 8,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 38,
        "championLevel": 11,
        "championPoints": 115298,
        "lastPlayTime": 1754936376000,
        "championPointsSinceLastLevel": 28698,
        "championPointsUntilNextLevel": -17698,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 42,
        "championLevel": 12,
        "championPoints": 100643,
        "lastPlayTime": 1768236545000,
        "championPointsSinceLastLevel": 3043,
        "championPointsUntilNextLevel": 7957,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 15,
        "championSeasonMilestone": 1,
        "milestoneGrades": [],
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 3,
        "championLevel": 12,
        "championPoints": 99088,
        "lastPlayTime": 1758304465000,
        "championPointsSinceLastLevel": 1488,
        "championPointsUntilNextLevel": 9512,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 17,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 266,
        "championLevel": 10,
        "championPoints": 97009,
        "lastPlayTime": 1765200413000,
        "championPointsSinceLastLevel": 21409,
        "championPointsUntilNextLevel": -10409,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 55,
        "championLevel": 11,
        "championPoints": 94031,
        "lastPlayTime": 1769619809000,
        "championPointsSinceLastLevel": 7431,
        "championPointsUntilNextLevel": 3569,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "milestoneGrades": [
            "C",
            "B+",
            "D+"
        ],
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 893,
        "championLevel": 11,
        "championPoints": 92005,
        "lastPlayTime": 1769606073000,
        "championPointsSinceLastLevel": 5405,
        "championPointsUntilNextLevel": 5595,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 36,
        "championSeasonMilestone": 3,
        "milestoneGrades": [
            "A+"
        ],
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "S-": 1
            },
            "rewardMarks": 2,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 81,
        "championLevel": 10,
        "championPoints": 81295,
        "lastPlayTime": 1768144766000,
        "championPointsSinceLastLevel": 5695,
        "championPointsUntilNextLevel": 5305,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 4,
        "championSeasonMilestone": 1,
        "milestoneGrades": [],
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 8,
        "championLevel": 10,
        "championPoints": 78021,
        "lastPlayTime": 1745510030000,
        "championPointsSinceLastLevel": 2421,
        "championPointsUntilNextLevel": 8579,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 90,
        "championLevel": 9,
        "championPoints": 77602,
        "lastPlayTime": 1744124788000,
        "championPointsSinceLastLevel": 13002,
        "championPointsUntilNextLevel": -2002,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 799,
        "championLevel": 9,
        "championPoints": 70373,
        "lastPlayTime": 1769615694000,
        "championPointsSinceLastLevel": 5773,
        "championPointsUntilNextLevel": 5227,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 27,
        "championSeasonMilestone": 3,
        "milestoneGrades": [],
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "S-": 1
            },
            "rewardMarks": 2,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 41,
        "championLevel": 9,
        "championPoints": 68866,
        "lastPlayTime": 1744527626000,
        "championPointsSinceLastLevel": 4266,
        "championPointsUntilNextLevel": 6734,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 2,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 518,
        "championLevel": 9,
        "championPoints": 66123,
        "lastPlayTime": 1765562948000,
        "championPointsSinceLastLevel": 1523,
        "championPointsUntilNextLevel": 9477,
        "markRequiredForNextLevel": 2,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 68,
        "championLevel": 8,
        "championPoints": 64456,
        "lastPlayTime": 1765044574000,
        "championPointsSinceLastLevel": 10856,
        "championPointsUntilNextLevel": 144,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 76,
        "championLevel": 8,
        "championPoints": 64369,
        "lastPlayTime": 1749573474000,
        "championPointsSinceLastLevel": 10769,
        "championPointsUntilNextLevel": 231,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 5,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 136,
        "championLevel": 8,
        "championPoints": 62745,
        "lastPlayTime": 1754129687000,
        "championPointsSinceLastLevel": 9145,
        "championPointsUntilNextLevel": 1855,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 5,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 875,
        "championLevel": 8,
        "championPoints": 62055,
        "lastPlayTime": 1743856533000,
        "championPointsSinceLastLevel": 8455,
        "championPointsUntilNextLevel": 2545,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 711,
        "championLevel": 8,
        "championPoints": 61801,
        "lastPlayTime": 1759660866000,
        "championPointsSinceLastLevel": 8201,
        "championPointsUntilNextLevel": 2799,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 6,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 114,
        "championLevel": 8,
        "championPoints": 60389,
        "lastPlayTime": 1742918538000,
        "championPointsSinceLastLevel": 6789,
        "championPointsUntilNextLevel": 4211,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 3,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 131,
        "championLevel": 8,
        "championPoints": 59714,
        "lastPlayTime": 1757772128000,
        "championPointsSinceLastLevel": 6114,
        "championPointsUntilNextLevel": 4886,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 8,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 80,
        "championLevel": 8,
        "championPoints": 58392,
        "lastPlayTime": 1755932466000,
        "championPointsSinceLastLevel": 4792,
        "championPointsUntilNextLevel": 6208,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 10,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 164,
        "championLevel": 8,
        "championPoints": 58024,
        "lastPlayTime": 1746544237000,
        "championPointsSinceLastLevel": 4424,
        "championPointsUntilNextLevel": 6576,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 1,
        "championLevel": 8,
        "championPoints": 57129,
        "lastPlayTime": 1759768170000,
        "championPointsSinceLastLevel": 3529,
        "championPointsUntilNextLevel": 7471,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 18,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 79,
        "championLevel": 8,
        "championPoints": 55485,
        "lastPlayTime": 1749321042000,
        "championPointsSinceLastLevel": 1885,
        "championPointsUntilNextLevel": 9115,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 58,
        "championLevel": 8,
        "championPoints": 54510,
        "lastPlayTime": 1767456657000,
        "championPointsSinceLastLevel": 910,
        "championPointsUntilNextLevel": 10090,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 4,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 127,
        "championLevel": 7,
        "championPoints": 52336,
        "lastPlayTime": 1763204065000,
        "championPointsSinceLastLevel": 9736,
        "championPointsUntilNextLevel": 1264,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 2,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 245,
        "championLevel": 7,
        "championPoints": 50611,
        "lastPlayTime": 1756229462000,
        "championPointsSinceLastLevel": 8011,
        "championPointsUntilNextLevel": 2989,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 2,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 234,
        "championLevel": 7,
        "championPoints": 46646,
        "lastPlayTime": 1755968078000,
        "championPointsSinceLastLevel": 4046,
        "championPointsUntilNextLevel": 6954,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 246,
        "championLevel": 7,
        "championPoints": 46313,
        "lastPlayTime": 1757600774000,
        "championPointsSinceLastLevel": 3713,
        "championPointsUntilNextLevel": 7287,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 6,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 50,
        "championLevel": 6,
        "championPoints": 45702,
        "lastPlayTime": 1680624208000,
        "championPointsSinceLastLevel": 14102,
        "championPointsUntilNextLevel": -3102,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 910,
        "championLevel": 7,
        "championPoints": 45541,
        "lastPlayTime": 1765264380000,
        "championPointsSinceLastLevel": 2941,
        "championPointsUntilNextLevel": 8059,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 6,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 34,
        "championLevel": 6,
        "championPoints": 41227,
        "lastPlayTime": 1769788810000,
        "championPointsSinceLastLevel": 9627,
        "championPointsUntilNextLevel": 1373,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 5,
        "championSeasonMilestone": 2,
        "milestoneGrades": [],
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "S-": 1
            },
            "rewardMarks": 2,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 412,
        "championLevel": 6,
        "championPoints": 40164,
        "lastPlayTime": 1682788175000,
        "championPointsSinceLastLevel": 8564,
        "championPointsUntilNextLevel": 2436,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 432,
        "championLevel": 6,
        "championPoints": 37958,
        "lastPlayTime": 1759687518000,
        "championPointsSinceLastLevel": 6358,
        "championPointsUntilNextLevel": 4642,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 53,
        "championLevel": 7,
        "championPoints": 35355,
        "lastPlayTime": 1753355463000,
        "championPointsSinceLastLevel": 0,
        "championPointsUntilNextLevel": 18245,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 897,
        "championLevel": 6,
        "championPoints": 35322,
        "lastPlayTime": 1753351507000,
        "championPointsSinceLastLevel": 3722,
        "championPointsUntilNextLevel": 7278,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 4,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 12,
        "championLevel": 6,
        "championPoints": 35030,
        "lastPlayTime": 1754830732000,
        "championPointsSinceLastLevel": 3430,
        "championPointsUntilNextLevel": 7570,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 4,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 110,
        "championLevel": 6,
        "championPoints": 34946,
        "lastPlayTime": 1755704783000,
        "championPointsSinceLastLevel": 3346,
        "championPointsUntilNextLevel": 7654,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 3,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 101,
        "championLevel": 6,
        "championPoints": 34874,
        "lastPlayTime": 1757340646000,
        "championPointsSinceLastLevel": 3274,
        "championPointsUntilNextLevel": 7726,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 4,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 429,
        "championLevel": 6,
        "championPoints": 33114,
        "lastPlayTime": 1756664304000,
        "championPointsSinceLastLevel": 1514,
        "championPointsUntilNextLevel": 9486,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 3,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 67,
        "championLevel": 6,
        "championPoints": 32590,
        "lastPlayTime": 1765292665000,
        "championPointsSinceLastLevel": 990,
        "championPointsUntilNextLevel": 10010,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 3,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 555,
        "championLevel": 6,
        "championPoints": 32204,
        "lastPlayTime": 1758391998000,
        "championPointsSinceLastLevel": 604,
        "championPointsUntilNextLevel": 10396,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 4,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 43,
        "championLevel": 6,
        "championPoints": 31862,
        "lastPlayTime": 1743529494000,
        "championPointsSinceLastLevel": 262,
        "championPointsUntilNextLevel": 10738,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 2,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 104,
        "championLevel": 6,
        "championPoints": 31199,
        "lastPlayTime": 1754030592000,
        "championPointsSinceLastLevel": 0,
        "championPointsUntilNextLevel": 11401,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 24,
        "championLevel": 6,
        "championPoints": 30905,
        "lastPlayTime": 1767598977000,
        "championPointsSinceLastLevel": 0,
        "championPointsUntilNextLevel": 11695,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 5,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 85,
        "championLevel": 5,
        "championPoints": 30849,
        "lastPlayTime": 1769796577000,
        "championPointsSinceLastLevel": 9249,
        "championPointsUntilNextLevel": 751,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 6,
        "championSeasonMilestone": 1,
        "milestoneGrades": [],
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 145,
        "championLevel": 7,
        "championPoints": 30250,
        "lastPlayTime": 1747503778000,
        "championPointsSinceLastLevel": 0,
        "championPointsUntilNextLevel": 23350,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 202,
        "championLevel": 6,
        "championPoints": 30237,
        "lastPlayTime": 1767433743000,
        "championPointsSinceLastLevel": 0,
        "championPointsUntilNextLevel": 12363,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 2,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 20,
        "championLevel": 6,
        "championPoints": 30214,
        "lastPlayTime": 1743491567000,
        "championPointsSinceLastLevel": 0,
        "championPointsUntilNextLevel": 12386,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 56,
        "championLevel": 6,
        "championPoints": 30139,
        "lastPlayTime": 1741322224000,
        "championPointsSinceLastLevel": 0,
        "championPointsUntilNextLevel": 12461,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 60,
        "championLevel": 5,
        "championPoints": 29200,
        "lastPlayTime": 1756137281000,
        "championPointsSinceLastLevel": 7600,
        "championPointsUntilNextLevel": 2400,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 5,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 89,
        "championLevel": 6,
        "championPoints": 28794,
        "lastPlayTime": 1753968116000,
        "championPointsSinceLastLevel": 0,
        "championPointsUntilNextLevel": 13806,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 240,
        "championLevel": 6,
        "championPoints": 28447,
        "lastPlayTime": 1613148544000,
        "championPointsSinceLastLevel": 0,
        "championPointsUntilNextLevel": 14153,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 14,
        "championLevel": 5,
        "championPoints": 28432,
        "lastPlayTime": 1747055145000,
        "championPointsSinceLastLevel": 6832,
        "championPointsUntilNextLevel": 3168,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 7,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 107,
        "championLevel": 5,
        "championPoints": 27754,
        "lastPlayTime": 1755703598000,
        "championPointsSinceLastLevel": 6154,
        "championPointsUntilNextLevel": 3846,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 75,
        "championLevel": 5,
        "championPoints": 26783,
        "lastPlayTime": 1743698677000,
        "championPointsSinceLastLevel": 5183,
        "championPointsUntilNextLevel": 4817,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 5,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 45,
        "championLevel": 6,
        "championPoints": 26287,
        "lastPlayTime": 1750863824000,
        "championPointsSinceLastLevel": 0,
        "championPointsUntilNextLevel": 16313,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 2,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 2,
        "championLevel": 5,
        "championPoints": 26122,
        "lastPlayTime": 1757429229000,
        "championPointsSinceLastLevel": 4522,
        "championPointsUntilNextLevel": 5478,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 111,
        "championLevel": 5,
        "championPoints": 25118,
        "lastPlayTime": 1767889480000,
        "championPointsSinceLastLevel": 3518,
        "championPointsUntilNextLevel": 6482,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 91,
        "championLevel": 5,
        "championPoints": 24564,
        "lastPlayTime": 1742577333000,
        "championPointsSinceLastLevel": 2964,
        "championPointsUntilNextLevel": 7036,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 133,
        "championLevel": 5,
        "championPoints": 23818,
        "lastPlayTime": 1695460987000,
        "championPointsSinceLastLevel": 2218,
        "championPointsUntilNextLevel": 7782,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 121,
        "championLevel": 5,
        "championPoints": 23461,
        "lastPlayTime": 1755011890000,
        "championPointsSinceLastLevel": 1861,
        "championPointsUntilNextLevel": 8139,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 161,
        "championLevel": 5,
        "championPoints": 22709,
        "lastPlayTime": 1765089240000,
        "championPointsSinceLastLevel": 1109,
        "championPointsUntilNextLevel": 8891,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 23,
        "championLevel": 5,
        "championPoints": 21993,
        "lastPlayTime": 1745943034000,
        "championPointsSinceLastLevel": 393,
        "championPointsUntilNextLevel": 9607,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 201,
        "championLevel": 5,
        "championPoints": 21955,
        "lastPlayTime": 1757701702000,
        "championPointsSinceLastLevel": 355,
        "championPointsUntilNextLevel": 9645,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 78,
        "championLevel": 5,
        "championPoints": 21769,
        "lastPlayTime": 1749548167000,
        "championPointsSinceLastLevel": 169,
        "championPointsUntilNextLevel": 9831,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 59,
        "championLevel": 4,
        "championPoints": 20245,
        "lastPlayTime": 1769792532000,
        "championPointsSinceLastLevel": 7645,
        "championPointsUntilNextLevel": 1355,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "milestoneGrades": [
            "C"
        ],
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 122,
        "championLevel": 4,
        "championPoints": 19605,
        "lastPlayTime": 1759844534000,
        "championPointsSinceLastLevel": 7005,
        "championPointsUntilNextLevel": 1995,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 3,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 427,
        "championLevel": 4,
        "championPoints": 19527,
        "lastPlayTime": 1597072177000,
        "championPointsSinceLastLevel": 6927,
        "championPointsUntilNextLevel": 2073,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 497,
        "championLevel": 4,
        "championPoints": 19223,
        "lastPlayTime": 1767628735000,
        "championPointsSinceLastLevel": 6623,
        "championPointsUntilNextLevel": 2377,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 150,
        "championLevel": 4,
        "championPoints": 19013,
        "lastPlayTime": 1765645464000,
        "championPointsSinceLastLevel": 6413,
        "championPointsUntilNextLevel": 2587,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 120,
        "championLevel": 4,
        "championPoints": 17585,
        "lastPlayTime": 1745231655000,
        "championPointsSinceLastLevel": 4985,
        "championPointsUntilNextLevel": 4015,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 92,
        "championLevel": 4,
        "championPoints": 17438,
        "lastPlayTime": 1755792815000,
        "championPointsSinceLastLevel": 4838,
        "championPointsUntilNextLevel": 4162,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 31,
        "championLevel": 4,
        "championPoints": 17370,
        "lastPlayTime": 1769099988000,
        "championPointsSinceLastLevel": 4770,
        "championPointsUntilNextLevel": 4230,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 2,
        "championSeasonMilestone": 0,
        "milestoneGrades": [
            "B+"
        ],
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 887,
        "championLevel": 4,
        "championPoints": 17261,
        "lastPlayTime": 1745163855000,
        "championPointsSinceLastLevel": 4661,
        "championPointsUntilNextLevel": 4339,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 2,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 498,
        "championLevel": 4,
        "championPoints": 17099,
        "lastPlayTime": 1754378680000,
        "championPointsSinceLastLevel": 4499,
        "championPointsUntilNextLevel": 4501,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 223,
        "championLevel": 4,
        "championPoints": 16996,
        "lastPlayTime": 1759764448000,
        "championPointsSinceLastLevel": 4396,
        "championPointsUntilNextLevel": 4604,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 4,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 421,
        "championLevel": 4,
        "championPoints": 16870,
        "lastPlayTime": 1650900582000,
        "championPointsSinceLastLevel": 4270,
        "championPointsUntilNextLevel": 4730,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 254,
        "championLevel": 4,
        "championPoints": 15995,
        "lastPlayTime": 1769790242000,
        "championPointsSinceLastLevel": 3395,
        "championPointsUntilNextLevel": 5605,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 5,
        "championSeasonMilestone": 0,
        "milestoneGrades": [
            "D+"
        ],
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 82,
        "championLevel": 4,
        "championPoints": 15437,
        "lastPlayTime": 1754926945000,
        "championPointsSinceLastLevel": 2837,
        "championPointsUntilNextLevel": 6163,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 154,
        "championLevel": 4,
        "championPoints": 15201,
        "lastPlayTime": 1743521443000,
        "championPointsSinceLastLevel": 2601,
        "championPointsUntilNextLevel": 6399,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 51,
        "championLevel": 4,
        "championPoints": 15090,
        "lastPlayTime": 1670495869000,
        "championPointsSinceLastLevel": 2490,
        "championPointsUntilNextLevel": 6510,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 117,
        "championLevel": 4,
        "championPoints": 14425,
        "lastPlayTime": 1631270059000,
        "championPointsSinceLastLevel": 1825,
        "championPointsUntilNextLevel": 7175,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 516,
        "championLevel": 4,
        "championPoints": 14291,
        "lastPlayTime": 1757355041000,
        "championPointsSinceLastLevel": 1691,
        "championPointsUntilNextLevel": 7309,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 2,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 166,
        "championLevel": 4,
        "championPoints": 14199,
        "lastPlayTime": 1755538132000,
        "championPointsSinceLastLevel": 1599,
        "championPointsUntilNextLevel": 7401,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 62,
        "championLevel": 4,
        "championPoints": 14159,
        "lastPlayTime": 1765294302000,
        "championPointsSinceLastLevel": 1559,
        "championPointsUntilNextLevel": 7441,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 2,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 6,
        "championLevel": 4,
        "championPoints": 14085,
        "lastPlayTime": 1569150450000,
        "championPointsSinceLastLevel": 1485,
        "championPointsUntilNextLevel": 7515,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 5,
        "championLevel": 4,
        "championPoints": 13797,
        "lastPlayTime": 1754658139000,
        "championPointsSinceLastLevel": 1197,
        "championPointsUntilNextLevel": 7803,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 2,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 30,
        "championLevel": 4,
        "championPoints": 13363,
        "lastPlayTime": 1695189300000,
        "championPointsSinceLastLevel": 763,
        "championPointsUntilNextLevel": 8237,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 901,
        "championLevel": 4,
        "championPoints": 12604,
        "lastPlayTime": 1757695619000,
        "championPointsSinceLastLevel": 4,
        "championPointsUntilNextLevel": 8996,
        "markRequiredForNextLevel": 1,
        "tokensEarned": 4,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 876,
        "championLevel": 3,
        "championPoints": 12582,
        "lastPlayTime": 1746786944000,
        "championPointsSinceLastLevel": 6582,
        "championPointsUntilNextLevel": 18,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 203,
        "championLevel": 3,
        "championPoints": 12577,
        "lastPlayTime": 1687456648000,
        "championPointsSinceLastLevel": 6577,
        "championPointsUntilNextLevel": 23,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 113,
        "championLevel": 3,
        "championPoints": 12239,
        "lastPlayTime": 1756659987000,
        "championPointsSinceLastLevel": 6239,
        "championPointsUntilNextLevel": 361,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 147,
        "championLevel": 3,
        "championPoints": 11946,
        "lastPlayTime": 1757091096000,
        "championPointsSinceLastLevel": 5946,
        "championPointsUntilNextLevel": 654,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 3,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 22,
        "championLevel": 3,
        "championPoints": 11440,
        "lastPlayTime": 1753966312000,
        "championPointsSinceLastLevel": 5440,
        "championPointsUntilNextLevel": 1160,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 3,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 21,
        "championLevel": 3,
        "championPoints": 11311,
        "lastPlayTime": 1714025136000,
        "championPointsSinceLastLevel": 5311,
        "championPointsUntilNextLevel": 1289,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 99,
        "championLevel": 3,
        "championPoints": 10758,
        "lastPlayTime": 1756728544000,
        "championPointsSinceLastLevel": 4758,
        "championPointsUntilNextLevel": 1842,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 3,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 48,
        "championLevel": 3,
        "championPoints": 10478,
        "lastPlayTime": 1754500862000,
        "championPointsSinceLastLevel": 4478,
        "championPointsUntilNextLevel": 2122,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 98,
        "championLevel": 3,
        "championPoints": 10210,
        "lastPlayTime": 1608216219000,
        "championPointsSinceLastLevel": 4210,
        "championPointsUntilNextLevel": 2390,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 86,
        "championLevel": 3,
        "championPoints": 9746,
        "lastPlayTime": 1746457340000,
        "championPointsSinceLastLevel": 3746,
        "championPointsUntilNextLevel": 2854,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 2,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 9,
        "championLevel": 3,
        "championPoints": 9132,
        "lastPlayTime": 1767513196000,
        "championPointsSinceLastLevel": 3132,
        "championPointsUntilNextLevel": 3468,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 26,
        "championLevel": 3,
        "championPoints": 8980,
        "lastPlayTime": 1591463339000,
        "championPointsSinceLastLevel": 2980,
        "championPointsUntilNextLevel": 3620,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 800,
        "championLevel": 3,
        "championPoints": 8964,
        "lastPlayTime": 1745682955000,
        "championPointsSinceLastLevel": 2964,
        "championPointsUntilNextLevel": 3636,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 8,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 523,
        "championLevel": 3,
        "championPoints": 8595,
        "lastPlayTime": 1767807207000,
        "championPointsSinceLastLevel": 2595,
        "championPointsUntilNextLevel": 4005,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 221,
        "championLevel": 3,
        "championPoints": 8566,
        "lastPlayTime": 1753858383000,
        "championPointsSinceLastLevel": 2566,
        "championPointsUntilNextLevel": 4034,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 72,
        "championLevel": 3,
        "championPoints": 8532,
        "lastPlayTime": 1765021296000,
        "championPointsSinceLastLevel": 2532,
        "championPointsUntilNextLevel": 4068,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 904,
        "championLevel": 3,
        "championPoints": 8427,
        "lastPlayTime": 1768920205000,
        "championPointsSinceLastLevel": 2427,
        "championPointsUntilNextLevel": 4173,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 6,
        "championSeasonMilestone": 3,
        "milestoneGrades": [],
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "S-": 1
            },
            "rewardMarks": 2,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 28,
        "championLevel": 3,
        "championPoints": 8191,
        "lastPlayTime": 1607452276000,
        "championPointsSinceLastLevel": 2191,
        "championPointsUntilNextLevel": 4409,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 102,
        "championLevel": 3,
        "championPoints": 8178,
        "lastPlayTime": 1742494637000,
        "championPointsSinceLastLevel": 2178,
        "championPointsUntilNextLevel": 4422,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 27,
        "championLevel": 3,
        "championPoints": 8006,
        "lastPlayTime": 1654435070000,
        "championPointsSinceLastLevel": 2006,
        "championPointsUntilNextLevel": 4594,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 25,
        "championLevel": 3,
        "championPoints": 7970,
        "lastPlayTime": 1765373138000,
        "championPointsSinceLastLevel": 1970,
        "championPointsUntilNextLevel": 4630,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 2,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 77,
        "championLevel": 3,
        "championPoints": 7847,
        "lastPlayTime": 1757249502000,
        "championPointsSinceLastLevel": 1847,
        "championPointsUntilNextLevel": 4753,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 235,
        "championLevel": 3,
        "championPoints": 7767,
        "lastPlayTime": 1748275324000,
        "championPointsSinceLastLevel": 1767,
        "championPointsUntilNextLevel": 4833,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 16,
        "championLevel": 3,
        "championPoints": 7618,
        "lastPlayTime": 1742473868000,
        "championPointsSinceLastLevel": 1618,
        "championPointsUntilNextLevel": 4982,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 143,
        "championLevel": 3,
        "championPoints": 7592,
        "lastPlayTime": 1757342410000,
        "championPointsSinceLastLevel": 1592,
        "championPointsUntilNextLevel": 5008,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 106,
        "championLevel": 3,
        "championPoints": 7402,
        "lastPlayTime": 1755515197000,
        "championPointsSinceLastLevel": 1402,
        "championPointsUntilNextLevel": 5198,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 10,
        "championLevel": 3,
        "championPoints": 6655,
        "lastPlayTime": 1655732836000,
        "championPointsSinceLastLevel": 655,
        "championPointsUntilNextLevel": 5945,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 29,
        "championLevel": 3,
        "championPoints": 6630,
        "lastPlayTime": 1750935454000,
        "championPointsSinceLastLevel": 630,
        "championPointsUntilNextLevel": 5970,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 15,
        "championLevel": 3,
        "championPoints": 6466,
        "lastPlayTime": 1753986167000,
        "championPointsSinceLastLevel": 466,
        "championPointsUntilNextLevel": 6134,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 44,
        "championLevel": 3,
        "championPoints": 6398,
        "lastPlayTime": 1657094951000,
        "championPointsSinceLastLevel": 398,
        "championPointsUntilNextLevel": 6202,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 63,
        "championLevel": 3,
        "championPoints": 6348,
        "lastPlayTime": 1500493689000,
        "championPointsSinceLastLevel": 348,
        "championPointsUntilNextLevel": 6252,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 115,
        "championLevel": 3,
        "championPoints": 6247,
        "lastPlayTime": 1747024680000,
        "championPointsSinceLastLevel": 247,
        "championPointsUntilNextLevel": 6353,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 36,
        "championLevel": 2,
        "championPoints": 5953,
        "lastPlayTime": 1765260628000,
        "championPointsSinceLastLevel": 4153,
        "championPointsUntilNextLevel": 47,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 96,
        "championLevel": 2,
        "championPoints": 5694,
        "lastPlayTime": 1744117748000,
        "championPointsSinceLastLevel": 3894,
        "championPointsUntilNextLevel": 306,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 57,
        "championLevel": 2,
        "championPoints": 5421,
        "lastPlayTime": 1755959945000,
        "championPointsSinceLastLevel": 3621,
        "championPointsUntilNextLevel": 579,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 420,
        "championLevel": 2,
        "championPoints": 5399,
        "lastPlayTime": 1753349795000,
        "championPointsSinceLastLevel": 3599,
        "championPointsUntilNextLevel": 601,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 200,
        "championLevel": 2,
        "championPoints": 5162,
        "lastPlayTime": 1746201396000,
        "championPointsSinceLastLevel": 3362,
        "championPointsUntilNextLevel": 838,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 222,
        "championLevel": 2,
        "championPoints": 4979,
        "lastPlayTime": 1619968118000,
        "championPointsSinceLastLevel": 3179,
        "championPointsUntilNextLevel": 1021,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 11,
        "championLevel": 2,
        "championPoints": 4909,
        "lastPlayTime": 1765343045000,
        "championPointsSinceLastLevel": 3109,
        "championPointsUntilNextLevel": 1091,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 119,
        "championLevel": 2,
        "championPoints": 4696,
        "lastPlayTime": 1722621076000,
        "championPointsSinceLastLevel": 2896,
        "championPointsUntilNextLevel": 1304,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 950,
        "championLevel": 2,
        "championPoints": 4616,
        "lastPlayTime": 1744132962000,
        "championPointsSinceLastLevel": 2816,
        "championPointsUntilNextLevel": 1384,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 2,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 526,
        "championLevel": 2,
        "championPoints": 4370,
        "lastPlayTime": 1743697037000,
        "championPointsSinceLastLevel": 2570,
        "championPointsUntilNextLevel": 1630,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 33,
        "championLevel": 2,
        "championPoints": 4228,
        "lastPlayTime": 1746522928000,
        "championPointsSinceLastLevel": 2428,
        "championPointsUntilNextLevel": 1772,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 35,
        "championLevel": 2,
        "championPoints": 4041,
        "lastPlayTime": 1621192393000,
        "championPointsSinceLastLevel": 2241,
        "championPointsUntilNextLevel": 1959,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 54,
        "championLevel": 2,
        "championPoints": 3963,
        "lastPlayTime": 1768493505000,
        "championPointsSinceLastLevel": 2163,
        "championPointsUntilNextLevel": 2037,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "milestoneGrades": [
            "B+"
        ],
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 37,
        "championLevel": 2,
        "championPoints": 3938,
        "lastPlayTime": 1560881321000,
        "championPointsSinceLastLevel": 2138,
        "championPointsUntilNextLevel": 2062,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 83,
        "championLevel": 2,
        "championPoints": 3593,
        "lastPlayTime": 1757424944000,
        "championPointsSinceLastLevel": 1793,
        "championPointsUntilNextLevel": 2407,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 141,
        "championLevel": 2,
        "championPoints": 3322,
        "lastPlayTime": 1754927988000,
        "championPointsSinceLastLevel": 1522,
        "championPointsUntilNextLevel": 2678,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 32,
        "championLevel": 2,
        "championPoints": 3267,
        "lastPlayTime": 1757344249000,
        "championPointsSinceLastLevel": 1467,
        "championPointsUntilNextLevel": 2733,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 360,
        "championLevel": 2,
        "championPoints": 3261,
        "lastPlayTime": 1746630196000,
        "championPointsSinceLastLevel": 1461,
        "championPointsUntilNextLevel": 2739,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 888,
        "championLevel": 2,
        "championPoints": 2464,
        "lastPlayTime": 1757697347000,
        "championPointsSinceLastLevel": 664,
        "championPointsUntilNextLevel": 3536,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 2,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 267,
        "championLevel": 2,
        "championPoints": 2457,
        "lastPlayTime": 1756214937000,
        "championPointsSinceLastLevel": 657,
        "championPointsUntilNextLevel": 3543,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 40,
        "championLevel": 2,
        "championPoints": 2040,
        "lastPlayTime": 1756474170000,
        "championPointsSinceLastLevel": 240,
        "championPointsUntilNextLevel": 3960,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 1,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 902,
        "championLevel": 2,
        "championPoints": 2022,
        "lastPlayTime": 1755702289000,
        "championPointsSinceLastLevel": 222,
        "championPointsUntilNextLevel": 3978,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 19,
        "championLevel": 1,
        "championPoints": 1656,
        "lastPlayTime": 1573451567000,
        "championPointsSinceLastLevel": 1656,
        "championPointsUntilNextLevel": 144,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 350,
        "championLevel": 1,
        "championPoints": 1249,
        "lastPlayTime": 1631983255000,
        "championPointsSinceLastLevel": 1249,
        "championPointsUntilNextLevel": 551,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 74,
        "championLevel": 1,
        "championPoints": 710,
        "lastPlayTime": 1672807717000,
        "championPointsSinceLastLevel": 710,
        "championPointsUntilNextLevel": 1090,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    },
    {
        "puuid": "9ZKvFEpz63JV5eIrHEulz_lG-GsVjI3_azpft9SW8i0aQKb02YM_wm4_vvDy2OersdtbkPucWndp1A",
        "championId": 17,
        "championLevel": 1,
        "championPoints": 338,
        "lastPlayTime": 1490025219000,
        "championPointsSinceLastLevel": 338,
        "championPointsUntilNextLevel": 1462,
        "markRequiredForNextLevel": 0,
        "tokensEarned": 0,
        "championSeasonMilestone": 0,
        "nextSeasonMilestone": {
            "requireGradeCounts": {
                "A-": 1
            },
            "rewardMarks": 1,
            "bonus": false,
            "totalGamesRequires": 1
        }
    }
]
""".data(using: .utf8)
