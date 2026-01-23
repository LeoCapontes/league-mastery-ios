//
//  ApiCalls.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 15/07/2024.
//

import Foundation
import OSLog

actor APIClient {
    private let masteryResponseCache: NSCache<NSString, MasteryCacheEntryObject> = NSCache()
    
    // TODO handle errors more gracefully/granularly
    func puuidApiCall(
        gameName: String,
        tag: String,
        region: String
    ) async throws -> PuuidResponse{
        let url = URL(string: "\(Settings.shared.serverUrl)/account/by-riot-id/\(region.lowercased())/\(gameName)/\(tag)")!
        do {
            Logger.apiCalls.debug("PUUID API: \(url.absoluteString)")
            let (data, httpResponse) = try await URLSession.shared.data(from: url)
            Logger.apiCalls.debug("PUUID response: \(data.prettyPrintedJSONString ?? "nil")")
            guard let httpResponse = httpResponse as? HTTPURLResponse else{
                throw URLError(.badServerResponse)
            }
            if httpResponse.statusCode == 200 {
                let response = try JSONDecoder().decode(PuuidResponse.self, from: data)
                return response
            } else {
                Logger.apiCalls.warning("PUUID API error status: \(httpResponse.statusCode)")
                if httpResponse.statusCode == 404 {
                    Logger.apiCalls.debug("Throwing noDataFound")
                    throw ApiError.noDataFound
                }
                if httpResponse.statusCode == 400 {
                    Logger.apiCalls.warning("Throwing noKey - API key issue")
                    throw ApiError.noKey
                }
                throw ApiError.other("Search failed")
            }
        }
    }
    
    func masteryApiCall(
        puuid: String,
        selectedServer: Server
    ) async throws -> [MasteryResponse]{
        return try await masteryApiCall(puuid: puuid, selectedServer: selectedServer.raw)
    }
    
    func masteryApiCall(
        puuid: String,
        selectedServer: String
    ) async throws -> [MasteryResponse]{
        if let cached = masteryResponseCache[puuid] {
            Logger.apiCalls.debug("Mastery API: Result already cached or in progress")
            switch cached {
            case .ready(let response):
                Logger.apiCalls.debug("MasteryAPI: Returning cached response")
                return response
            case .inProgress(let task):
                return try await task.value
            }
        }
        
        let task = Task<[MasteryResponse], Error> {
            Logger.apiCalls.debug("Mastery API: Starting call task")
            let url = URL(string: "\(Settings.shared.serverUrl)/mastery/by-puuid/\(selectedServer)/\(puuid)")!
            Logger.apiCalls.debug("Mastery API: \(url.absoluteString)")
            do{
                let (data, httpResponse) = try await URLSession.shared.data(from: url)
                guard let httpResponse = httpResponse as? HTTPURLResponse else {
                    throw URLError(.badServerResponse)
                }
                if httpResponse.statusCode == 200{
                    let response = try JSONDecoder().decode([MasteryResponse].self, from: data)
                    return response
                } else {
                    Logger.apiCalls.warning("Mastery API error status: \(httpResponse.statusCode)")
                    if httpResponse.statusCode == 404 {
                        Logger.apiCalls.debug("Throwing noDataFound")
                        throw ApiError.noDataFound
                    }
                    if httpResponse.statusCode == 400 {
                        Logger.apiCalls.warning("Throwing noKey - API key issue")
                        throw ApiError.noKey
                    }
                    throw ApiError.other("Search failed")
                }
            }
        }
        
        masteryResponseCache[puuid] = .inProgress(task)
        do {
            let response = try await task.value
            masteryResponseCache[puuid] = .ready(response)
            return response
        } catch {
            Logger.apiCalls.error("Mastery API: Failed returning response from task")
            masteryResponseCache[puuid] = nil
            throw error
        }
    }
    
    func summonerInfoApiCall(
        puuid: String,
        selectedServer: String
    ) async throws -> SummonerResponse{
        let serverString = selectedServer
        let url = URL(string:"\(Settings.shared.serverUrl)/summoner/by-puuid/\(serverString)/\(puuid)")!
        Logger.apiCalls.debug("Summoner API: \(url.absoluteString)")
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(SummonerResponse.self, from: data)
            return response
        }catch {
            throw error
        }
    }
    
    func masteryScoreApiCall(
        puuid: String,
        selectedServer: String
    ) async throws -> Int{
        let serverString = selectedServer
        let url = URL(string:"\(Settings.shared.serverUrl)/masteryscore/by-puuid/\(serverString)/\(puuid)")!
        Logger.apiCalls.debug("Mastery Score API: \(url.absoluteString)")
        
        do{
            let (data, _) = try await URLSession.shared.data(from: url)
            let response = try JSONDecoder().decode(Int.self, from: data)
            return response
        }catch {
            throw error
        }
    }
}

func championsApiCall() async throws -> Champions{
    let url = URL(string: "https://ddragon.leagueoflegends.com/cdn/\(Settings.shared.lolVersion)/data/en_US/champion.json")!
    Logger.apiCalls.debug("Champions API: \(url.absoluteString)")
    let (data, _) = try await URLSession.shared.data(from: url)
    let response = try JSONDecoder().decode(Champions.self, from: data)
    return response
}

func profileIconUrl(profileIconId: Int) -> String {
    return "https://raw.communitydragon.org/latest/plugins/rcp-be-lol-game-data/global/default/v1/profile-icons/\(profileIconId).jpg"
}

func versionApiCall() async throws -> [String]{
    let url = URL(string: "https://ddragon.leagueoflegends.com/api/versions.json")!
    let (data, _) = try await URLSession.shared.data(from: url)
    let response = try JSONDecoder().decode([String].self, from: data)
    return response
}


// From: https://gist.github.com/cprovatas/5c9f51813bc784ef1d7fcbfb89de74fe
extension Data {
    var prettyPrintedJSONString: NSString? { /// NSString gives us a nice sanitized debugDescription
        guard let object = try? JSONSerialization.jsonObject(with: self, options: []),
              let data = try? JSONSerialization.data(withJSONObject: object, options: [.prettyPrinted]),
              let prettyPrintedString = NSString(data: data, encoding: String.Encoding.utf8.rawValue) else { return nil }

        return prettyPrintedString
    }
}

enum ApiError: Error {
    case noDataFound
    case noKey
    case other(String)
}
