//
//  Range+clamp.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 SilverLogic. All rights reserved.
//

import Foundation

public extension Comparable {
    mutating func clamp<R: RangeClamp>(to range: R)
    where R.B == Self {
        self = self.clamped(to: range)
    }
    
    func clamped<R: RangeClamp>(to range: R) -> Self
    where R.B == Self {
        return range.clamp(self)
    }
}
