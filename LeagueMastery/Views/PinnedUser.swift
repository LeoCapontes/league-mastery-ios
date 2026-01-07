//
//  PinnedUser.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 04/01/2026.
//
import SwiftUI
import Foundation
import Kingfisher

let cardMask = LinearGradient(
    stops: [
        Gradient.Stop(color: .black, location: 0.5),
        Gradient.Stop(color: Color.black.opacity(0.25), location: 1)
    ],
    startPoint: .trailing,
    endPoint: .leading)

let cardOverlay = LinearGradient(
    stops: [
        Gradient.Stop(color: .clear, location: 0.4),
        Gradient.Stop(color: .black.opacity(0.6), location: 0.8),
        Gradient.Stop(color: Color.black.opacity(0.7), location: 1)
    ],
    startPoint: .trailing,
    endPoint: .leading)


struct PinnedUser: View {
    var entries: [MasteryResponse]
    var user: User
    @State var mockIndex: Int = 0
    @State var selectedMetric: userMetric = .canLevel
    
    
    var body: some View {
        ZStack{
            VStack(spacing: 0){
                HStack{
                    KFImage(URL(string: profileIconUrl(profileIconId: 1)))
                        .resizable()
                        .frame(width: 36, height: 36)
                        .background(.gray)
                        .clipShape(RoundedRectangle(cornerRadius: 4))
                    
                    VStack(alignment:.leading){
                        HStack(alignment: .top){
                            Text(user.name)
                                .font(.system(size: 18, weight: .semibold))
                                .foregroundStyle(.white)
                            Text("#\(user.tagline)")
                                .font(.system(size: 10))
                                .foregroundStyle(.gray)
                        }
                        Text("Score: \(user.masteryScore)")
                            .font(.system(size: 14))
                            .foregroundStyle(.gray)
                    }
                    
                }
                .frame(minWidth: 0, maxWidth: .infinity, alignment: .leading)
                .padding(.horizontal)
                .padding(.vertical, 8)
    //            .border(.green)

                ZStack(){
                    BackgroundChampionImage(championId: entries[mockIndex].championId)
                        .id(mockIndex)
                        .transition(.opacity.animation(.easeOut))
                        .padding(-10)
                    //            .border(.green)
                        .overlay {
                            cardOverlay
                                .overlay{
                                    RoundedRectangle(cornerRadius: 12)
                                        .frame(width: 360, height: 48)
                                        .offset(x: 0, y: -56)
                                        .blendMode(.destinationOut)
                                }
                                .compositingGroup()
                        }
                    
                    HStack{
                        VStack(alignment: .leading, spacing: 18){
                            Label("Can Level", systemImage: "")
                                .onTapGesture {
                                    selectedMetric = .canLevel
                                }
                                .foregroundStyle(selectedMetric == .canLevel ? .white : .gray)
                            Divider()
                                .frame(width: 100)
                            Label("Top 3", systemImage: "")
                                .onTapGesture {
                                    selectedMetric = .topScore
                                }
                                .foregroundStyle(selectedMetric == .topScore ? .white : .gray)
                            Divider()
                                .frame(width: 100)
                            Label("Top Milestones", systemImage: "")
                                .onTapGesture {
                                    selectedMetric = .topMilestone
                                }
                                .foregroundStyle(selectedMetric == .topMilestone ? .white : .gray)
                        }
                        Spacer()
                        Text("")
                    }
                    .padding()
                }
                .clipShape(RoundedRectangle(cornerRadius: 16))
                .frame(minWidth: nil, maxWidth: nil, minHeight: 200, maxHeight: .infinity)
                //        .border(.green)
            }
            .background(.ultraThinMaterial.opacity(0.2))
            .clipShape(RoundedRectangle(cornerRadius: 16))
            .padding(.horizontal)
    //        .border(.red)
        }
        .task(delayText)
        
    }
    
    func delayText() async {
        while !Task.isCancelled {
            do {
                try await Task.sleep(nanoseconds: 3_500_000_000)
            } catch {
                break
            }

            mockIndex += 1
            print("incremented")
        }
    }
    
    enum userMetric {
        case canLevel
        case topScore
        case topMilestone
    }
}

struct BackgroundChampionImage: View {
    @State var bgColor: Color = .black
    
    var championId: Int
    var splashOffset: Offset {
        return splashOffsets[championId] ?? Offset()
    }
    
    var body: some View {
        HStack(spacing: 0){
            ChampionImage(
                championId: championId)
            .scaleEffect(x:-1, y: 1)
            ChampionImage(
                championId: championId)
        }
        .aspectRatio(contentMode: .fill)
        .offset(x: splashOffset.x, y: 0)
        .frame(width: 400, alignment: .trailing)
        .drawingGroup()
        //            .overlay(avgGradient(Color(
        //                red: bgColor.components()[0] * 0.25,
        //                green: bgColor.components()[1] * 0.25,
        //                blue: bgColor.components()[2] * 0.25
        //            )))
        .variableBlur(radius: 10) { geometryProxy, context in
            // add a blur to the mask to smooth out where the variable blur begins
            context.addFilter(.blur(radius: 0))
            
            context.fill(
                Path(CGRect(origin: .zero, size: geometryProxy.size)),
                with: .linearGradient(
                    .init(colors: [.clear, .white]),
                    startPoint: .init(x: geometryProxy.size.width - (geometryProxy.size.width*0.5), y: 0),
                    endPoint: .init(x: geometryProxy.size.width - (geometryProxy.size.width*0.75), y: 0)
                )
            )
        }
        .mask(cardMask)
    }
    
}

#Preview {
    let mock = mockMasteryResponse
    let user = User(
        puuid: "d",
        name: "Hide on Bush",
        tagline: "KR1",
        region: "Korea",
        server: "Asia",
        profileIconId: 1,
        summonerLevel: 999,
        masteryScore: 999
    )
    let mockIndex = 40
    @State var bgColor: Color = Color("BGColor")
    var splashOffset: Offset {
        return splashOffsets[mock[mockIndex].championId] ?? Offset()
    }
    ZStack{
        BackgroundImage()
        PinnedUser(entries: mock, user: user)
            .frame(height: 200)
    }
}
