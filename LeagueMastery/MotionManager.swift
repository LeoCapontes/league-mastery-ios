//
//  MotionManager.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 20/04/2025.
//
// from https://www.hackingwithswift.com/plus/swiftui-special-effects/controlling-views-using-the-accelerometer

import CoreMotion


class MotionManager: ObservableObject {
    private let motionManager = CMMotionManager()
    
    var fx: CGFloat = 0
    var fy: CGFloat = 0
    var fz: CGFloat = 0

    var dx: Double = 0
    var dy: Double = 0
    var dz: Double = 0
    
    init() {
        motionManager.startDeviceMotionUpdates(to: .main) { data, error in
            guard let newData = data?.gravity else { return }

            self.dx = newData.x
            self.dy = newData.y
            self.dz = newData.z

            self.fx = CGFloat(newData.x)
            self.fy = CGFloat(newData.y)
            self.fz = CGFloat(newData.z)

            self.objectWillChange.send()
        }
    }
    
    func shutdown() {
        motionManager.stopDeviceMotionUpdates()
    }
    
}
