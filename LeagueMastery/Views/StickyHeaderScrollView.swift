//
//  StickyHeaderScrollView.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 26/02/2025.
//
import SwiftUI
import Kingfisher

struct StickyHeaderScrollView<Content:View>: View {
    @State private var yOffset = false
    @State private var headerHeight = CGFloat(50)
    @Binding var isScrolled: Bool
    
    var name: String
    var tag: String
    var iconId: Int
    var score: Int
    
    @ViewBuilder let content: Content
    
    var body: some View{
        if #available(iOS 18.0, *) {
            GeometryReader{ geo in
                ZStack(alignment: .top){
                    ScrollView{
                        LazyVStack(pinnedViews: [.sectionHeaders]){
                            Section{
                                content
                            } header: {
                                VStack(){
                                    
                                }
                                .font(.system(size: yOffset ? 16: 24))
                                .frame(
                                    width: geo.size.width,
                                    height: geo.size.height * 0.195,
                                    alignment: yOffset ? .leading: .center)
                                .padding(.horizontal)
                                .animation(.default, value: yOffset)
                            }
                        }
                    }
                    .onScrollGeometryChange(for: Bool.self) { geo in
                        geo.contentOffset.y > 24
                    } action: { oldValue, newValue in
                        yOffset = newValue
                        headerHeight = yOffset ? 100 : geo.size.height * 0.31
                    }
                    .onChange(of: yOffset) {
                        isScrolled = yOffset
                    }
                    
                    // workaround animations being affected by scrolling by
                    // overlaying the text on top of the scroll view rather
                    // than inside of it
                    if #available(iOS 26.0, *){
                        StickyHeader(
                            geo: geo,
                            name: name,
                            iconId: iconId,
                            score: score,
                            tag: tag,
                            yOffset: $yOffset,
                            headerHeight: $headerHeight
                        )
//                        .if(yOffset){ view in
//                            view.glassEffect(in: UnevenRoundedRectangle(cornerRadii: .init(topLeading: 20, bottomLeading: 1, bottomTrailing: 1, topTrailing: 20)))
//                        }
                    } else {
                        StickyHeader(
                            geo: geo,
                            name: name,
                            iconId: iconId,
                            score: score,
                            tag: tag,
                            yOffset: $yOffset,
                            headerHeight: $headerHeight
                        )
                        .if(yOffset){ view in
                            view.background(.thinMaterial)
                        }
                    }
                }
                .zIndex(yOffset ? 0 : -1)
                .animation(.snappy, value: headerHeight)
                .clipShape(
                    RoundedRectangle(
                        cornerRadius: ClipRadius()
                    )
                )
            }
        } else {
            // TODO: Fallback on earlier versions
        }
    }
}

struct StickyHeader: View {
    var geo: GeometryProxy
    
    var name: String
    var iconId: Int
    var score: Int
    var tag: String
    @Binding var yOffset: Bool
    @Binding var headerHeight: CGFloat
    
    var body: some View {
        HStack(alignment: .bottom){
            // placeholder summoner icon
            if !yOffset {
                KFImage(URL(string: profileIconUrl(profileIconId: iconId)))
                    .resizable()
                    .frame(width: 56, height: 56)
                    .background(.gray)
                    .clipShape(RoundedRectangle(cornerRadius: 12))
                
                VStack(alignment:.leading){
                    HStack{
                        Text(name)
                        Text("#\(tag)")
                    }
                    if !yOffset {Text("Score: \(score)")}
                }
            }
        }
        .padding(.horizontal)
        .frame(
            width: geo.size.width,
            height: headerHeight,
            alignment: .leading
        )
//        .border(.green)
    }
}

// Clip dependent on ios version
func ClipRadius() -> CGFloat {
    if #available(iOS 26.0, *) {
        return CGFloat(20)
    } else {
        return CGFloat(16)
    }
}
