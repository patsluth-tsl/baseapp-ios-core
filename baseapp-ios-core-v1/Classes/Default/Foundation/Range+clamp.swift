//
//  Range+clamp.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation

public extension ClosedRange {
	func clamp(_ value: Bound) -> Bound {
		return Swift.min(Swift.max(value, lowerBound), upperBound)
	}
}

public extension Range {
	func clamp(_ value: Bound) -> Bound {
		return Swift.min(Swift.max(value, lowerBound), upperBound)
	}
}
