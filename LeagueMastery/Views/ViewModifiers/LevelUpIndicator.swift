//
//  LevelUpIndicator.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 18/06/2025.
//
import SwiftUI
import CoreMotion

struct LevelUpIndicator: ViewModifier {
    @AppStorage("LevelUpIndicator")
    var levelUpIndicatorPreference: String = LevelUpIndicatorMode.pip.rawValue
    
    var offset: CGFloat
    
    func body(content: Content) -> some View {
        switch(levelUpIndicatorPreference) {
        case LevelUpIndicatorMode.holographic.rawValue:
            return AnyView(content.modifier(Holographic(offset: offset)))
        case LevelUpIndicatorMode.pip.rawValue:
            return AnyView(content.modifier(Pip()))
        default:
            return AnyView(content.modifier(Pip()))
        }
    }
}

struct Pip: ViewModifier {
    func body(content: Content) -> some View {
        content
            .overlay(alignment: .topTrailing){
                Image(systemName: "chevron.up.2")
                    .padding(.horizontal, 6)
                    .padding(.top, 4)
                    .padding(.bottom, 6)
                    .background() {
                        Circle()
                            .stroke(.white)
                            .fill(.orange)
                            
                    }
                    .font(.system(size: 16, weight: .bold))
                    .foregroundStyle(.white)
                    .padding(6)
            }
    }
}

struct Holographic: ViewModifier {
    @EnvironmentObject var motion: MotionManager
    @State var animAmount: CGFloat = 0.01
    
    var offset: CGFloat
    
    var realOffset: CGFloat {
        return offset.truncatingRemainder(dividingBy: 25)
    }
    
    func body(content: Content) -> some View {
        if #available(iOS 26, *){
            content
                .overlay {
                    Group{
                        ForEach(0..<3){ count in
                            Sheen(fx: motion.fx, fy: motion.fy, count: count)
                            Sheen2(fx: motion.fx, fy: motion.fy, count: count)
                        }
                    }
                    .allowsHitTesting(false)
                    .offset(x: -realOffset*10, y: motion.fy*10)
                }
                .glassEffect(in: .rect(cornerRadius: 18))
                .environment(\.colorScheme, .dark)
                .clipShape(RoundedRectangle(cornerRadius: 18))
                .blendMode(.normal)
        } else {
            content
                .overlay {
                    Group{
                        ForEach(0..<3){ count in
                            Sheen(fx: motion.fx, fy: motion.fy, count: count)
                            Sheen2(fx: motion.fx, fy: motion.fy, count: count)
                        }
                    }
                    .allowsHitTesting(false)
                    .offset(x: -realOffset*10, y: motion.fy*10)
                }
                .overlay(
                    RoundedRectangle(cornerRadius: 18)
                        .stroke(.white.opacity(0.2), lineWidth: 3)
                        .allowsHitTesting(false)
                )
                .clipShape(RoundedRectangle(cornerRadius: 18))
                .blendMode(.normal)
            }
        }
    }



struct Sheen: View {
    var fx: CGFloat
    var fy: CGFloat
    var count: Int
    
    var body: some View{
        GeometryReader { geo in
            Rectangle()
                .foregroundStyle(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: .clear, location: 0),
                            Gradient.Stop(color: .clear, location: 0.3+(fx*0.05)),
                            Gradient.Stop(color: .white.opacity(0.4+(fx*0.35)), location: 0.5),
                            Gradient.Stop(color: .clear, location: 0.7+(fx*(-0.05))),
                            Gradient.Stop(color: .clear, location: 1)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: 100, height: geo.size.height*1.5)
                .rotationEffect(Angle(degrees: 20))
                .offset(x: (fx*60)+(200*CGFloat(count)), y: -(geo.size.height*0.25))
        }
    }
}

struct Sheen2: View {
    var fx: CGFloat
    var fy: CGFloat
    var count: Int
    
    var body: some View{
        GeometryReader { geo in
            Rectangle()
                .foregroundStyle(
                    LinearGradient(
                        stops: [
                            Gradient.Stop(color: .clear, location: 0),
                            Gradient.Stop(color: .clear, location: 0.2+(fx*0.2)),
                            Gradient.Stop(color: .white.opacity(0.3+(fx*0.5)), location: 0.5),
                            Gradient.Stop(color: .clear, location: 0.8+(fx*(-0.2))),
                            Gradient.Stop(color: .clear, location: 1)],
                        startPoint: .leading,
                        endPoint: .trailing
                    )
                )
                .frame(width: 100, height: geo.size.height*1.5)
                .rotationEffect(Angle(degrees: 20))
                .offset(x: (fx*120)-40+(200*CGFloat(count)), y: -(geo.size.height*0.25))
        }
    }
}


#Preview{
    let motionManager = MotionManager()
    let mock = mockMasteryResponse
    ScrollView{
        VStack {
            LargeChampionRow(entry: mock[0])
                .modifier(Pip())
            ForEach(0..<10) { count in
                LargeChampionRow(entry: mock[0])
                    .modifier(Holographic(offset: CGFloat(count)))
            }
        }
    }
    .environmentObject(motionManager)
}
