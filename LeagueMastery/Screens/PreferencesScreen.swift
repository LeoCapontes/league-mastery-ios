//
//  PreferencesScreen.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 18/06/2025.
//
import SwiftUI

struct PreferencesScreen: View {
    @AppStorage("LevelUpIndicator")
    private var levelUpIndicator: String = LevelUpIndicatorMode.pip.rawValue
    
    var body: some View {
        Form{
            Picker("Level up indicator", selection: $levelUpIndicator) {
                ForEach(LevelUpIndicatorMode.allCases) { mode in
                    Text(mode.rawValue)
                }
            }
        }
    }
}

enum LevelUpIndicatorMode: String, CaseIterable, Identifiable {
    case holographic
    case pip
    
    var id: String { rawValue }
}
