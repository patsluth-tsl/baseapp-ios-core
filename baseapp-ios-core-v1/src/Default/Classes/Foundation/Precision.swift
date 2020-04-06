//
//  Precision.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2018-06-20.
//  Copyright © 2018 patsluth. All rights reserved.
//

import Foundation

public protocol Precision: Equatable {
    func withPrecision(_ decimalPlaces: UInt) -> Self
    func isEqual(to: Self, withPrecision decimalPlaces: UInt) -> Bool
}

public extension Precision {
    mutating func precise(_ decimalPlaces: UInt) {
        self = self.withPrecision(decimalPlaces)
    }
}
