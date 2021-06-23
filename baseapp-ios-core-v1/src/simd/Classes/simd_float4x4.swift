//
//  simd_float4x4.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-10-16.
//  Copyright © 2019 SilverLogic. All rights reserved.
//

import Foundation
import SceneKit
import simd

public extension simd_float4x4 {
    var m11: SCNFloat { return columns.0.x }
    var m12: SCNFloat { return columns.0.y }
    var m13: SCNFloat { return columns.0.z }
    var m14: SCNFloat { return columns.0.w }
    var m21: SCNFloat { return columns.1.x }
    var m22: SCNFloat { return columns.1.y }
    var m23: SCNFloat { return columns.1.z }
    var m24: SCNFloat { return columns.1.w }
    var m31: SCNFloat { return columns.2.x }
    var m32: SCNFloat { return columns.2.y }
    var m33: SCNFloat { return columns.2.z }
    var m34: SCNFloat { return columns.2.w }
    var m41: SCNFloat { return columns.3.x }
    var m42: SCNFloat { return columns.3.y }
    var m43: SCNFloat { return columns.3.z }
    var m44: SCNFloat { return columns.3.w }
    
    /**
     Treats matrix as a (right-hand column-major convention) transform matrix
     and factors out the translation component of the transform.
     */
    var translation: simd_float3 {
        return simd_float3(m41, m42, m43)
    }
    
    var orientation: simd_quatf {
        return simd_quatf(self)
    }
    
    var scale: simd_float3 {
        return simd_float3(
            simd_float3(m11, m12, m13).length,
            simd_float3(m21, m22, m23).length,
            simd_float3(m31, m32, m33).length
        )
    }
    
    var zForward: simd_float3 {
        return simd_float3(m31, m32, m33)
    }
    
    init(_ matrix: SCNMatrix4) {
        self = simd_float4x4(
            SIMD4(
                matrix.m11,
                matrix.m12,
                matrix.m13,
                matrix.m14
            ),
            SIMD4(
                matrix.m21,
                matrix.m22,
                matrix.m23,
                matrix.m24
            ),
            SIMD4(
                matrix.m31,
                matrix.m32,
                matrix.m33,
                matrix.m34
            ),
            SIMD4(
                matrix.m41,
                matrix.m42,
                matrix.m43,
                matrix.m44
            )
        )
    }
    
    init(from: simd_float3, to: simd_float3) {
        let distance = simd_float3.distance(from: from, to: to)
        //        guard !distance.isLessThanOrEqualTo(0.0) else {
        //            self = simd_float4x4.zero
        //            return
        //        }
        
        // original vector of cylinder above 0,0,0
        let oldPosition = simd_float3(
            0,
            distance / 2,
            0
        )
        // target vector, in new coordination
        let newPosition = simd_float3(
            (to.x - from.x) / 2,
            (to.y - from.y) / 2,
            (to.z - from.z) / 2
        )
        
        let axis = simd_float3.midPoint(from: oldPosition, to: newPosition).normalized
        
        let q0 = Float(0.0) //cos(angel/2), angle is always 180 or M_PI
        let q1 = Float(axis.x) // x' * sin(angle/2)
        let q2 = Float(axis.y) // y' * sin(angle/2)
        let q3 = Float(axis.z) // z' * sin(angle/2)
        
        self = simd_float4x4(
            SIMD4(
                (q0 * q0 + q1 * q1 - q2 * q2 - q3 * q3),
                (2 * q1 * q2 + 2 * q0 * q3),
                (2 * q1 * q3 - 2 * q0 * q2),
                (0)
            ),
            SIMD4(
                (2.0 * q1 * q2 - 2.0 * q0 * q3),
                (q0 * q0 - q1 * q1 + q2 * q2 - q3 * q3),
                (2.0 * q2 * q3 + 2.0 * q0 * q1),
                (0)
            ),
            SIMD4(
                (2 * q1 * q3 + 2 * q0 * q2),
                (2 * q2 * q3 - 2 * q0 * q1),
                (q0 * q0 - q1 * q1 - q2 * q2 + q3 * q3),
                (0)
            ),
            SIMD4(
                ((from.x + to.x) / 2),
                ((from.y + to.y) / 2),
                ((from.z + to.z) / 2),
                (1)
            )
        )
    }
}
