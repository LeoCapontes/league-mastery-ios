//
//  LeagueMasteryApp.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 29/05/2024.
//

import SwiftUI

@main
struct LeagueMasteryApp: App {
    let defaults = UserDefaults.standard
    var body: some Scene {
        WindowGroup {
            ContentView(viewmodel: ContentView.ViewModel.init(userDefaults: defaults))
        }
    }
}
