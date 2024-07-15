//
//  ApiCalls.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 15/07/2024.
//

import Foundation

func championsApiCall() async throws -> Champions{
    let url = URL(string: "https://ddragon.leagueoflegends.com/cdn/14.13.1/data/en_US/champion.json")!
    print(url.absoluteString)
    let (data, _) = try await URLSession.shared.data(from: url)
    let response = try JSONDecoder().decode(Champions.self, from: data)
    return response
}

func puuidApiCall(
    gameName: String,
    tag: String,
    region: String
) async throws -> PuuidResponse{
    let url = URL(string: "https://europe.api.riotgames.com/riot/account/v1/accounts/by-riot-id/leeoo/EUW?api_key=\(Settings.shared.key)")!
    print(url.absoluteString)
    let (data, _) = try await URLSession.shared.data(from: url)
    let response = try JSONDecoder().decode(PuuidResponse.self, from: data)
    return response
}

func masteryApiCall() async throws -> [MasteryResponse]{
    let url = URL(string: mockTopMasteryRequest(6))!
    print(url.absoluteString)
    let (data, _) = try await URLSession.shared.data(from: url)
    let response = try JSONDecoder().decode([MasteryResponse].self, from: data)
    return response
}
