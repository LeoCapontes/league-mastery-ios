//
//  ApiCalls.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 15/07/2024.
//

import Foundation

func championsApiCall() async throws -> Champions{
    let url = URL(string: "https://ddragon.leagueoflegends.com/cdn/\(Settings.shared.lolVersion)/data/en_US/champion.json")!
    print(url.absoluteString)
    let (data, _) = try await URLSession.shared.data(from: url)
    let response = try JSONDecoder().decode(Champions.self, from: data)
    return response
}


// TODO handle errors more gracefully/granularly
func puuidApiCall(
    gameName: String,
    tag: String,
    region: String
) async throws -> PuuidResponse{
    let url = URL(string: "\(Settings.shared.serverUrl)/account/by-riot-id/\(region)/\(gameName)/\(tag)")!
    do {
        print(url.absoluteString)
        let (data, httpResponse) = try await URLSession.shared.data(from: url)
        print(data.prettyPrintedJSONString)
        guard let httpResponse = httpResponse as? HTTPURLResponse else{
            throw URLError(.badServerResponse)
        }
        if httpResponse.statusCode == 200 {
            let response = try JSONDecoder().decode(PuuidResponse.self, from: data)
            return response
        } else {
            print(httpResponse.statusCode)
            if httpResponse.statusCode == 404 {
                print("Throwing no data found")
                throw ApiError.noDataFound
            }
            if httpResponse.statusCode == 400 {
                print("Throwing no key")
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
    let serverString = selectedServer.raw
    let url = URL(string: "\(Settings.shared.serverUrl)/mastery/by-puuid/\(serverString)/\(puuid)")!
    print(url.absoluteString)
    do{
        let (data, httpResponse) = try await URLSession.shared.data(from: url)
        guard let httpResponse = httpResponse as? HTTPURLResponse else {
            throw URLError(.badServerResponse)
        }
        if httpResponse.statusCode == 200{
            let response = try JSONDecoder().decode([MasteryResponse].self, from: data)
            return response
        } else {
            print(httpResponse.statusCode)
            if httpResponse.statusCode == 404 {
                print("Throwing no data found")
                throw ApiError.noDataFound
            }
            if httpResponse.statusCode == 400 {
                print("Throwing no key")
                throw ApiError.noKey
            }
            throw ApiError.other("Search failed")
        }
    }
}

func masteryApiCall(
    puuid: String,
    selectedServer: String
) async throws -> [MasteryResponse]{
    let serverString = selectedServer
    let url = URL(string: "\(Settings.shared.serverUrl)/mastery/by-puuid/\(serverString)/\(puuid)")!
    print(url.absoluteString)
    do{
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode([MasteryResponse].self, from: data)
        return response
    } catch {
        throw error
    }
}

func summonerInfoApiCall(
    puuid: String,
    selectedServer: String
) async throws -> SummonerResponse{
    let serverString = selectedServer
    let url = URL(string:"\(Settings.shared.serverUrl)/summoner/by-puuid/\(serverString)/\(puuid)")!
    print(url.absoluteString)
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
    print(url.absoluteString)
    
    do{
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(Int.self, from: data)
        return response
    }catch {
        throw error
    }
}

func profileIconUrl(profileIconId: Int) -> String {
    return "https://ddragon.leagueoflegends.com/cdn/15.7.1/img/profileicon/\(profileIconId).png"
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
