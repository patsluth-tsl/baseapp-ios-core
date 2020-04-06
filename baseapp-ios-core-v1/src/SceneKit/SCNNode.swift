//
//  SCNNode.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-10-18.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import SceneKit

public extension SCNNode {
	var zForward: SCNVector3 {
        return worldTransform.zForward
	}
	
	var simdZForward: simd_float3 {
        return simd_float3(zForward)
	}
	
	/* Calculate the pivot for anchorPoint of the nodes boundingBox
	* '(0.0, 0.0, 0.0)' is the top left
	* '(0.5, 0.5, 0.5)' is the centre
	* '(1.0, 1.0, 1.0)' is the bottom right */
	@available(iOS 8.0, OSX 10.10, *)
	func pivotFor(anchorPoint: SCNVector3) -> SCNMatrix4 {
		let min = boundingBox.min
		let max = boundingBox.max
		
		return SCNMatrix4MakeTranslation(
			(min.x + (max.x - min.x) * anchorPoint.x),
			(min.y + (max.y - min.y) * anchorPoint.y),
			(min.z + (max.z - min.z) * anchorPoint.z)
		)
	}
    
    /* Calculate the pivot for anchorPoint of the nodes boundingBox
     * '(0.0, 0.0, 0.0)' is the top left
     * '(0.5, 0.5, 0.5)' is the centre
     * '(1.0, 1.0, 1.0)' is the bottom right */
    @available(iOS 8.0, OSX 10.10, *)
    func simdPivotFor(anchorPoint: simd_float3) -> simd_float4x4 {
        return simd_float4x4(
            pivotFor(anchorPoint: SCNVector3(anchorPoint))
        )
    }
}
