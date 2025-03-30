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
 800: Offset(), //Mel
 238: Offset(25, 0), //Zed
 20: Offset(),
 240: Offset(),
 72: Offset(),
 136: Offset(0, -20), //ASol
 45: Offset(),
 98: Offset(),
 69: Offset(),
 157: Offset(),
 23: Offset(),
 516: Offset(),
 412: Offset(40, 0), //Thresh
 267: Offset(),
 876: Offset(),
 233: Offset(), 19: Offset(), 31: Offset(),
 134: Offset(), 38: Offset(), 7: Offset(), 96: Offset(), 420: Offset(), 41: Offset(),
 893: Offset(), 51: Offset(), 40: Offset(), 61: Offset(), 875: Offset(), 200: Offset(),
 26: Offset(), 154: Offset(), 107: Offset(), 57: Offset(), 897: Offset(), 76: Offset(), 245: Offset(),
 54: Offset(), 163: Offset(), 56: Offset(), 110: Offset(), 62: Offset(), 36: Offset(),
 29: Offset(), 39: Offset(), 67: Offset(), 133: Offset(), 114: Offset(), 91: Offset(), 33: Offset(),
 203: Offset(), 518: Offset(), 429: Offset(), 161: Offset(), 104: Offset(), 84: Offset(), 24: Offset(),
 80: Offset(), 43: Offset(), 105: Offset(), 103: Offset(40, 0), 55: Offset(), 22: Offset(), 48: Offset(),
 64: Offset(), 32: Offset(), 112: Offset(), 145: Offset(), 102: Offset(), 266: Offset(30, 0), 427: Offset(),
 147: Offset(), 115: Offset(), 111: Offset(), 59: Offset(), 58: Offset(), 89: Offset(),
 121: Offset(), 21: Offset(), 164: Offset(), 119: Offset(), 131: Offset(), 166: Offset(),
 75: Offset(), 360: Offset(), 350: Offset(), 777: Offset(), 126: Offset(), 44: Offset(), 60: Offset(),
 11: Offset(), 25: Offset(), 497: Offset(), 1: Offset(), 4: Offset(), 8: Offset(),
 141: Offset(), 555: Offset(), 27: Offset(), 15: Offset(70, 0), 37: Offset(), 888: Offset(), 421: Offset(),
 234: Offset(), 517: Offset(), 92: Offset(), 18: Offset(), 526: Offset(), 236: Offset(),
 9: Offset(), 113: Offset(), 35: Offset(), 901: Offset(), 150: Offset(0, -60), 74: Offset(),
 523: Offset(), 117: Offset(), 106: Offset(), 81: Offset(), 432: Offset(), 30: Offset(),
 17: Offset(), 235: Offset(), 16: Offset(), 895: Offset(), 2: Offset(), 99: Offset(), 12: Offset(),
 63: Offset(), 77: Offset(), 3: Offset(), 902: Offset(),
 799: Offset(), 246: Offset(), 42: Offset(),
 28: Offset(), 101: Offset(), 10: Offset(), 202: Offset(), 90: Offset(), 268: Offset(), 86: Offset(),
 950: Offset(), 143: Offset(), 53: Offset(), 50: Offset(), 120: Offset(), 85: Offset(5, -20),
 142: Offset(), 910: Offset(), 6: Offset(), 5: Offset(), 201: Offset(),
 79: Offset(60, 0), //Gragas
 498: Offset(),
 13: Offset(0, -25), 122: Offset(), 83: Offset(), 127: Offset(), 68: Offset(), 221: Offset(), 222: Offset(),
 34: Offset(), 223: Offset(), 254: Offset(), 711: Offset(), 78: Offset(), 82: Offset(), 887: Offset()]


#Preview {
    let mock = mockMasteryResponse
    let id = 8
    LargeChampionRow(entry: mock[id-1])
    LargeChampionRow(entry: mock[id])
    LargeChampionRow(entry: mock[id+1])

}
