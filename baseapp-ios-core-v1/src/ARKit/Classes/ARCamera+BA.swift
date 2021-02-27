//
//  ARCamera+BA.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-10-18.
//  Copyright © 2017 Apple. All rights reserved.
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
