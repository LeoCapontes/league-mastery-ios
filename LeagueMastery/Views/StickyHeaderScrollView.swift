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
    
    var name: String
    var tag: String
    var iconId: Int
    
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
                                    height: 64,
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
                        headerHeight = yOffset ? 42 : 64
                    }
                    
                    // workaround animations being affected by scrolling by
                    // overlaying the text on top of the scroll view rather
                    // than inside of it
                    HStack(){
                        // placeholder summoner icon
                        if !yOffset {
                            KFImage(URL(string: profileIconUrl(profileIconId: iconId)))
                                .resizable()
                                .frame(width: 56, height: 56)
                                .background(.gray)
                                .clipShape(RoundedRectangle(cornerRadius: 12))
                        }
                        VStack(alignment:.leading){
                            HStack{
                                Text(name)
                                Text("#\(tag)")
                            }
                            if !yOffset {Text("Score: Placeholder")}
                        }
                    }
                    .padding(.horizontal)
                    .frame(
                        width: geo.size.width,
                        height: headerHeight,
                        alignment: .leading
                    )
                    .background(.ultraThinMaterial.opacity(yOffset ? 1.0: 0.0))
                    .zIndex(yOffset ? 0 : -1)
                    .animation(.default, value: headerHeight)
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        } else {
            // TODO: Fallback on earlier versions
        }
    }
}
