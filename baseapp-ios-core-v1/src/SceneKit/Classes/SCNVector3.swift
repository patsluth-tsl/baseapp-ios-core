//
//  SCNVector3.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-10-16.
//  Copyright © 2019 SilverLogic. All rights reserved.
//

import Foundation
import SceneKit
import simd

infix operator ● // Dot product
infix operator × // Cross product

public extension SCNVector3 {
    var length: SCNFloat {
        return sqrt(self ● self)
    }
    
    var inverse: SCNVector3 {
        return self * -1.0
    }
    
    /// Vector in the same direction as this vector with a magnitude of 1
    var normalized: SCNVector3 {
		return SCNVector3(simd_normalize(simd_float3(self)))
    }
	
	
	
    
    
    func distance(to vector: SCNVector3) -> SCNFloat {
		return SCNVector3.distance(from: self, to: vector)
	}
    
    static func distance(from vectorA: SCNVector3, to vectorB: SCNVector3) -> SCNFloat {
        return SCNFloat(simd_distance(simd_float3(vectorA), simd_float3(vectorB)))
    }
	
	func midPoint(to vector: SCNVector3) -> SCNVector3 {
		return SCNVector3.midPoint(from: self, to: vector)
	}
    
    static func midPoint(from vectorA: SCNVector3, to vectorB: SCNVector3) -> SCNVector3 {
        let x = (vectorA.x + vectorB.x) / 2.0
        let y = (vectorA.y + vectorB.y) / 2.0
        let z = (vectorA.z + vectorB.z) / 2.0
        
        return SCNVector3(x, y, z)
    }
    
//    static func axis(between vectorA: SCNVector3, and vectorB: SCNVector3) -> SCNVector3
//    {
//        return SCNVector3.midPoint(of: vectorA, and: vectorB)
//    }
	
	func angle(to vector: SCNVector3) -> SCNFloat {
		return SCNVector3.angle(between: self, and: vector)
	}
	
    static func angle(between vectorA: SCNVector3, and vectorB: SCNVector3) -> SCNFloat {
        return acos((vectorA ● vectorB) / (vectorA.length * vectorB.length))
    }
	
	func project(onto vector: SCNVector3) -> SCNVector3 {
		return SCNVector3.project(vectorA: self, onto: vector)
	}
    
    static func project(vectorA: SCNVector3, onto vectorB: SCNVector3) -> SCNVector3 {
        return SCNVector3(simd_project(simd_float3(vectorA), simd_float3(vectorB)))
    }
    
    static func project(vectorA: SCNVector3, onto vectorB: simd_float3) -> SCNVector3 {
        return SCNVector3(simd_project(simd_float3(vectorA), vectorB))
    }
    
    static func project(vectorA: simd_float3, onto vectorB: SCNVector3) -> SCNVector3 {
        return SCNVector3(simd_project(vectorA, simd_float3(vectorB)))
    }
    
    
    
    
    
    static func + (lhs: SCNVector3, rhs: SCNVector3) -> SCNVector3 {
        return SCNVector3(simd_float3(lhs) + simd_float3(rhs))
    }
    
    static func += (lhs: inout SCNVector3, rhs: SCNVector3) {
        lhs = lhs + rhs
    }
    
    static func + (lhs: SCNVector3, rhs: SCNFloat) -> SCNVector3 {
        return SCNVector3(lhs.x + rhs, lhs.y + rhs, lhs.z + rhs)
    }
    
    static func += (lhs: inout SCNVector3, rhs: SCNFloat) {
        lhs = lhs + rhs
    }
    
    static func + (lhs: SCNFloat, rhs: SCNVector3) -> SCNVector3 {
        return rhs + lhs
    }
    
    
    
    static func - (lhs: SCNVector3, rhs: SCNVector3) -> SCNVector3 {
        return SCNVector3(simd_float3(lhs) - simd_float3(rhs))
    }
    
    static func -= (lhs: inout SCNVector3, rhs: SCNVector3) {
        lhs = lhs - rhs
    }
    
    static func - (lhs: SCNVector3, rhs: SCNFloat) -> SCNVector3 {
        return SCNVector3(lhs.x - rhs, lhs.y - rhs, lhs.z - rhs)
    }
    
    static func -= (lhs: inout SCNVector3, rhs: SCNFloat) {
        lhs = lhs - rhs
    }
    
    static func - (lhs: SCNFloat, rhs: SCNVector3) -> SCNVector3 {
        return rhs - lhs
    }
    
    
    
    static func * (lhs: SCNVector3, rhs: SCNVector3) -> SCNVector3 {
        return SCNVector3(simd_float3(lhs) * simd_float3(rhs))
    }
    
    static func *= (lhs: inout SCNVector3, rhs: SCNVector3) {
        lhs = lhs * rhs
    }
    
    static func * (lhs: SCNVector3, rhs: SCNFloat) -> SCNVector3 {
        return SCNVector3(lhs.x * rhs, lhs.y * rhs, lhs.z * rhs)
    }
    
    static func *= (lhs: inout SCNVector3, rhs: SCNFloat) {
        lhs = lhs * rhs
    }
    
    static func * (lhs: SCNFloat, rhs: SCNVector3) -> SCNVector3 {
        return rhs * lhs
    }
    
    static func * (lhs: SCNVector3, rhs: SCNMatrix4) -> SCNVector3 {
        return SCNVector3(
            lhs.x * rhs.m11 + lhs.y * rhs.m21 + lhs.z * rhs.m31 + rhs.m41,
            lhs.x * rhs.m12 + lhs.y * rhs.m22 + lhs.z * rhs.m32 + rhs.m42,
            lhs.x * rhs.m13 + lhs.y * rhs.m23 + lhs.z * rhs.m33 + rhs.m43
        )
    }
	
	static func *= (lhs: inout SCNVector3, rhs: SCNMatrix4) {
        lhs = lhs * rhs
	}
    
    static func * (v: SCNVector3, q: SCNQuaternion) -> SCNVector3 {
        let qv = SCNVector3(q.x, q.y, q.z)
        let uv = qv × v
        let uuv = qv × uv
        return v + (uv * 2.0 * q.w) + (uuv * 2.0)
    }
	
	static func *= (lhs: inout SCNVector3, q: SCNQuaternion) {
        lhs = lhs * q
	}
    
    
    
    static func / (lhs: SCNVector3, rhs: SCNVector3) -> SCNVector3 {
        return SCNVector3(simd_float3(lhs) / simd_float3(rhs))
    }
    
    static func /= (lhs: inout SCNVector3, rhs: SCNVector3) {
        lhs = lhs / rhs
    }
    
    static func / (lhs: SCNVector3, rhs: SCNFloat) -> SCNVector3 {
        return SCNVector3(lhs.x / rhs, lhs.y / rhs, lhs.z / rhs)
    }
    
    static func /= (lhs: inout SCNVector3, rhs: SCNFloat) {
        lhs = lhs / rhs
    }
    
    
    
    static func == (lhs: SCNVector3, rhs: SCNVector3) -> Bool {
        return lhs.x == rhs.x && lhs.y == rhs.y && lhs.z == rhs.z
    }
    
    static func ~= (lhs: SCNVector3, rhs: SCNVector3) -> Bool {
        return lhs.x ~= rhs.x && lhs.y ~= rhs.y && lhs.z ~= rhs.z
    }
    
    
    
    static func ● (lhs: SCNVector3, rhs: SCNVector3) -> SCNFloat {
        return SCNFloat(simd_dot(simd_float3(lhs), simd_float3(rhs)))
    }
    
    static func × (lhs: SCNVector3, rhs: SCNVector3) -> SCNVector3 {
        return SCNVector3(simd_cross(simd_float3(lhs), simd_float3(rhs)))
    }
}
