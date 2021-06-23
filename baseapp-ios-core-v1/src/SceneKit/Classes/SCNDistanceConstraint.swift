//
//  SCNDistanceConstraint.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-10-16.
//  Copyright © 2019 SilverLogic. All rights reserved.
//

import Foundation
import SceneKit

@available(iOS 11.0, OSX 10.13, *)
public extension SCNDistanceConstraint {
    convenience init(target: SCNNode?, minimumDistance: CGFloat, maximumDistance: CGFloat) {
        self.init(target: target)
        
        self.minimumDistance = minimumDistance
        self.maximumDistance = maximumDistance
    }
}
