//
//  SCNPlane.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-10-18.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import SceneKit

public extension SCNPlane {
	var size: CGSize {
        get {
            return CGSize(width: width, height: height)
        }
        set {
            width = newValue.width
            height = newValue.height
        }
    }
}
