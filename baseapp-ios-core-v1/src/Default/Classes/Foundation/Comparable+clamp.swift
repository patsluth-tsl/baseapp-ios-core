//
//  Range+clamp.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation

public extension Comparable {
    mutating func clamp(to closedRange: ClosedRange<Self>) {
		self = self.clamped(to: closedRange)
	}

    func clamped(to closedRange: ClosedRange<Self>) -> Self {
		return closedRange.clamp(self)
	}
}
