//
//  ChampionSplashUrls.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 08/07/2024.
//

import Foundation

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


// fall back as of league version 14.3, gets updated by populateChampions()
// having a pre-defined dictionary allows for previewing without api calls
var namesFromChampId: [Int:String] = [
    19: "Warwick", 121: "Khazix", 82: "Mordekaiser", 5: "XinZhao", 141: "Kayn",
    85: "Kennen", 421: "RekSai", 112: "Viktor", 110: "Varus", 10: "Kayle",
    98: "Shen", 131: "Diana", 84: "Akali", 23: "Tryndamere", 60: "Elise",
    105: "Fizz", 235: "Senna", 234: "Viego", 26: "Zilean", 517: "Sylas",
    34: "Anivia", 516: "Ornn", 777: "Yone", 24: "Jax", 67: "Vayne", 78: "Poppy",
    56: "Nocturne", 96: "KogMaw", 427: "Ivern", 77: "Udyr", 133: "Quinn",
    6: "Urgot", 950: "Naafiri", 3: "Galio", 7: "Leblanc", 498: "Xayah",
    126: "Jayce", 81: "Ezreal", 69: "Cassiopeia", 28: "Evelynn", 236: "Lucian",
    114: "Fiora", 201: "Braum", 360: "Samira", 4: "TwistedFate", 79: "Gragas",
    48: "Trundle", 15: "Sivir", 101: "Xerath", 75: "Nasus", 412: "Thresh",
    350: "Yuumi", 63: "Brand", 32: "Amumu", 875: "Sett", 2: "Olaf",
    246: "Qiyana", 202: "Jhin", 161: "Velkoz", 106: "Volibear", 267: "Nami",
    166: "Akshan", 1: "Annie", 429: "Kalista", 90: "Malzahar", 11: "MasterYi",
    266: "Aatrox", 432: "Bard", 36: "DrMundo", 163: "Taliyah", 8: "Vladimir",
    145: "Kaisa", 876: "Lillia", 555: "Pyke", 51: "Caitlyn", 164: "Camille",
    17: "Teemo", 92: "Riven", 103: "Ahri", 136: "AurelionSol", 91: "Talon",
    222: "Jinx", 254: "Vi", 44: "Taric", 223: "TahmKench", 72: "Skarner",
    526: "Rell", 62: "MonkeyKing", 901: "Smolder", 42: "Corki", 33: "Rammus",
    58: "Renekton", 143: "Zyra", 54: "Malphite", 18: "Tristana", 
    53: "Blitzcrank", 888: "Renata", 157: "Yasuo", 40: "Janna", 119: "Draven",
    13: "Ryze", 37: "Sona", 233: "Briar", 518: "Neeko", 240: "Kled",
    29: "Twitch", 27: "Singed", 147: "Seraphine", 68: "Rumble", 55: "Katarina",
    117: "Lulu", 50: "Swain", 74: "Heimerdinger", 154: "Zac", 142: "Zoe",
    20: "Nunu", 895: "Nilah", 104: "Graves", 150: "Gnar", 39: "Irelia",
    45: "Veigar", 115: "Ziggs", 30: "Karthus", 523: "Aphelios", 31: "Chogath",
    61: "Orianna", 245: "Ekko", 711: "Vex", 22: "Ashe", 59: "JarvanIV",
    120: "Hecarim", 203: "Kindred", 12: "Alistar", 102: "Shyvana", 268: "Azir",
    221: "Zeri", 887: "Gwen", 107: "Rengar", 238: "Zed", 910: "Hwei", 
    897: "KSante", 35: "Shaco", 16: "Soraka", 14: "Sion", 80: "Pantheon",
    200: "Belveth", 99: "Lux", 122: "Darius", 86: "Garen", 83: "Yorick",
    76: "Nidalee", 111: "Nautilus", 902: "Milio", 420: "Illaoi", 57: "Maokai",
    89: "Leona", 21: "MissFortune", 113: "Sejuani", 9: "Fiddlesticks",
    25: "Morgana", 43: "Karma", 134: "Syndra", 38: "Kassadin", 64: "LeeSin",
    41: "Gangplank", 127: "Lissandra", 497: "Rakan"]
