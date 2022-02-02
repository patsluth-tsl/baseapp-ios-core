//
//  CoreImage+BA.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-11-02.
//  Copyright © 2017 SilverLogic. All rights reserved.
//

#if !os(watchOS)

import CoreImage
import UIKit

public extension CIImage {
    var averageColor: UIColor? {
        guard let filter = CIFilter(name: "CIAreaAverage", parameters: [
            kCIInputImageKey: self,
            kCIInputExtentKey: CIVector(
                x: extent.origin.x,
                y: extent.origin.y,
                z: extent.size.width,
                w: extent.size.height
            )
        ]) else { return nil }
        guard let outputImage = filter.outputImage else { return nil }
        
        var bitmap = [UInt8](repeating: 0, count: 4)
        let context = CIContext(options: [
            .workingColorSpace: kCFNull as Any
        ])
        context.render(
            outputImage,
            toBitmap: &bitmap,
            rowBytes: 4,
            bounds: CGRect(x: 0, y: 0, width: 1, height: 1),
            format: .RGBA8,
            colorSpace: nil
        )
        return UIColor(
            red: CGFloat(bitmap[0]) / 0xFF,
            green: CGFloat(bitmap[1]) / 0xFF,
            blue: CGFloat(bitmap[2]) / 0xFF,
            alpha: CGFloat(bitmap[3]) / 0xFF
        )
    }
}

#endif
