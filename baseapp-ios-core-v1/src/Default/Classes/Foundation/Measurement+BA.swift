//
//  Measurement+BA.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-10-08.
//  Copyright © 2017 SilverLogic. All rights reserved.
//

import Foundation

public func floor<U: Unit>(_ measurement: Measurement<U>) -> Measurement<U> {
    return Measurement<U>(value: Darwin.floor(measurement.value), unit: measurement.unit)
}

public func ceil<U: Unit>(_ measurement: Measurement<U>) -> Measurement<U> {
    return Measurement<U>(value: Darwin.ceil(measurement.value), unit: measurement.unit)
}
