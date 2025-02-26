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
                            VStack(){
                                HStack{
                                    Text(name)
                                    Text("#\(tag)")
                                }
                                if !yOffset {Text("Score: Placeholder")}
                            }
                            .font(.system(size: yOffset ? 16: 24))
                            .frame(
                                width: geo.size.width,
                                height: headerHeight,
                                alignment: yOffset ? .leading: .center)
                            .padding(.horizontal)
                            .background(.ultraThinMaterial.opacity(yOffset ? 1.0: 0.0))
                            .animation(.default, value: headerHeight)
                        }
                    }
                }
                .onScrollGeometryChange(for: Bool.self) { geo in
                    geo.contentOffset.y > headerHeight-10
                } action: { oldValue, newValue in
                    yOffset = newValue
                    headerHeight = yOffset ? 36 : 56
                }
                .clipShape(RoundedRectangle(cornerRadius: 12))
            }
        } else {
            // TODO: Fallback on earlier versions
        }
    }
}
