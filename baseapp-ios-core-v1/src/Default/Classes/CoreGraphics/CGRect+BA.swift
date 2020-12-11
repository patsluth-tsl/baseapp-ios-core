//
//  CGPoint+BA.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-12-08.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import CoreGraphics
import Foundation

public extension CGRect {
    var center: CGPoint {
        return CGPoint(x: self.midX, y: midY)
    }
}

public extension CGRect {
    /// Returns new `CGRect` with origin
    func with(origin: CGPoint) -> CGRect {
        var rect = self
        return rect.origin(origin)
    }
    
    /// Returns new `CGRect` with size
    func with(size: CGSize) -> CGRect {
        var rect = self
        return rect.size(size)
    }
    
    /// Update origin
	@discardableResult
	mutating func origin(_ origin: CGPoint) -> CGRect {
		self.origin = origin
		return self
	}
	
    /// Update size
	@discardableResult
    mutating func size(_ size: CGSize) -> CGRect {
        self.size = size
        return self
    }
}
