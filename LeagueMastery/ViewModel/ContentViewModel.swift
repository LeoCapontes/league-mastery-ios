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
        var pinnedUser: User?
        var pinnedResponse: [MasteryResponse]?
        var path = [Route]()
        
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
        
        func setCurrentSummoner() {
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
                        region: selectedRegion.description
                    )
                    
                    response = try await masteryApiCall(
                        puuid:puuidResponse.puuid,
                        selectedServer: selectedServer
                    )
                    
                    let summonerResponse = try await summonerInfoApiCall(
                        puuid: puuidResponse.puuid,
                        selectedServer: selectedServer.raw
                    )
                    
                    let masteryScoreResponse = try await masteryScoreApiCall(
                        puuid: puuidResponse.puuid,
                        selectedServer: selectedServer.raw
                    )
                                        
                    let searchedUser = User(
                        puuid: puuidResponse.puuid,
                        name: sumName,
                        tagline: sumTag,
                        region: selectedRegion.description,
                        server: selectedServer.raw,
                        profileIconId: summonerResponse.profileIconId,
                        summonerLevel: summonerResponse.summonerLevel,
                        masteryScore: masteryScoreResponse
                    )
                    
                    // swift data model context tasks should be done in
                    // main queue to ensure persistence
                    Task { @MainActor in
                        addUser(newUser: searchedUser)
                        if let newUser = modelContext.model(for: getUserIdentifier(puuid: puuidResponse.puuid)!) as? User {
                            userToDisplay = newUser
#if DEBUG
                            print("User is level: ", userToDisplay!.summonerLevel)
#endif
                            showingProgress = false
                            showingScreen = true
                            path.append(.account)
                        } else {
                            print("couldnt assign user")
                        }
                    }
                } catch {
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
        
        func setCurrentSummoner(name: String, tag: String, region: String, server: String){
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
                    
                    let summonerResponse = try await summonerInfoApiCall(
                        puuid: puuidResponse.puuid,
                        selectedServer: server
                    )
                    let masteryScoreResponse = try await masteryScoreApiCall(
                        puuid: puuidResponse.puuid,
                        selectedServer: selectedServer.raw
                    )
                    
                    if let selectedUser = modelContext.model(for: getUserIdentifier(puuid: puuidResponse.puuid)!) as? User {
                        // fetch new details
                        Task {@MainActor in
                            selectedUser.profileIconId = summonerResponse.profileIconId
                            selectedUser.masteryScore = masteryScoreResponse
                        }
                        userToDisplay = selectedUser
#if DEBUG
                        print("User is level: ", userToDisplay!.summonerLevel)
#endif
                        showingProgress = false
                        showingScreen = true
                        path.append(.account)
                    } else {
                        print("couldnt select user")
                    }
                } catch {
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
            server: String,
            profileIconId: Int,
            summonerLevel: Int,
            masteryScore: Int
        ){
            let newUser = User(
                puuid: puuid,
                name: name,
                tagline: tag,
                region: region,
                server: server,
                profileIconId: profileIconId,
                summonerLevel: summonerLevel,
                masteryScore: masteryScore
            )
            
            modelContext.insert(newUser)
            do {
                try modelContext.save()
            } catch {
                print("couldn't save context")
            }
        }
        
        func addUser(newUser: User){
            modelContext.insert(newUser)
            do{
                try modelContext.save()
            } catch {
                print("couldn't save context")
            }
        }
        
        func addToWatchlist(user: User, champId: Int) {
            fetchData()
            Task { @MainActor in
                if let userToEdit = modelContext.model(for: user.id) as? User {
                    userToEdit.championWatchlist.append(champId)
                    do {
                        try modelContext.save()
                        print("saved context, watchlist: \(userToEdit.championWatchlist)")
                    } catch {
                        print("couldn't save context")
                    }
                } else {
                    print("Could not add to watch list")
                }
            }
        }
        
        func removeFromWatchlist(user: User, champId: Int) {
            fetchData()
            Task { @MainActor in
                if let userToEdit = modelContext.model(for: user.id) as? User {
                    userToEdit.championWatchlist.removeAll(where: { $0 == champId })
                    do {
                        try modelContext.save()
                        print("saved context, watchlist: \(userToEdit.championWatchlist)")
                    } catch {
                        print("couldn't save context")
                    }
                } else {
                    print("Couldn't remove from watch list")
                }
            }
        }
        
        func deleteAllUsers() {
            do {
                let users = try modelContext.fetch(FetchDescriptor<User>())
                for user in users {
                    modelContext.delete(user)
                }
                do {
                    try modelContext.save()
                } catch {
                    print("couldn't save context")
                }
            } catch {
                print("Failed to delete users")
            }
        }
        
        func getUserIdentifier(puuid: String) -> PersistentIdentifier? {
            fetchData()
            let fetchDescriptor = FetchDescriptor<User>(
                predicate: #Predicate {user in user.puuid == puuid }
            )
            if let user = try? modelContext.fetch(fetchDescriptor).first {
                return user.persistentModelID
            } else {
                return nil
            }
        }
        
        // make sure data is up to date.
        func fetchData() {
            do {
                let descriptor = FetchDescriptor<User>(sortBy: [SortDescriptor(\.puuid)])
                users = try modelContext.fetch(descriptor)
            } catch {
                print("Fetch failed")
            }
        }
        
        func setupPinnedUser() {
            Task{
                do {
                    let descriptor = FetchDescriptor<User>(sortBy: [SortDescriptor(\.isFavourite)])
                    let favourited = try modelContext.fetch(descriptor)
                    print(favourited.map({ return $0.name }))
                    pinnedUser = favourited.last
                    
                    let puuidResponse = try await puuidApiCall(
                        gameName: pinnedUser!.name,
                        tag: pinnedUser!.tagline,
                        region: pinnedUser!.region
                    )
                    
                    pinnedResponse = try await masteryApiCall(
                        puuid:puuidResponse.puuid,
                        selectedServer: pinnedUser!.server
                    )
                } catch {
                    print("setting pinned failed")
                }
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
    case ru2
    case sg2
    case tr1
    case tw2
    case vn2
    
    var id: Self { self }
    
    var description: String {
        switch self{
        case .br1:
            return "BR"
        case .eun1:
            return "EUNE"
        case .euw1:
            return "EUW"
        case .jp1:
            return "JP"
        case .kr:
            return "KR"
        case .la1:
            return "LAN"
        case .la2:
            return "LAS"
        case .me1:
            return "ME"
        case .na1:
            return "NA"
        case .oc1:
            return "OCE"
        case .vn2:
            return "VN"
        case .tw2:
            return "TW"
        case .sg2:
            return "SEA"
        case .tr1:
            return "TR"
        case .ru2:
            return "RU"
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
        case .ru2:
            return "ru2"
        case .sg2:
            return "sg2"
        case .tr1:
            return "tr1"
        case .tw2:
            return "tw2"
        case .vn2:
            return "vn2"
        }
    }
}
