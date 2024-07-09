//
//  ContentViewModel.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 29/05/2024.
//

import Foundation
import Combine

extension ContentView {
    @Observable
    class ViewModel{
        var sumName: String = ""
        var splashUrl: String = ""
        func searchSumm() {
            print("sumname was \(sumName)")
            splashUrl = "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/\(sumName)_0.jpg"
        }
    }
}
