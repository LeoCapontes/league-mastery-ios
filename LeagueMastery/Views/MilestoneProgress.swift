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
            return (CGFloat(4)/CGFloat(progressMarkers))
        }
        return (CGFloat(currentMilestone)/CGFloat(progressMarkers))
    }
    
    let markerHeight: CGFloat = 20
    let markerWidth: CGFloat = 45
    
    var body: some View {
        GeometryReader{ geometry in
            ZStack(){
                ForEach(1..<progressMarkers+1) { markerNumber in
                    Hexagon().foregroundStyle(.gray)
                        .frame(width: markerWidth, height: markerHeight)
                        .position(
                            x: geometry.size.width * (CGFloat(markerNumber) / CGFloat(progressMarkers)),
                            y: geometry.size.height/2
                        )
                }
                
                MilestoneBar(
                    progressMarkers: progressMarkers,
                    currentMilestone: currentMilestone)
                .frame(width: geometry.size.width, height: 10)
                .position(x: geometry.size.width/2, y: geometry.size.height/2)
                
                ForEach(1..<progressMarkers+1) { markerNumber in
                    ProgressMarker(
                        milestone: markerNumber,
                        achieved: (markerNumber<=currentMilestone)
                    )
                    .frame(width: markerWidth, height: markerHeight)
                    .position(
                        x: geometry.size.width * (CGFloat(markerNumber) / CGFloat(progressMarkers)),
                        y: geometry.size.height/2
                    )
                }
            }
        }
    }
}

struct MilestoneBar: View {
    var progressMarkers: Int
    var currentMilestone: Int
    
    var barPercentage: CGFloat {
        if (currentMilestone > 4) {
            return 4
        }
        return (CGFloat(currentMilestone)/CGFloat(progressMarkers))
    }

    var body: some View {
        GeometryReader{ geometry in
            ZStack(alignment:.leading){
                Capsule()
                    .frame(
                        width: geometry.size.width,
                        height: geometry.size.height)
                                        .foregroundStyle(.gray)
                Capsule()
                    .frame(
                        width: geometry.size.width * barPercentage
                    )
                    .padding(3)
                    .foregroundStyle(.blue)
            }
        }
    }
}

struct ProgressMarker: View {
    var milestone: Int
    var achieved: Bool
    
    var body: some View {
        ZStack{
            if achieved { Hexagon().foregroundStyle(.blue).padding(2) }
            Text(String(milestone)).foregroundStyle(.white)
        }
    }
}

#Preview {
    let mock = mockMasteryResponse
    ScrollView(.horizontal){
        HStack{
            MilestoneProgress(currentMilestone: 3).frame(width: 500, height: 50)
                .border(.green)
                .padding(.horizontal, 30)
        }
    }
    .frame(width: 400, height: 200)
    .border(.green)
        
}
