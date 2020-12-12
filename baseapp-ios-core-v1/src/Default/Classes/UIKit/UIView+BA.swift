//
//  UIView+BA.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-12-03.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation
import UIKit

#if os(iOS)

public extension NSObjectProtocol
	where Self: UIView {
    @discardableResult
	func addTo(superview: UIView) -> Self {
		superview.addSubview(self)
		return self
	}
	
	@discardableResult
	func addTo(superview provider: () -> UIView) -> Self {
		return addTo(superview: provider())
	}
}

public extension NSObjectProtocol
where Self: UIView {
    /// wrapper for setContentHuggingPriority(priority:for:)
    /// The priority with which a view resists being made larger than its intrinsic size.
    @discardableResult
    func contentHugging(priority: UILayoutPriority,
                        for axis: NSLayoutConstraint.Axis) -> Self {
        setContentHuggingPriority(priority, for: axis)
        return self
    }
    
    /// wrapper for setContentCompressionResistancePriority(priority:for:)
    /// The priority with which a view resists being made smaller than its intrinsic size.
    @discardableResult
    func compressionResistance(priority: UILayoutPriority,
                               for axis: NSLayoutConstraint.Axis) -> Self {
        setContentCompressionResistancePriority(priority, for: axis)
        return self
    }
}

#endif
