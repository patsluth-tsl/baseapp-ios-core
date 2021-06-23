//
//  ARCamera+BA.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-10-16.
//  Copyright © 2019 SilverLogic. All rights reserved.
//

import ARKit
import Foundation
import SceneKit

@available(iOS 11.0, *)
public extension ARCamera {
	var worldPosition: simd_float3 {
		return transform.translation
	}
}
