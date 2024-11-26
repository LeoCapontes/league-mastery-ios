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
    
    let key: String
    let serverUrl: String
    
    private init() {
        let environmentVariables = ProcessInfo.processInfo.environment
        key = environmentVariables["RIOT_API_KEY"]!
        
        guard let serverUrl = Bundle.main.object(forInfoDictionaryKey: "Server Url") as? String else {
                    fatalError("SERVER_URL not found in Info.plist")
                }
        self.serverUrl = serverUrl
    }
}
