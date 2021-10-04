//
//  Measurement+BA.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-10-08.
//  Copyright © 2017 SilverLogic. All rights reserved.
//

import Foundation

public func floor<U: Unit>(_ m: Measurement<U>) -> Measurement<U> {
    return Measurement<U>(value: Darwin.floor(m.value), unit: m.unit)
}

public func ceil<U: Unit>(_ m: Measurement<U>) -> Measurement<U> {
    return Measurement<U>(value: Darwin.ceil(m.value), unit: m.unit)
}

public extension Measurement where UnitType: Dimension {
    func rounded(toNearest unit: UnitType) -> Measurement<UnitType> {
        var _measurement = self.converted(to: unit)
        _measurement.value = Darwin.round(_measurement.value)
        _measurement.convert(to: self.unit)
        return _measurement
    }
    
    mutating func round(toNearest unit: UnitType) {
        self = self.rounded(toNearest: unit)
    }
}
