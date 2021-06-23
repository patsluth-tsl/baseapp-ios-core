//
//  simd_float3.swift
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

public extension simd_float3 {
	var length: SCNFloat {
		return simd_length(self)
	}
	
	var inverse: simd_float3 {
		return self * -1.0
	}
	
	/// Vector in the same direction as this vector with a magnitude of 1
	var normalized: simd_float3 {
		return simd_normalize(self)
	}
	
	static var zero: simd_float3 {
		return simd_float3(0.0, 0.0, 0.0)
	}
	
	
	
	
	
	func distance(to vector: simd_float3) -> SCNFloat {
		return simd_float3.distance(from: self, to: vector)
	}
	
	static func distance(from vectorA: simd_float3, to vectorB: simd_float3) -> SCNFloat {
		return simd_distance(vectorA, vectorB)
	}
	
	func midPoint(to: simd_float3) -> simd_float3 {
        return simd_float3.midPoint(from: self, to: to)
	}
    
    static func midPoint(from: simd_float3, to: simd_float3) -> simd_float3 {
        return simd_float3(
            (from.x + to.x) / 2.0,
            (from.y + to.y) / 2.0,
            (from.z + to.z) / 2.0
        )
    }
	
	func angle(to: simd_float3) -> SCNFloat {
        return simd_float3.angle(from: self, to: to)
	}
	
	static func angle(from: simd_float3, to: simd_float3) -> SCNFloat {
		return acos((from ● to) / (from.length * to.length))
	}
	
	func project(onto vector: simd_float3) -> simd_float3 {
		return simd_project(self, vector)
	}
	
	
	
	
	
	static func + (lhs: simd_float3, rhs: SCNFloat) -> simd_float3 {
		return simd_float3(lhs.x + rhs, lhs.y + rhs, lhs.z + rhs)
	}
	
	static func += (lhs: inout simd_float3, rhs: SCNFloat) {
        lhs = lhs + rhs
	}
	
	static func + (lhs: SCNFloat, rhs: simd_float3) -> simd_float3 {
		return rhs + lhs
	}
	
	
	
	
	static func - (lhs: simd_float3, rhs: SCNFloat) -> simd_float3 {
		return simd_float3(lhs.x - rhs, lhs.y - rhs, lhs.z - rhs)
	}
	
	static func -= (lhs: inout simd_float3, rhs: SCNFloat) {
        lhs = lhs - rhs
	}
	
	static func - (lhs: SCNFloat, rhs: simd_float3) -> simd_float3 {
		return rhs - lhs
	}
    
    
    
	static func * (lhs: simd_float3, rhs: simd_float4x4) -> simd_float3 {
		let matrix = SCNMatrix4(rhs)
		return simd_float3(
			lhs.x * matrix.m11 + lhs.y * matrix.m21 + lhs.z * matrix.m31 + matrix.m41,
			lhs.x * matrix.m12 + lhs.y * matrix.m22 + lhs.z * matrix.m32 + matrix.m42,
			lhs.x * matrix.m13 + lhs.y * matrix.m23 + lhs.z * matrix.m33 + matrix.m43
		)
	}
	
	static func *= (lhs: inout simd_float3, rhs: simd_float4x4) {
        lhs = lhs * rhs
	}
	
	static func * (v: simd_float3, q: simd_quatf) -> simd_float3 {
		let qv = simd_float3(q.vector.x, q.vector.y, q.vector.z)
		let uv = qv × v
		let uuv = qv × uv
		
		let a = (uv * 2.0 * q.vector.w)
		let b = (uuv * 2.0)
		return v + a + b
	}
	
	static func *= (lhs: inout simd_float3, q: simd_quatf) {
        lhs = lhs * q
	}
    
    
    
	static func ● (lhs: simd_float3, rhs: simd_float3) -> SCNFloat {
		return simd_dot(lhs, rhs)
	}
	
	static func × (lhs: simd_float3, rhs: simd_float3) -> simd_float3 {
		return simd_cross(lhs, rhs)
	}
}

public extension simd_float3 {
    /// Returns new `simd_float3` with x
    func with(x: SCNFloat) -> simd_float3 {
        var float3 = self
        return float3.x(x)
    }
    
    /// Returns new `simd_float3` with x
    func with(y: SCNFloat) -> simd_float3 {
        var float3 = self
        return float3.y(y)
    }
    
    /// Returns new `simd_float3` with x
    func with(z: SCNFloat) -> simd_float3 {
        var float3 = self
        return float3.z(z)
    }
    
    /// Update x
    @discardableResult
    mutating func x(_ x: SCNFloat) -> simd_float3 {
        self.x = x
        return self
    }
    
    /// Update y
    @discardableResult
    mutating func y(_ y: SCNFloat) -> simd_float3 {
        self.y = y
        return self
    }
    
    /// Update z
    @discardableResult
    mutating func z(_ z: SCNFloat) -> simd_float3 {
        self.z = z
        return self
    }
}
