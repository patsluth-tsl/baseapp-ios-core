//
//  SCNMaterial.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-10-18.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import SceneKit

public extension SCNMaterial {
	class func constantLitWith(color: UIColor) -> SCNMaterial {
        return SCNMaterial.make({
            $0.diffuse.contents = color
            $0.isDoubleSided = true
            $0.ambient.contents = UIColor.black
            $0.lightingModel = SCNMaterial.LightingModel.constant
            $0.emission.contents = color
        })
	}
}
