//
//  Utils.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 06/11/2024.
//

import OSLog
import Foundation

// Logger extension idea from https://www.avanderlee.com/debugging/oslog-unified-logging/
extension Logger {
    private static var subsystem = Bundle.main.bundleIdentifier!

    static let viewModel = Logger(subsystem: subsystem, category: "viewmodel")
    static let apiCalls = Logger(subsystem: subsystem, category: "apicalls")
    static let data = Logger(subsystem: subsystem, category: "data")
    static let settings = Logger(subsystem: subsystem, category: "settings")
    static let views = Logger(subsystem: subsystem, category: "views")
}

func GradeRank(_ grade: String) -> Int {
    let gradeRanks: [String: Int] = [
        "S+": 0, "S": 1, "S-": 2,
        "A+": 3, "A": 4, "A-": 5,
        "B+": 6, "B": 7, "B-": 8,
        "C+": 9, "C": 10, "C-": 11,
        "D+": 12, "D": 13, "D-": 14,
        "F": 15
    ]
    
    return gradeRanks[grade] ?? Int.max
}

// Used to generate important metrics of a response one time and store it for use
// in sorting etc.
struct MasteryResponseMetrics: Hashable{
    let championId: Int
    let pointsInLevel: Int
    let requiredGrades: [String]
    let achievedGrades: [String]
    let gradesToMilestone: Int
    let gradesToChest: Int
}

func GetResponseMetrics(_ response: MasteryResponse) -> MasteryResponseMetrics{
    let pointsInLevel: Int = {
        return response.championPointsSinceLastLevel + response.championPointsUntilNextLevel
    }()
    
    let requiredGrades: [String] = {
        let gradecounts = response.nextSeasonMilestone.requireGradeCounts
        var reqGrades: [String] = []
        for grade in gradecounts{
            reqGrades += Array(repeating: grade.key, count: grade.value)
        }
        return reqGrades.sorted(by: { GradeRank($0) < GradeRank($1) })
    }()
    
    let achievedGrades: [String] = {
        // actual achieved grades will always less or equal to number of
        // required grades if below the final milestone level. Fill with
        // impossibly low grades to ensure equal array sizes.
        let tempGrades = Array(repeating: "F", count: requiredGrades.count)
        
        if var grades = response.milestoneGrades {
            let sortedAchievedGrades = grades.sorted(by: {
                GradeRank($0) < GradeRank($1)
            })
            
            // Cover final milestone case where all grades are recorded, and
            // therefore can exceed the number of required grades
            if (grades.count > requiredGrades.count) {
                return Array(sortedAchievedGrades[..<requiredGrades.count])
            }
            
            grades += Array(
                repeating: "F", count: (tempGrades.count - grades.count))
            return grades
        } else {
            return tempGrades
        }
    }()
    
    let gradesToMilestone: Int = {
        return requiredGrades.count - achievedGrades.count
    }()
    
    // This assumes a chest is rewarded at milestone 2 and 4, which is true
    // as of November 2024
    // edit as of Jan 2025 this is no longer true, keeping in case it's
    // reimplemented
    let gradesToChest: Int = {
        // Chests no longer earnable
        if (response.championSeasonMilestone>4) { return 999 }
        
        let targetMilestone = (response.championSeasonMilestone < 2) ? 2 : 4
        let gradesPerMilestone = requiredGrades.count
        let gradeCount = (gradesPerMilestone*response.championSeasonMilestone) + achievedGrades.count
        let requiredGradeCount = gradesPerMilestone*targetMilestone
        return requiredGradeCount-gradeCount
    }()
    
    return MasteryResponseMetrics(
        championId: response.championId,
        pointsInLevel: pointsInLevel,
        requiredGrades: requiredGrades,
        achievedGrades: achievedGrades,
        gradesToMilestone: gradesToMilestone,
        gradesToChest: gradesToChest
    )
}

enum Route: Hashable {
    case account
    case champion(MasteryResponse)
}
