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
        var response: [MasteryResponse]?
        var showingScreen = false
        
        init() {
            populateChampions()
        }
        
        func searchSumm() {
            print("called")
            Task {
                print("Doing task")
                do {
                    response = try await masteryApiCall()
                    var topChamp = splashFromChampId(response![0].championId)
                    splashUrl = "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/\(sumName)_0.jpg"
                    showingScreen = true
                }catch{
                    response = nil
                    print("Error in task \(error)")
                }
            }
        }
        
    }
}
