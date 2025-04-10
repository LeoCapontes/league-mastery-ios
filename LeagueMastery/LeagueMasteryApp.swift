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

// allows for sorting by bool
extension Bool: Comparable {
    public static func <(lhs: Self, rhs: Self) -> Bool {
        !lhs && rhs
    }
}

extension Int {
    // returns a string with the number in a compact format.
    // e.g. 100,000 -> 100K, 1,000,000 -> 1M
    // supports numbers under 1 trillion
    // doesn't support negative numbers
    func compact() -> String {
        if (self < 1000) {
            return String(self)
        }
        let formatter = NumberFormatter()
        formatter.usesSignificantDigits = true
        formatter.maximumSignificantDigits = 3
        if (self < 1000000) {
            var x: Float = Float(self)
            x = x/1000
            let number = NSNumber(value: x)
            return "\(formatter.string(from: number)!)K"
        }
        if (self < 1000000000) {
            var x: Float = Float(self)
            x = x/1000000
            let number = NSNumber(value: x)
            return "\(formatter.string(from: number)!)M"
        }
        if (self < 1000000000000) {
            var x: Float = Float(self)
            x = x/1000000000
            let number = NSNumber(value: x)
            return "\(formatter.string(from: number)!)B"
        }
        return String(self)
    }
}
