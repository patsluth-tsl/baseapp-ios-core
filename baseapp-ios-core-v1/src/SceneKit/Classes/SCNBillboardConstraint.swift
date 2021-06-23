//
//  SCNBillboardConstraint.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-10-16.
//  Copyright © 2019 SilverLogic. All rights reserved.
//

import Foundation
import SceneKit

@available(iOS 9.0, OSX 10.11, *)
public extension SCNBillboardConstraint {
    convenience init(freeAxes: SCNBillboardAxis) {
        self.init()

        self.freeAxes = freeAxes
    }
}
