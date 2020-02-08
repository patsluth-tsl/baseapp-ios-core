//
//  SCNMatrix4.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-10-18.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import SceneKit
import simd

public extension SCNMatrix4 {
    /**
     Treats matrix as a (right-hand column-major convention) transform matrix
     and factors out the translation component of the transform.
     */
    var translation: SCNVector3 {
        return SCNVector3(m41, m42, m43)
    }
    
    var scale: SCNVector3 {
        return SCNVector3(
            SCNVector3(m11, m12, m13).length,
            SCNVector3(m21, m22, m23).length,
            SCNVector3(m31, m32, m33).length
        )
    }
    
    var zForward: SCNVector3 {
        return SCNVector3(m31, m32, m33)
    }
    
    init(from: SCNVector3, to: SCNVector3) {
        self = SCNMatrix4(
            simd_float4x4(from: simd_float3(from), to: simd_float3(to))
        )
    }
}
