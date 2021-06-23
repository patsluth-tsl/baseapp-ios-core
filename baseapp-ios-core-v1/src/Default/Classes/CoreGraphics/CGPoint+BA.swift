//
//  CGPoint+BA.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-12-08.
//  Copyright © 2017 SilverLogic. All rights reserved.
//

import CoreGraphics
import Foundation

public extension CGPoint {
	var integral: CGPoint {
		return CGPoint(x: Int(x), y: Int(y))
	}
	
	var rounded: CGPoint {
		return CGPoint(x: round(x), y: round(y))
	}
}


public extension CGPoint {
    static func + (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x + rhs.x, y: lhs.y + rhs.y)
    }
    
    static func += (lhs: inout CGPoint, rhs: CGPoint) {
        lhs = lhs + rhs
    }
    
    static func + (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x + rhs, y: lhs.y + rhs)
    }
    
    static func += (lhs: inout CGPoint, rhs: CGFloat) {
        lhs = lhs + rhs
    }
    
    
    
    static func - (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x - rhs.x, y: lhs.y - rhs.y)
    }
    
    static func -= (lhs: inout CGPoint, rhs: CGPoint) {
        lhs = lhs - rhs
    }
    
    static func - (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x - rhs, y: lhs.y - rhs)
    }
    
    static func -= (lhs: inout CGPoint, rhs: CGFloat) {
        lhs = lhs - rhs
    }
    
    
    
    static func * (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x * rhs.x, y: lhs.y * rhs.y)
    }
    
    static func *= (lhs: inout CGPoint, rhs: CGPoint) {
        lhs = lhs * rhs
    }
    
    static func * (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x * rhs, y: lhs.y * rhs)
    }
    
    static func *= (lhs: inout CGPoint, rhs: CGFloat) {
        lhs = lhs * rhs
    }
    
    
    
    static func / (lhs: CGPoint, rhs: CGPoint) -> CGPoint {
        return CGPoint(x: lhs.x / rhs.x, y: lhs.y / rhs.y)
    }
    
    static func /= (lhs: inout CGPoint, rhs: CGPoint) {
        lhs = lhs / rhs
    }
    
    static func / (lhs: CGPoint, rhs: CGFloat) -> CGPoint {
        return CGPoint(x: lhs.x / rhs, y: lhs.y / rhs)
    }
    
    static func /= (lhs: inout CGPoint, rhs: CGFloat) {
        lhs = lhs / rhs
    }
}


public extension CGPoint {
    /// Returns new `CGPoint` with x
    func with(x: CGFloat) -> CGPoint {
        var point = self
        return point.x(x)
    }
    
    /// Returns new `CGPoint` with y
    func with(y: CGFloat) -> CGPoint {
        var point = self
        return point.y(y)
    }
    
    /// Update x
	@discardableResult
	mutating func x(_ x: CGFloat) -> CGPoint {
		self.x = x
		return self
	}
	
    /// Update y
	@discardableResult
	mutating func y(_ y: CGFloat) -> CGPoint {
		self.y = y
		return self
	}
}


public extension CGPoint {
    /**
     Rotates the point from the center `origin` by `angle` radians along the Z axis.
     
     - Parameters:
     - origin: The center of he rotation;
     - byDegrees: Amount of radians to rotate around the Z axis.
     
     - Returns: The rotated point.
     */
    func rotated(around origin: CGPoint, by angle: CGFloat) -> CGPoint {
        let dx = x - origin.x
        let dy = y - origin.y
        let radius = sqrt(dx * dx + dy * dy)
        let azimuth = atan2(dy, dx)
        let newAzimuth = azimuth + angle
        let x = origin.x + radius * cos(newAzimuth)
        let y = origin.y + radius * sin(newAzimuth)
        return CGPoint(x: x, y: y)
    }
    
    /**
     Rotate the point from the center `origin` by `angle` radians along the Z axis.
     
     - Parameters:
     - origin: The center of he rotation;
     - byDegrees: Amount of radians to rotate around the Z axis.
     */
    @discardableResult
    mutating func rotate(around origin: CGPoint, by angle: CGFloat) -> CGPoint {
        self = self.rotated(around: origin, by: angle)
        return self
    }
}
