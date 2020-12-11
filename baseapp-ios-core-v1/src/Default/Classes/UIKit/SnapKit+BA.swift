//
//  SnapKit+SW.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-02-25.
//

#if os(iOS)

import SnapKit
import UIKit

public extension NSObjectProtocol
	where Self: UIView {
    
    @discardableResult
	func make(constraints block: (ConstraintMaker) -> Void) -> Self {
		snp.makeConstraints({
			block($0)
		})
		return self
	}
	
	@discardableResult
	func make(constraints block: (ConstraintMaker, Self) -> Void) -> Self {
		snp.makeConstraints({
			block($0, self)
		})
		return self
	}
	
	@discardableResult
	func remake(constraints block: (ConstraintMaker) -> Void) -> Self {
		snp.remakeConstraints({
			block($0)
		})
		return self
	}
	
	@discardableResult
	func remake(constraints block: (ConstraintMaker, Self) -> Void) -> Self {
		snp.remakeConstraints({
			block($0, self)
		})
		return self
	}
	
	@discardableResult
	func update(constraints block: (ConstraintMaker) -> Void) -> Self {
		snp.updateConstraints({
			block($0)
		})
		return self
	}
	
	@discardableResult
	func update(constraints block: (ConstraintMaker, Self) -> Void) -> Self {
		snp.updateConstraints({
			block($0, self)
		})
		return self
	}
}

#endif
