//
//  UIEdgeInsets+BA.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-12-08.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation

#if os(iOS)

public extension UIEdgeInsets {
    var size: CGSize {
        return CGSize(width: self.left + self.right,
                      height: self.top + self.bottom)
    }
    
    
    
    
    
    init(_ spacing: (h: CGFloat, v: CGFloat)) {
        self = UIEdgeInsets(spacing.h, spacing.v)
    }
    
    init(_ horizontal: CGFloat, _ vertical: CGFloat) {
        self = UIEdgeInsets(top: vertical,
                            left: horizontal,
                            bottom: vertical,
                            right: horizontal)
    }
    
    /// Returns new `UIEdgeInsets` with top
    func with(top: CGFloat) -> UIEdgeInsets {
        var edgeInsets = self
        return edgeInsets.top(top)
    }
    
    /// Returns new `UIEdgeInsets` with left
    func with(left: CGFloat) -> UIEdgeInsets {
        var edgeInsets = self
        return edgeInsets.left(left)
    }
    
    /// Returns new `UIEdgeInsets` with bottom
    func with(bottom: CGFloat) -> UIEdgeInsets {
        var edgeInsets = self
        return edgeInsets.bottom(bottom)
    }
    
    /// Returns new `UIEdgeInsets` with right
    func with(right: CGFloat) -> UIEdgeInsets {
        var edgeInsets = self
        return edgeInsets.right(right)
    }
    
    /// Update top
    @discardableResult
    mutating func top(_ value: CGFloat) -> UIEdgeInsets {
        top = value
        return self
    }
    
    /// Update left
    @discardableResult
    mutating func left(_ value: CGFloat) -> UIEdgeInsets {
        left = value
        return self
    }
    
    /// Update bottom
    @discardableResult
    mutating func bottom(_ value: CGFloat) -> UIEdgeInsets {
        bottom = value
        return self
    }
    
    /// Update right
    @discardableResult
    mutating func right(_ value: CGFloat) -> UIEdgeInsets {
        right = value
        return self
    }
}

#endif
