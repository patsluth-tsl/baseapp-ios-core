//
//  simd_float2+BA.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-10-16.
//  Copyright © 2019 SilverLogic. All rights reserved.
//

import CoreGraphics
import simd


public extension simd_float2 {
    init(point: CGPoint) {
        self.init(point.x.cast(), point.y.cast())
    }
}
