//
//  ContentViewModel.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 29/05/2024.
//

import Foundation
import SwiftData
import Combine

extension ContentView {
    @Observable
    class ViewModel{
        var modelContext: ModelContext
        var users = [User]()
        var userToDisplay: User?
        
        var sumName: String = ""
        var sumTag: String = ""
        var splashUrl: String = ""
        var response: [MasteryResponse]?
        var showingScreen = false
        var selectedServer: Server = .euw1
        
        var showingAlert = false
        var alertMessage = "Something went wrong"
        var showingProgress = false
        
        var selectedRegion: Region {
            switch selectedServer {
            case .br1, .la1, .la2, .na1:
                return .americas
            case .eun1, .euw1:
                return .europe
            case .jp1, .kr:
                return .asia
            default:
                return .asia
            }
        }
        
        init(modelContext: ModelContext) {
            self.modelContext = modelContext
            Settings.shared.UpdateGameVersion()
        }
        
        func searchSumm() {
//            print("called")
//            guard let splitName = splitGameName(sumName) else {
//                return
//            }
//            print(splitName)
            
            Task {
                print("Doing summoner search task")
                do {
                    showingProgress = true
                    let puuidResponse = try await puuidApiCall(
                        gameName: sumName,
                        tag: sumTag,
                        region: selectedRegion.description)
                    
                    response = try await masteryApiCall(
                        puuid:puuidResponse.puuid,
                        selectedServer: selectedServer)
                                        
                    let searchedUser = User(
                        puuid: puuidResponse.puuid,
                        name: sumName,
                        tagline: sumTag,
                        region: selectedRegion.description,
                        server: selectedServer.raw
                    )
                    
                    userToDisplay = searchedUser
                    
                    // swift data model context tasks should be done in
                    // main queue to ensure persistence

                    Task { @MainActor in
                        addUser(newUser: searchedUser)
                    }
                    showingProgress = false
                    showingScreen = true
                }catch{
                    showingProgress = false
                    response = nil
                    switch error {
                    case ApiError.noDataFound:
                        alertMessage = "Summoner not found"
                    case ApiError.noKey:
                        print("Something wrong with key")
                    default:
                        alertMessage = "Something went wrong"
                    }
                    print("Error in task \(error)")
                    showingAlert = true
                }
            }
        }
        
        func searchSumm(name: String, tag: String, region: String, server: String){
            Task {
#if DEBUG
                print("Doing search with params:")
                print("\(name), \(tag), \(region), \(server)")
#endif
                do {
                    showingProgress = true
                    let puuidResponse = try await puuidApiCall(
                        gameName: name,
                        tag: tag,
                        region: region.description)
                    
                    response = try await masteryApiCall(
                        puuid:puuidResponse.puuid,
                        selectedServer: server)
                    
                    let searchedUser = User(
                        puuid: puuidResponse.puuid,
                        name: name,
                        tagline: tag,
                        region: region,
                        server: server
                    )
                    
                    userToDisplay = searchedUser
                    showingProgress = false
                    showingScreen = true
                }catch{
                    showingProgress = false
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
        
        func addUser(
            puuid: String,
            name: String,
            tag: String,
            region: String,
            server: String
        ){
            let newUser = User(
                puuid: puuid,
                name: name,
                tagline: tag,
                region: region,
                server: server
            )
            
            modelContext.insert(newUser)
        }
        
        func addUser(newUser: User){
            modelContext.insert(newUser)
        }
        
        func deleteAllUsers() {
            do {
                let users = try modelContext.fetch(FetchDescriptor<User>())
                for user in users {
                    modelContext.delete(user)
                }
            } catch {
                print("Failed to delete users")
            }
        }
        
    }
}

enum Region: CaseIterable, Identifiable, CustomStringConvertible {
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

enum Server: CaseIterable, Identifiable, CustomStringConvertible {
    case br1
    case eun1
    case euw1
    case jp1
    case kr
    case la1
    case la2
    case me1
    case na1
    case oc1
    case ph2
    case ru2
    case sg2
    case th2
    case tr1
    case tw2
    case vn2
    
    var id: Self { self }
    
    var description: String {
        switch self{
        case .br1:
            return "Brazil"
        case .eun1:
            return "EUNE"
        case .euw1:
            return "EUW"
        case .jp1:
            return "Japan"
        case .kr:
            return "Korea"
        default:
            return "def"
        }
    }
    
    var raw: String {
        switch self {
        case .br1:
            return "br1"
        case .eun1:
            return "eun1"
        case .euw1:
            return "euw1"
        case .jp1:
            return "jp1"
        case .kr:
            return "kr"
        case .la1:
            return "la1"
        case .la2:
            return "la2"
        case .me1:
            return "me1"
        case .na1:
            return "na1"
        case .oc1:
            return "oc1"
        case .ph2:
            return "ph2"
        case .ru2:
            return "ru2"
        case .sg2:
            return "sg2"
        case .th2:
            return "th2"
        case .tr1:
            return "tr1"
        case .tw2:
            return "tw2"
        case .vn2:
            return "vn2"
        }
    }
}
