//
//  CGRect+BA.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-12-08.
//  Copyright © 2017 SilverLogic. All rights reserved.
//

import CoreGraphics
import Foundation

public extension CGRect {
    public init(center: CGPoint, size: CGSize) {
        self = CGRect(origin: .zero, size: size).with(center: center)
    }
    
    var center: CGPoint {
        get {
            return CGPoint(x: midX, y: midY)
        }
        mutating set {
            self.origin(CGPoint(
                x: newValue.x - (size.width / 2.0),
                y: newValue.y - (size.height / 2.0)
            ))
        }
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
    
    /// Returns new `CGRect` with center
    func with(center: CGPoint) -> CGRect {
        var rect = self
        return rect.center(center)
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
    
    /// Update center
    @discardableResult
    mutating func center(_ center: CGPoint) -> CGRect {
        self.center = center
        return self
    }
}

public extension CGRect {
    init(bottomMiddle: CGPoint, size: CGSize) {
        self = CGRect(origin: .zero, size: size).with(bottomMiddle: bottomMiddle)
    }
    
    var bottomMiddle: CGPoint {
        get {
            return CGPoint(x: midX, y: maxY)
        }
        mutating set {
            self.origin(CGPoint(
                x: newValue.x - (size.width / 2.0),
                y: newValue.y - size.height
            ))
        }
    }
    
    /// Returns new `CGRect` with bottomMiddle
    func with(bottomMiddle: CGPoint) -> CGRect {
        var rect = self
        return rect.bottomMiddle(bottomMiddle)
    }
    
    /// Update bottomMiddle
    @discardableResult
    mutating func bottomMiddle(_ bottomMiddle: CGPoint) -> CGRect {
        self.bottomMiddle = bottomMiddle
        return self
    }
}

public extension CGRect {
    init(topMiddle: CGPoint, size: CGSize) {
        self = CGRect(origin: .zero, size: size).with(topMiddle: topMiddle)
    }
    
    var topMiddle: CGPoint {
        get {
            return CGPoint(x: midX, y: minY)
        }
        mutating set {
            self.origin(CGPoint(
                x: newValue.x - (size.width / 2.0),
                y: newValue.y
            ))
        }
    }
    
    /// Returns new `CGRect` with topMiddle
    func with(topMiddle: CGPoint) -> CGRect {
        var rect = self
        return rect.topMiddle(topMiddle)
    }
    
    /// Update topMiddle
    @discardableResult
    mutating func topMiddle(_ topMiddle: CGPoint) -> CGRect {
        self.topMiddle = topMiddle
        return self
    }
}
