//
//  FloatingPointType+Exponent.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-08-08.
//  Copyright © 2017 SilverLogic. All rights reserved.
//

import CoreGraphics
import Foundation

precedencegroup ExponentPrecedence {
    associativity: right
    higherThan: MultiplicationPrecedence
}

infix operator ^^: ExponentPrecedence

public func ^^<B, E>(base: B, exponent: E) -> B
    where B: FloatingPointType, E: FloatingPointType {
    return B(pow(Double(base), Double(exponent)))
}

public func ^^<B, E>(base: B, exponent: E) -> B
    where B: FloatingPointType, E: IntegerType {
    return base ^^ B(exponent)
}

public func ^^<B, E>(base: B, exponent: E) -> B
    where B: IntegerType, E: IntegerType {
    return B(Double(base) ^^ exponent)
}
