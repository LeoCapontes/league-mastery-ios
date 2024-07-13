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
        
        init() {
            
        }
        
        func searchSumm() {
            print("called")
            Task {
                print("Doing task")
                do {
                    response = try await masteryApiCall()
                    var topChamp = splashFromChampId(response![0].championId)
                    splashUrl = "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/\(sumName)_0.jpg"
                }catch{
                    response = nil
                    print("Error in task \(error)")
                }
            }
        }
        
        func masteryApiCall() async throws -> [MasteryResponse]{
            let url = URL(string: mockTopMasteryRequest(6))!
            print(url.absoluteString)
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode([MasteryResponse].self, from: data)
            return response
        }
        
    }
}
