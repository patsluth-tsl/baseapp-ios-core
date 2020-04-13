//
//  UIImage+BA.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-12-02.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import CoreGraphics
import Foundation
import UIKit

public extension UIImage {
    /**
     Create a new image by applying tintColor directly to an existing image
     
     - Precondition: `renderingMode` must be .alwaysTemplate.
     */
    func imageByApplying(tintColor color: UIColor) -> UIImage? {
        let rect = CGRect(origin: .zero, size: size)
        UIGraphicsBeginImageContextWithOptions(rect.size, false, scale)
        guard let context = UIGraphicsGetCurrentContext() else { return nil }
        defer { UIGraphicsEndImageContext() }
        //        color.setFill()
        draw(in: rect)
        context.setBlendMode(.sourceIn)
        context.setFillColor(color.cgColor)
        context.fill(rect)
        return UIGraphicsGetImageFromCurrentImageContext()
    }
    
    /// Creates a new image by removing all transparent pixels from an existing image edges
    func imageByCroppingTransparentPixels() -> UIImage? {
        guard let cgImage = self.cgImage else { return nil }
        
        let width = cgImage.width
        let height = cgImage.height
        
        let colorSpace = CGColorSpaceCreateDeviceRGB()
        let bytesPerPixel = 4
        let bytesPerRow = bytesPerPixel * width
        let bitsPerComponent = 8
        // swiftlint:disable:next line_length
        let bitmapInfo: UInt32 = CGImageAlphaInfo.premultipliedLast.rawValue | CGBitmapInfo.byteOrder32Big.rawValue
        
        guard let context = CGContext(data: nil,
                                      width: width,
                                      height: height,
                                      bitsPerComponent: bitsPerComponent,
                                      bytesPerRow: bytesPerRow,
                                      space: colorSpace,
                                      bitmapInfo: bitmapInfo) else { return nil }
        guard let pixelData = context.data?.assumingMemoryBound(to: UInt8.self) else { return nil }
        
        context.draw(cgImage, in: CGRect(x: 0, y: 0, width: width, height: height))
        
        var minX = width
        var minY = height
        var maxX = 0
        var maxY = 0
        
        for x in (1..<width) {
            for y in (1..<height) {
                let i = bytesPerRow * y + bytesPerPixel * x
                let a = CGFloat(pixelData[i + 3]) / 255.0
                guard a > 0 else { continue }
                minX = min(x, minX)
                maxX = max(x, maxX)
                minY = min(y, minY)
                maxY = max(y, maxY)
            }
        }
        
        let rect = CGRect(
            x: CGFloat(minX),
            y: CGFloat(minY),
            width: CGFloat(maxX - minX),
            height: CGFloat(maxY - minY)
        )
        guard let croppedImage = cgImage.cropping(to: rect) else { return nil }
        return UIImage(cgImage: croppedImage, scale: 1, orientation: imageOrientation)
    }
}
