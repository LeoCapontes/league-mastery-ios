//
//  ImageExtensions.swift
//  LeagueMastery
//
//  Created by Leo Capontes on 30/03/2025.
//
import UIKit
import SwiftUI
import CoreImage
import CoreImage.CIFilterBuiltins

extension UIImage {
    func averageColor() -> UIColor? {
        guard let inputImage = CIImage(image: self) else { return nil }
        let extentVector = CIVector(x: inputImage.extent.origin.x, y: inputImage.extent.origin.y, z: inputImage.extent.size.width, w: inputImage.extent.size.height)

        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [kCIInputImageKey: inputImage, kCIInputExtentKey: extentVector]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }

        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [.workingColorSpace: kCFNull])
        context.render(outputImage, toBitmap: &bitmap, rowBytes: 4, bounds: CGRect(x: 0, y: 0, width: 1, height: 1), format: .RGBA8, colorSpace: nil)

        return UIColor(red: CGFloat(bitmap[0]) / 255, green: CGFloat(bitmap[1]) / 255, blue: CGFloat(bitmap[2]) / 255, alpha: CGFloat(bitmap[3]) / 255)
    }
    
    func dominantColor() -> UIColor? {
            guard let inputImage = CIImage(image: self) else { return nil }
            
            let filter = CIFilter.areaAverage()
            filter.inputImage = inputImage
            filter.extent = inputImage.extent // Use CGRect directly
            
            let context = CIContext()
            guard let outputImage = filter.outputImage else { return nil }
            
            var bitmap = [UInt8](repeating: 0, count: 4) // RGBA format
            context.render(
                outputImage,
                toBitmap: &bitmap,
                rowBytes: 4,
                bounds: CGRect(x: 0, y: 0, width: 1, height: 1), // 1x1 pixel
                format: .RGBA8,
                colorSpace: CGColorSpaceCreateDeviceRGB()
            )
            
            return UIColor(
                red: CGFloat(bitmap[0]) / 255.0,
                green: CGFloat(bitmap[1]) / 255.0,
                blue: CGFloat(bitmap[2]) / 255.0,
                alpha: CGFloat(bitmap[3]) / 255.0
            )
        }
    
}

extension Color {
    // returns the components of the colour [red, green, blue, alpha]
    func components() -> [CGFloat] {
        return UIColor(self).cgColor.components ?? [0, 0, 0, 0]
    }
}
