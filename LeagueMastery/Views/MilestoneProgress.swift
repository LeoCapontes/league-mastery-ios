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
                    VStack{
                        Spacer()
                        RewardsContainer(
                            milestoneRewards:
                                rewardConfig[markerNumber] ?? [MilestoneReward(
                                    reward: .masteryMark, quantity: 1)],
                            completed: (markerNumber <= currentMilestone)
                        )
                    }
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

struct RewardsContainer: View {
    var milestoneRewards: [MilestoneReward]
    var completed: Bool
    
    var body: some View {
        HStack{
            ForEach(0..<milestoneRewards.count) { index in
                RewardView(rewards: milestoneRewards[index], completed: completed)
            }
        }
        .padding(4)
        .background(.ultraThinMaterial)
        .clipShape(RoundedRectangle(cornerRadius: 8))
    }
}

struct RewardView: View {
    var rewards: MilestoneReward
    var completed: Bool
    
    var body: some View {
        ZStack{
            RewardImage(reward: rewards.reward)
            if completed { Image("reward-completed").resizable().opacity(1)}
        }
        .frame(width: 25, height: 25)
    }
}

struct RewardImage: View {
    var reward: RewardType
    
    var body: some View {
        switch reward{
        case .masteryMark :
            Image("mastery-mark")
                .resizable()
        case .crestHighlight :
            Image("crest-reward-placeholder")
                .resizable()
        }
    }
    
}

#Preview {
    let mock = mockMasteryResponse
    ScrollView(.horizontal){
        HStack{
            MilestoneProgress(currentMilestone: 3).frame(width: 700, height: 100)
                .border(.green)
                .padding(.horizontal, 30)
        }
    }
    .frame(width: 400, height: 200)
    .border(.green)
        
}
