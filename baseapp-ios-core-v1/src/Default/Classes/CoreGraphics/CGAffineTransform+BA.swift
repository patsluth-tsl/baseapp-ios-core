//
//  CGAffineTransform+BA.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-12-08.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation

#if os(iOS)

public extension CGAffineTransform {
    static func translation(x: CGFloat = 0.0, y: CGFloat = 0.0) -> Self {
        return CGAffineTransform(translationX: x, y: y)
    }
    
    static func scale(x: CGFloat = 0.0, y: CGFloat = 0.0) -> Self {
        return CGAffineTransform(scaleX: x, y: y)
    }
    
    static func rotate(_ angle: CGFloat = 0.0) -> Self {
        return CGAffineTransform(rotationAngle: angle)
    }
}

#endif
