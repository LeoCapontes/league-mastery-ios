//
//  User.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 10/02/2025.
//

import Foundation
import SwiftData

@Model
final class User {
    // An array of champion IDs
    var championWatchlist: [Int] = []
    
    // filled by puuid api response
    @Attribute(.unique) var puuid: String
    var name: String
    var tagline: String
    var isFavourite: Bool
    var region: String
    var server: String
    
    // from summoner-v4
    var profileIconId: Int
    var summonerLevel: Int
    
    // from mastery-v4
    var masteryScore: Int
    
    init(
        puuid: String,
        name: String,
        tagline: String,
        isFavourite: Bool = false,
        region: String,
        server: String,
        profileIconId: Int,
        summonerLevel: Int,
        masteryScore: Int
    ) {
        self.puuid = puuid
        self.name = name
        self.tagline = tagline
        self.isFavourite = isFavourite
        self.region = region
        self.server = server
        self.profileIconId = profileIconId
        self.summonerLevel = summonerLevel
        self.masteryScore = masteryScore
    }
}
