//
//  UIStackView+BA.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 SilverLogic. All rights reserved.
//

import UIKit

#if os(iOS)

public extension UIStackView {
	@discardableResult
	func axis(_ axis: NSLayoutConstraint.Axis) -> Self {
		self.axis = axis
		return self
	}
	
	@discardableResult
	func distribution(_ distribution: UIStackView.Distribution) -> Self {
		self.distribution = distribution
		return self
	}
	
	@discardableResult
	func alignment(_ alignment: UIStackView.Alignment) -> Self {
		self.alignment = alignment
		return self
	}
	
	@discardableResult
	func spacing(_ spacing: CGFloat) -> Self {
		self.spacing = spacing
		return self
	}
	
	@discardableResult
	func baselineRelative(_ isBaselineRelativeArrangement: Bool) -> Self {
		self.isBaselineRelativeArrangement = isBaselineRelativeArrangement
		return self
	}
	
	@discardableResult
	func layoutMarginsRelative(_ isLayoutMarginsRelativeArrangement: Bool) -> Self {
		self.isLayoutMarginsRelativeArrangement = isLayoutMarginsRelativeArrangement
		return self
	}
	
	/// Remove all arranged subviews
	@discardableResult
	func removeAll() -> Self {
		remove(arrangedSubviews)
		return self
	}
	
	@discardableResult
	func add(_ arrangedSubviews: UIView...) -> Self {
		add(arrangedSubviews)
		return self
	}
	
	@discardableResult
	func add(_ arrangedSubviews: [UIView]) -> Self {
		arrangedSubviews.forEach({
			addArrangedSubview($0)
		})
		return self
	}
	
	@discardableResult
	func add(_ arrangedSubviewsBlock: () -> [UIView]) -> Self {
		add(arrangedSubviewsBlock())
		return self
	}
	
	@discardableResult
	func remove(_ arrangedSubviews: UIView...) -> Self {
		remove(arrangedSubviews)
		return self
	}
	
	@discardableResult
    func remove(_ arrangedSubviews: [UIView]) -> Self {
		arrangedSubviews.forEach({
			$0.removeFromSuperview()
			removeArrangedSubview($0)
		})
		return self
	}
}

#endif
