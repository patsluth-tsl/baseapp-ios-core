//
//  FloatingPointType.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-08-08.
//  Copyright © 2017 patsluth. All rights reserved.
//

import CoreGraphics
import Foundation

public protocol FloatingPointType: BinaryFloatingPoint, Precision {
    init(_ value: Float)
    init(_ value: Double)
    init(_ value: CGFloat)
    
    func cast<T: FloatingPointType>() -> T
}

public extension FloatingPointType {
    func withPrecision(_ decimalPlaces: UInt) -> Self {
        let offset: Self = 10^^decimalPlaces
        return ((self * offset).rounded() / offset)
    }
    
    func isEqual(to: Self, withPrecision decimalPlaces: UInt) -> Bool {
        return self.withPrecision(decimalPlaces)
            .isEqual(to: to.withPrecision(decimalPlaces))
    }
}

extension Float: FloatingPointType { public func cast<T: FloatingPointType>() -> T { return T(self) } }
extension Double: FloatingPointType { public func cast<T: FloatingPointType>() -> T { return T(self) } }
extension CGFloat: FloatingPointType { public func cast<T: FloatingPointType>() -> T { return T(self) } }

public extension FloatingPointType {
    init<I>(_ integer: I)
    where I: IntegerType {
        self.init(integer)
    }
    
    //    func to(thePower exponent: T) -> Self
    //    {
    //        return Self(pow(Double(self), Double(power)))
    //    }
}

//    static func +<R>(lhs: Self, rhs: R) -> Self
//        where R: FloatingPointType
//    {
//        return lhs + Self(rhs)
//    }
//
//    static func +<R>(lhs: Self, rhs: R) -> R
//        where R: FloatingPointType
//    {
//        return R(lhs) + rhs
//    }
//
//    static func +=<R>(lhs: inout Self, rhs: R)
//        where R: FloatingPointType
//    {
//        lhs = lhs + rhs
//    }
//
//
//
//    static func -<R>(lhs: Self, rhs: R) -> Self
//        where R: FloatingPointType
//    {
//        return lhs - Self(rhs)
//    }
//
//    static func -<R>(lhs: Self, rhs: R) -> R
//        where R: FloatingPointType
//    {
//        return R(lhs) - rhs
//    }
//
//    static func -=<R>(lhs: inout Self, rhs: R)
//        where R: FloatingPointType
//    {
//        lhs = lhs - rhs
//    }
//
//
//
//    static func *<R>(lhs: Self, rhs: R) -> Self
//        where R: FloatingPointType
//    {
//        return lhs * rhs
//    }
//
//    static func *<R>(lhs: Self, rhs: R) -> R
//        where R: FloatingPointType
//    {
//        return R(lhs) * rhs
//    }
//
//    static func *=<R>(lhs: inout Self, rhs: R)
//        where R: FloatingPointType
//    {
//        lhs = lhs * rhs
//    }
//
//
//
//    static func /<R>(lhs: Self, rhs: R) -> Self
//        where R: FloatingPointType
//    {
//        return lhs / rhs
//    }
//
//    static func /<R>(lhs: Self, rhs: R) -> R
//        where R: FloatingPointType
//    {
//        return R(lhs) / rhs
//    }
//
//    static func /=<R>(lhs: inout Self, rhs: R)
//        where R: FloatingPointType
//    {
//        lhs = lhs / rhs
//    }
//}

//public extension Float
//{
//    public init<T: FloatingPointType>(_ value: T)
//    {
//        let _value: Float = value.to()
//        self.init(_value)
//    }
//}
//
//public extension Double
//{
//    public init<T: FloatingPointType>(_ value: T)
//    {
//        let _value: Double = value.to()
//        self.init(_value)
//    }
//}
//
//public extension CGFloat
//{
//    public init<T: FloatingPointType>(_ value: T)
//    {
//        let _value: CGFloat = value.to()
//        self.init(_value)
//    }
//}


public extension FloatingPointType {
    func value(percentageBetween min: Self, and max: Self) -> Self {
        return ((self * (max - min)) + min)
    }
    
    func percentage(between min: Self, and max: Self) -> Self {
        return ((self - min) / (max - min))
    }
    
    func rounded(to places: Int) -> Self {
        let divisor = Self(pow(10.0, Double(places)))
        return (self * divisor).rounded() / divisor
    }
}


public extension FloatingPointType {
    public typealias Parts = (integer: Int, decimal: Self)
    
    var parts: Parts {
        return Parts(integer: Int(floor(self)),
                     decimal: truncatingRemainder(dividingBy: 1.0))
    }
}


public extension FloatingPointType {
    func measurement<UnitType>(
        _ unit: UnitType
    ) -> Measurement<UnitType> where UnitType: Unit {
        
        return Measurement(value: self.cast(), unit: unit)
    }
}
