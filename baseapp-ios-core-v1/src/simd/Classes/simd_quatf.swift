//
//  simd_quatf.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-10-16.
//  Copyright © 2019 SilverLogic. All rights reserved.
//

import Foundation
import SceneKit
import simd

public extension simd_quatf {
	static var zero: simd_quatf {
		return simd_quatf(vector: simd_float4.zero)
	}
}
