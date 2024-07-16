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
        var selectedRegion: region = .europe
        
        init() {
            populateChampions()
        }
        
        func searchSumm() {
            print("called")
            guard let splitName = splitGameName(sumName) else {
                return
            }
            print(splitName)
            
            Task {
                print("Doing task")
                do {
                    let puuidResponse = try await puuidApiCall(
                        gameName: splitName[0],
                        tag: splitName[1],
                        region: selectedRegion.description)
                    
                    response = try await masteryApiCall(puuid:puuidResponse.puuid)
                    showingScreen = true
                }catch{
                    response = nil
                    print("Error in task \(error)")
                }
            }
        }
        
        func splitGameName(_ name : String) -> [String]? {
            let splitName = name.components(separatedBy: "#")
            if(splitName.count != 2){
                return nil
            }
            return splitName
        }
    }
    
    enum region: CaseIterable, Identifiable, CustomStringConvertible {
        case europe
        case americas
        case asia
        
        var id: Self { self }
        
        var description: String {
            switch self {
            case .europe:
                return "Europe"
            case .americas:
                return "Americas"
            case .asia:
                return "Asia"
            }
        }
    }
}
