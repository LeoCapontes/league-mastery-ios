//
//  PreferencesScreen.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 18/06/2025.
//
import SwiftUI

struct PreferencesScreen: View {
    @AppStorage("evelvlUpIndicator")
    private var levelUpIndicator: String = LevelUpIndicatorMode.holographic.rawValue
    
    var body: some View {
        
    }
}

enum LevelUpIndicatorMode: String, CaseIterable, Identifiable {
    case holographic
    case pip
    
    var id: String { rawValue }
}
