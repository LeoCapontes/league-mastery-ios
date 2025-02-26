//
//  StickyHeaderScrollView.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 26/02/2025.
//
import SwiftUI

struct StickyHeaderScrollView<Content:View>: View {
    @State private var yOffset = false
    @State private var headerHeight = CGFloat(50)
    
    var name: String
    var tag: String
    
    @ViewBuilder let content: Content
    
    var body: some View{
        if #available(iOS 18.0, *) {
            GeometryReader{ geo in
                ScrollView{
                    LazyVStack(pinnedViews: [.sectionHeaders]){
                        Section{
                            content
                        } header: {
                            HStack{
                                Text(name)
                                Text("#\(tag)")
                            }
                            .font(.system(size: yOffset ? 16: 24))
                            .frame(width: geo.size.width, height: headerHeight)
                            .background(.thinMaterial)
                            .animation(.smooth, value: yOffset)
                        }
                    }
                }
                .onScrollGeometryChange(for: Bool.self) { geo in
                    geo.contentOffset.y > headerHeight-10
                } action: { oldValue, newValue in
                    yOffset = newValue
                    headerHeight = yOffset ? 36 : 48
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        } else {
            // TODO: Fallback on earlier versions
        }
    }
}
