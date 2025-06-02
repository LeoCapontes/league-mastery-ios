//
//  ChampionSplashUrls.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 08/07/2024.
//

import Foundation
import SwiftUI

var champions: Champions?

func splashFromChampId(_ champId: Int) -> String {
    return "https://ddragon.leagueoflegends.com/cdn/img/champion/splash/\(namesFromChampId[champId] ?? "Aatrox")_0.jpg"
}

func portraitFromChampId(_ champId: Int) -> String {
    return "https://ddragon.leagueoflegends.com/cdn/\(Settings.shared.lolVersion)/img/champion/\(namesFromChampId[champId] ?? "Aatrox").png"
}

func loadingScreenFromChampId(_ champId: Int) -> String {
    return "https://ddragon.leagueoflegends.com/cdn/img/champion/loading/\(namesFromChampId[champId] ?? "Aatrox")_0.jpg"
}

func populateChampions() {
    Task{
        do{
            champions = try await championsApiCall()
            print(champions)
            if let champions = champions {
                for (entry, info) in champions.data{
                    let key = Int(info.key) ?? 1
                    let name = info.id
                    namesFromChampId[key] = name
                }
            }
            print(namesFromChampId)
        }catch{
            print("Error populating champions \(error)")
        }
    }
}


// fall back as of league version 25.06, gets updated by populateChampions()
// having a pre-defined dictionary allows for previewing without api calls
var namesFromChampId: [Int:String] =
[14: "Sion", 800: "Mel", 238: "Zed", 20: "Nunu", 240: "Kled", 72: "Skarner", 136: "AurelionSol",
 45: "Veigar", 98: "Shen", 69: "Cassiopeia", 157: "Yasuo", 23: "Tryndamere", 516: "Ornn",
 412: "Thresh", 267: "Nami", 876: "Lillia", 233: "Briar", 19: "Warwick", 31: "Chogath",
 134: "Syndra", 38: "Kassadin", 7: "Leblanc", 96: "KogMaw", 420: "Illaoi", 41: "Gangplank",
 893: "Aurora", 51: "Caitlyn", 40: "Janna", 61: "Orianna", 875: "Sett", 200: "Belveth",
 26: "Zilean", 154: "Zac", 107: "Rengar", 57: "Maokai", 897: "KSante", 76: "Nidalee", 245: "Ekko",
 54: "Malphite", 163: "Taliyah", 56: "Nocturne", 110: "Varus", 62: "MonkeyKing", 36: "DrMundo",
 29: "Twitch", 39: "Irelia", 67: "Vayne", 133: "Quinn", 114: "Fiora", 91: "Talon", 33: "Rammus",
 203: "Kindred", 518: "Neeko", 429: "Kalista", 161: "Velkoz", 104: "Graves", 84: "Akali", 24: "Jax",
 80: "Pantheon", 43: "Karma", 105: "Fizz", 103: "Ahri", 55: "Katarina", 22: "Ashe", 48: "Trundle",
 64: "LeeSin", 32: "Amumu", 112: "Viktor", 145: "Kaisa", 102: "Shyvana", 266: "Aatrox", 427: "Ivern",
 147: "Seraphine", 115: "Ziggs", 111: "Nautilus", 59: "JarvanIV", 58: "Renekton", 89: "Leona",
 121: "Khazix", 21: "MissFortune", 164: "Camille", 119: "Draven", 131: "Diana", 166: "Akshan",
 75: "Nasus", 360: "Samira", 350: "Yuumi", 777: "Yone", 126: "Jayce", 44: "Taric", 60: "Elise",
 11: "MasterYi", 25: "Morgana", 497: "Rakan", 1: "Annie", 4: "TwistedFate", 8: "Vladimir",
 141: "Kayn", 555: "Pyke", 27: "Singed", 15: "Sivir", 37: "Sona", 888: "Renata", 421: "RekSai",
 234: "Viego", 517: "Sylas", 92: "Riven", 18: "Tristana", 526: "Rell", 236: "Lucian",
 9: "Fiddlesticks", 113: "Sejuani", 35: "Shaco", 901: "Smolder", 150: "Gnar", 74: "Heimerdinger",
 523: "Aphelios", 117: "Lulu", 106: "Volibear", 81: "Ezreal", 432: "Bard", 30: "Karthus",
 17: "Teemo", 235: "Senna", 16: "Soraka", 895: "Nilah", 2: "Olaf", 99: "Lux", 12: "Alistar",
 63: "Brand", 77: "Udyr", 3: "Galio", 902: "Milio", 799: "Ambessa", 246: "Qiyana", 42: "Corki",
 28: "Evelynn", 101: "Xerath", 10: "Kayle", 202: "Jhin", 90: "Malzahar", 268: "Azir", 86: "Garen",
 950: "Naafiri", 143: "Zyra", 53: "Blitzcrank", 50: "Swain", 120: "Hecarim", 85: "Kennen",
 142: "Zoe", 910: "Hwei", 6: "Urgot", 5: "XinZhao", 201: "Braum", 79: "Gragas", 498: "Xayah",
 13: "Ryze", 122: "Darius", 83: "Yorick", 127: "Lissandra", 68: "Rumble", 221: "Zeri", 222: "Jinx",
 34: "Anivia", 223: "TahmKench", 254: "Vi", 711: "Vex", 78: "Poppy", 82: "Mordekaiser", 887: "Gwen"]

var displayableChampionNames: [String:String] =
["AurelionSol" : "Aurelion Sol",
 "MonkeyKing" : "Wukong",
 "KogMaw" : "Kog'Maw"]

// handles getting user-facing champion names i.e. MonkeyKing to Wukong
func getNameFromId(id: Int) -> String {
    var rawName = namesFromChampId[id]!
    if let displayName = displayableChampionNames[rawName] {
        return displayName
    }
    return rawName
}

struct Offset {
    var x: CGFloat = 0
    var y: CGFloat = 0
    
    init(_ x: CGFloat, _ y: CGFloat) {
        self.x = x
        self.y = y
    }
    
    init(){
        self.x = 0
        self.y = 0
    }
}

// manually set champion splash art offsets here.
var splashOffsets: [Int:Offset] =
[14: Offset(15, 0), //Sion
 800: Offset(100, 0), //Mel
 238: Offset(25, -10), //Zed
 20: Offset(30, -40), // Nunu
 240: Offset(),
 72: Offset(80, -120), // Skarner
 136: Offset(70, 0), //ASol
 45: Offset(45, -20), //Veiger
 98: Offset(),
 69: Offset(30, -40), // Cassiopeia
 157: Offset(0, -45),
 23: Offset(0, -15), // tryndamere
 516: Offset(100, -30), // Ornn
 412: Offset(40, -15), //Thresh
 267: Offset(0, -20), //Nami
 876: Offset(100, -10), // Lillia
 233: Offset(50, -30), // Briar
 19: Offset(20, -80), // Warwick
 31: Offset(50, -35), //Chogath
 134: Offset(90, 0), // Syndra
 38: Offset(20, 0), // kassadin
 7: Offset(60, -5), //leblanc
 96: Offset(10, -80), // Kog
 420: Offset(40, 0), // Illaoi
 41: Offset(0, -15), // Gangplank
 893: Offset(70, 0), //Aurora
 51: Offset(),
 40: Offset(0, -30), // Janna
 61: Offset(),
 875: Offset(100, 0), // Sett
 200: Offset(100, 0), // Belveth
 26: Offset(50, -20), // Zilean
 154: Offset(30, -90), // Zac
 107: Offset(20, -50), // Rengar
 57: Offset(30, -40), // Maokai
 897: Offset(130, -10), // Ksante
 76: Offset(10, -10), // Nidalee
 245: Offset(0 ,-15), // Ekko
 54: Offset(15, -95), // Malphite
 163: Offset(),
 56: Offset(20, -60), // nocturne
 110: Offset(90, 0), // Varus
 62: Offset(30, -20), // monkeyking
 36: Offset(80, 0), // Mundo
 29: Offset(60, -35), // Twitch
 39: Offset(80, 0), // Irelia
 67: Offset(),
 133: Offset(30, -30), // Quinn
 114: Offset(35, 0), //Fiora
 91: Offset(20, -30), // Talon
 33: Offset(10, -70), // rammus
 203: Offset(60, -40), // Kindred
 518: Offset(50, -20), // Neeko
 429: Offset(20, -10), // Kalista
 161: Offset(50, -50), // velkoz
 104: Offset(),
 84: Offset(90, 0), // Akali
 24: Offset(40, -20),
 80: Offset(90, -10), // Pantheon
 43: Offset(0, -10), // Karma
 105: Offset(0, -15), // Fizz
 103: Offset(40, -10), // Ahri
 55: Offset(30, -50), // katarina
 22: Offset(25, -15), //Ashe
 48: Offset(40, -20),
 64: Offset(50, -10), // Leesin
 32: Offset(20, -20),
 112: Offset(50, -20), // Viktor
 145: Offset(95, 0), // Kaisa
 102: Offset(20, 0), // Shyvana
 266: Offset(30, -15), // Aatrox
 427: Offset(50, -5), // Ivern
 147: Offset(110, -10), // Seraphine
 115: Offset(0, -50), // Ziggs
 111: Offset(),
 59: Offset(0, -10), // jarvaniv
 58: Offset(50, -10), // Renekton
 89: Offset(),
 121: Offset(10, -90), // Khazix
 21: Offset(0, -40), // Missfortune
 164: Offset(),
 119: Offset(0, -40), // draven
 131: Offset(20, -40), // Diana
 166: Offset(30, -70), // akshan
 75: Offset(35, -10),// Nasus
 360: Offset(50, -5), // samira
 350: Offset(100, -10), // Yuumi
 777: Offset(60, 0), // Yone
 126: Offset(0, -40), // Jayce
 44: Offset(),
 60: Offset(0, -15), // Elise
 11: Offset(0, -30), // masteryi
 25: Offset(0, -35), // Morgana
 497: Offset(90, 0), // Rakan
 1: Offset(0, -35), // Annie
 4: Offset(0, -10), // Twistedfate
 8: Offset(0, -15), // Vladimir
 141: Offset(50, -80),
 555: Offset(70, -40), // Pyke
 27: Offset(30, -10), // Singed
 15: Offset(70, 0),
 37: Offset(20, -10), // Sona
 888: Offset(50, 0), // Renata
 421: Offset(50, -60), // reksai
 234: Offset(),
 517: Offset(90, -30), // Sylas
 92: Offset(0, -10), // Riven
 18: Offset(30, -15), // Tristana
 526: Offset(50, -5), // rell
 236: Offset(10, -60), // Lucian
 9: Offset(60, -40),
 113: Offset(70, 0), // Sejuani
 35: Offset(10, -10), // shaco
 901: Offset(95, -20), // Smolder
 150: Offset(0, -60),
 74: Offset(0, -50), // Heimerdinger
 523: Offset(70, 0), // Aphelios
 117: Offset(10, -50), // lulu
 106: Offset(55, 0), // Volibear
 81: Offset(40, -25), // Ezreal
 432: Offset(50, -10), // bard
 30: Offset(20, 0), // Karthus
 17: Offset(75, -10), // Teemo
 235: Offset(80, -20), // Senna
 16: Offset(50, 0), // Soraka
 895: Offset(20, -30), // Nilah
 2: Offset(40, -30), // olaf
 99: Offset(45, -15), // Lux
 12: Offset(50, -50), // Alistar
 63: Offset(0, -30), // brand
 77: Offset(80, 0), // Udyr
 3: Offset(90, 0), // Galio
 902: Offset(),
 799: Offset(100, 0), // Ambessa
 246: Offset(50, -10), // qiyana
 42: Offset(30, -25), // Corki
 28: Offset(90, 0), // Evelynn
 101: Offset(50, 0), // Xerath
 10: Offset(5, -20), // Kayle
 202: Offset(60, 0), // Jhin
 90: Offset(40, 0), // Malzahar
 268: Offset(),
 86: Offset(0, -30), // Garen
 950: Offset(120, -80), // naafiri
 143: Offset(0, -30), // zyra
 53: Offset(20, -25), // Blitz
 50: Offset(20, 0),
 120: Offset(50, 0), // Hecarim
 85: Offset(5, -20),
 142: Offset(50, -10),
 910: Offset(70, 0), // Hwei
 6: Offset(60, 0), // urgot
 5: Offset(50, -10), // xinzhao
 201: Offset(0, -20), // Braum
 79: Offset(60, -10), //Gragas
 498: Offset(50, -30), // Xayah
 13: Offset(0, -35), // ryze
 122: Offset(60, 0), // Darius
 83: Offset(30, 0),
 127: Offset(25, -15), // Lissandra
 68: Offset(10, -20), // Rumvle
 221: Offset(70, -20), // Zeri
 222: Offset(30, -15), // Jinx
 34: Offset(60, -30), // Anivia
 223: Offset(10, -40), // Tahm
 254: Offset(20, -30), // vi
 711: Offset(40, -30), // Vex
 78: Offset(45, -10), // Poppy
 82: Offset(120, 0), // Mordekaiser
 887: Offset(80, -5) // Gwen
]


#Preview {
    let mock = mockMasteryResponse
    let id = 15
    LargeChampionRow(entry: mock[id-1])
    LargeChampionRow(entry: mock[id])
    LargeChampionRow(entry: mock[id+1])

}
