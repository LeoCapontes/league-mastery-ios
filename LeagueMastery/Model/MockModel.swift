//
//  MockModel.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 08/07/2024.
//

import Foundation
import SwiftyJSON
let mockPuuidJson = "{\"puuid\": \"Q46FXYK5hAgW61CqZ9IiQqyR6e3nbTns_iR3cgTTeSD3XN-TpnFq_QYbrbPyd10Jrg-HT-aCZ5zBxg\",\"gameName\": \"leeoo\", \"tagLine\": \"EUW\"}"

let mockTopThreeMasteryRequest = "https://euw1.api.riotgames.com/lol/champion-mastery/v4/champion-masteries/by-puuid/Q46FXYK5hAgW61CqZ9IiQqyR6e3nbTns_iR3cgTTeSD3XN-TpnFq_QYbrbPyd10Jrg-HT-aCZ5zBxg/top?count=3&api_key=\(Settings.shared.key)"
