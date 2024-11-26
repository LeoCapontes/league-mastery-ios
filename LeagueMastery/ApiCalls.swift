//
//  ApiCalls.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 15/07/2024.
//

import Foundation

func championsApiCall() async throws -> Champions{
    //TODO get current version through datadragon
    let url = URL(string: "https://ddragon.leagueoflegends.com/cdn/14.22.1/data/en_US/champion.json")!
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
        let (data, _) = try await URLSession.shared.data(from: url)
        let response = try JSONDecoder().decode(PuuidResponse.self, from: data)
        return response
    } catch {
        throw error
    }
}

func masteryApiCall(
    puuid: String,
    selectedServer: server
) async throws -> [MasteryResponse]{
    let serverString = selectedServer.raw
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
