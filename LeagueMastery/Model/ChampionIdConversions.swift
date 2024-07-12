//
//  ChampionSplashUrls.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 08/07/2024.
//

import Foundation


    
let namesFromChampId = [
    1 : "Aatrox",
    2 : "Ahri",
    3 : "Akali",
    4 : "Akshan",
    5 : "Alistar",
    6 : "Amumu",
    7 : "Anivia"
]

func splashFromChampId(_ champId: Int) -> String {
    return "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/\(namesFromChampId[champId] ?? "Aatrox")_0.jpg"
}

func portraitFromChampId(_ champId: Int) -> String {
    return "https://ddragon.leagueoflegends.com/cdn/14.13.1/img/champion/\(namesFromChampId[champId] ?? "Aatrox").png"
}

