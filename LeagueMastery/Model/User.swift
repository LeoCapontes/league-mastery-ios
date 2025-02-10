//
//  User.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 10/02/2025.
//

import Foundation
import SwiftData

@Model
class User {
    // filled by puuid api response
    @Attribute(.unique) var puuid: String
    var name: String
    var tagline: String
    
    var isFavourite: Bool
    
    init(puuid: String, name: String, tagline: String, isFavourite: Bool = false) {
        self.puuid = puuid
        self.name = name
        self.tagline = tagline
        self.isFavourite = isFavourite
    }
}
