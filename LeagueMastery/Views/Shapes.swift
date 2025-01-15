//
//  Shapes.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 12/01/2025.
//

import CoreGraphics
import SwiftUI



struct Hexagon: Shape {
    func path(in rect: CGRect) -> Path {
        var path = Path()

        path.move(to: CGPoint(x: rect.minX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX*0.252, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX*0.75, y: rect.maxY))
        path.addLine(to: CGPoint(x: rect.maxX, y: rect.midY))
        path.addLine(to: CGPoint(x: rect.maxX*0.75, y: rect.minY))
        path.addLine(to: CGPoint(x: rect.maxX*0.25, y: rect.minY))

        return path
    }
}


#Preview {
    VStack{
        Hexagon().frame(width: 350, height:200)
    }
}

