//
//  ChampionScreen.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 29/09/2024.
//

import SwiftUI
struct ChampionScreen: View {
    
    var championData: MasteryResponse
    
    var requiredGrades: [String] {
        let gradecounts = championData.nextSeasonMilestone.requireGradeCounts
        var reqGrades: [String] = []
        for grade in gradecounts{
            print(grade)
            reqGrades += Array(repeating: grade.key, count: grade.value)
        }
        return reqGrades
    }
    
    var body: some View{
        ZStack{
            VStack{
                Text(namesFromChampId[championData.championId]!)
                ForEach(0..<requiredGrades.count){ index in
                    Text(requiredGrades[index])
                }
                
            }
        }
    }
}
