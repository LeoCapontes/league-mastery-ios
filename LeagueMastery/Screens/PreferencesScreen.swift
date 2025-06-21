//
//  PreferencesScreen.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 18/06/2025.
//
import SwiftUI
import Kingfisher

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
            Section(footer: Text("Clears saved champion splash arts, useful for when a champion's splash art gets updated")){
                Button(action: clearImageCache){
                    Text("Clear image cache")
                }
            }
        }
        .navigationTitle(Text("Settings"))
    }
}

func clearImageCache() {
    let cache = ImageCache.default
    cache.clearMemoryCache()
    cache.clearDiskCache()
}

enum LevelUpIndicatorMode: String, CaseIterable, Identifiable {
    case holographic
    case pip
    
    var id: String { rawValue }
}
