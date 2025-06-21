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
    
    @State private var showingCacheAlert = false
    
    var body: some View {
        Form{
            Picker("Level up indicator", selection: $levelUpIndicator) {
                ForEach(LevelUpIndicatorMode.allCases) { mode in
                    Text(mode.rawValue)
                }
            }
            Section(footer: Text("Clears saved champion splash arts, useful for when a champion's splash art gets updated")){
                Button(action: { clearImageCache(showingAlert: $showingCacheAlert) }){
                    Text("Clear image cache")
                }
            }
        }
        .alert("Cache cleared", isPresented: $showingCacheAlert) {
            Button("OK", role: .cancel) {}
        }
        .navigationTitle(Text("Settings"))
    }
}

func clearImageCache(showingAlert: Binding<Bool>) {
    let cache = ImageCache.default
    cache.clearMemoryCache()
    cache.clearDiskCache{showingAlert.wrappedValue = true}
}

enum LevelUpIndicatorMode: String, CaseIterable, Identifiable {
    case holographic
    case pip
    
    var id: String { rawValue }
}
