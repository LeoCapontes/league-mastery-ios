//
//  MilestoneProgress.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 11/01/2025.
//

import Foundation
import SwiftUI

// Milestone grades aren't available from the API, only the grade required for the next milestone
// the following is gotten manually from the LoL client
// as of 11-01-2025, each milestone only requires one grade
// TODO: automate this somehow, move it server-side
let gradesOneToFour: [String] = ["A-", "A-", "S-", "S-"]

struct MilestoneProgress: View {
    // four markers for first four milestones, and one for the final
    // repeating milestone
    let progressMarkers: Int = 5
    var currentMilestone: Int
    
    var barPercentage: CGFloat {
        if (currentMilestone > 4) {
            return 4
        }
        return (CGFloat(currentMilestone)/CGFloat(progressMarkers))
    }
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack(alignment: .top){
                Capsule()
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height)
                    .foregroundStyle(.gray)
                Capsule()
                    .frame(
                        width: geometry.size.width * 0.6,
                        height: geometry.size.height * barPercentage
                    )
                    .padding(2)
                    .foregroundStyle(.blue)
                ForEach(1..<progressMarkers+1) { marker in
                    Circle().position(
                        x: geometry.size.width * 0.5,
                        y: geometry.size.height * (CGFloat(marker)/CGFloat(progressMarkers)))
                }
            }
            
        }
    }
}

#Preview {
    let mock = mockMasteryResponse
    ScrollView{
        MilestoneProgress(currentMilestone: 3).frame(width: 10, height: 400)
    }
    .frame(width: 300, height: 200)
    .border(.green)
        
}
