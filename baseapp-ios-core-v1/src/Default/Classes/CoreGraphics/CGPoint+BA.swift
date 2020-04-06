//
//  CGPoint+BA.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-12-08.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation

public extension CGPoint {
	var integral: CGPoint {
		return CGPoint(x: Int(self.x), y: Int(self.y))
	}
	
	var rounded: CGPoint {
		return CGPoint(x: round(self.x), y: round(self.y))
	}
    
    
    
    
    
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
