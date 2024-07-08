//
//  Settings.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 08/07/2024.
//

import Foundation
import Combine

class Settings {
    static let shared = Settings()
    let key = ProcessInfo.processInfo.environment["RIOT_API_KEY"]
    
    private init(){}
}
