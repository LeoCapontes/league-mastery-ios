//
//  LeagueMasteryApp.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 29/05/2024.
//

import SwiftUI
import SwiftData

@main
struct LeagueMasteryApp: App {
    var body: some Scene {
        WindowGroup {
            ContentView()
        }
        .modelContainer(for: User.self)
    }
}
