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
    let container: ModelContainer
    
    var body: some Scene {
        WindowGroup {
            ContentView(modelContext: container.mainContext)
        }
        .modelContainer(container)
    }
    
    init() {
        do {
            container = try ModelContainer(for: User.self)
        } catch {
            fatalError("Failed to create ModelContainer for Users.")
        }
    }
}
