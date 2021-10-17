//
//  NSAttributedString.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-12-19.
//  Copyright © 2019 SilverLogic. All rights reserved.
//

import Foundation

public protocol NSAttributedStringConvertible {
    var attributed: NSAttributedString { get }
}

extension NSAttributedString: NSAttributedStringConvertible {
    public var attributed: NSAttributedString {
        return self
    }
}

extension String: NSAttributedStringConvertible {
    public var attributed: NSAttributedString {
        return NSAttributedString(string: self)
    }
    
    public func attributed(_ attributes: NSAttributedString.Attributes) -> NSAttributedString {
        return NSAttributedString(string: self, attributes: attributes)
    }
    
    public func attributed(
        _ attributesProvider: NSAttributedString.AttributesProvider
    ) -> NSAttributedString {
        return NSAttributedString(self, attributesProvider)
    }
}

public extension NSAttributedString {
    typealias Attributes = [NSAttributedString.Key: Any]
    typealias AttributesProvider = (inout Attributes) -> Void
    
    convenience init(_ string: String,
                     _ attributesProvider: AttributesProvider = { _ in }) {
        var attributes = Attributes()
        attributesProvider(&attributes)
        
        self.init(string: string, attributes: attributes)
    }
    
    
    
    static func + (lhs: NSAttributedString, rhs: NSAttributedString) -> NSAttributedString {
        let attributedString = NSMutableAttributedString()
        attributedString.append(lhs)
        attributedString.append(rhs)
        return attributedString as NSAttributedString
    }
    
    static func += (lhs: inout NSAttributedString, rhs: NSAttributedString) {
        lhs = lhs + rhs
    }
    
    static func + (lhs: NSAttributedString, rhs: String) -> NSAttributedString {
        return lhs + rhs.attributed
    }
    
    static func += (lhs: inout NSAttributedString, rhs: String) {
        lhs = lhs + rhs
    }
    
    static func + (lhs: String, rhs: NSAttributedString) -> String {
        return lhs + rhs.string
    }
    
    static func + (lhs: String, rhs: NSAttributedString) -> NSAttributedString {
        return lhs.attributed + rhs
    }
    
    static func += (lhs: inout String, rhs: NSAttributedString) {
        lhs = lhs + rhs
    }
}

public extension Collection
where Element == [NSAttributedStringConvertible] {
    
    func joined(by separator: NSAttributedStringConvertible) -> [NSAttributedStringConvertible] {
        return Array(joined(separator: [separator]))
    }
    
    func joined() -> [NSAttributedStringConvertible] {
        return Array(joined())
    }
}

public extension Collection
where Element == NSAttributedStringConvertible {
    func joined() -> NSAttributedString {
        reduce(into: NSMutableAttributedString(), {
            $0.append($1.attributed)
        }).attributed
    }
}

public extension Collection
where Element == String {
    func joined() -> String {
        reduce(into: "", {
            $0.append($1)
        })
    }
}

// Concats the lhs and rhs and returns a NSAttributedString
// infix operator + { associativity left precedence 140 }

// func +(left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
//    let result = NSMutableAttributedString()
//    result.appendAttributedString(left)
//    result.appendAttributedString(right)
//    return result
// }
//
// func +(left: String, right: NSAttributedString) -> NSAttributedString {
//    var range : NSRange? = NSMakeRange(0, 0)
//    let attributes = right.length > 0 ? right.attributesAtIndex(0, effectiveRange: &range!) : [:]
//
//    let result = NSMutableAttributedString()
//    result.appendAttributedString(NSAttributedString(string: left, attributes: attributes))
//
//    result.appendAttributedString(right)
//    return result
// }
//
// func +(left: NSAttributedString, right: String) -> NSAttributedString {
//    var range : NSRange? = NSMakeRange(0, 0)
//    let attributes = left.length > 0 ? left.attributesAtIndex(left.length - 1, effectiveRange: &range!) : [:]
//
//    let result = NSMutableAttributedString()
//    result.appendAttributedString(left)
//    result.appendAttributedString(NSAttributedString(string:right, attributes: attributes))
//    return result
// }
//
// Concats the lhs and rhs and assigns the result to the lhs
// infix operator += { associativity right precedence 90 }
//
// func +=(inout left: NSMutableAttributedString, right: String) -> NSMutableAttributedString {
//    left.appendAttributedString(right.attributedString)
//    return left
// }
//
// func +=(inout left: NSAttributedString, right: String) -> NSAttributedString {
//    left = left + right
//    return left
// }
//
// func +=(inout left: NSAttributedString, right: NSAttributedString) -> NSAttributedString {
//    left = left + right
//    return left
// }
//
// func +=(inout left: NSAttributedString, right: NSAttributedString?) -> NSAttributedString {
//    guard let rhs = right else { return left }
//    return left += rhs
// }
//
// Applies the attributes on the rhs to the string on the lhs
// infix operator && { associativity left precedence 150 }
//
// func &&(left: String, right: [String: AnyObject]) -> NSAttributedString {
//    let result = NSAttributedString(string: left, attributes: right)
//    return result
// }
//
// func &&(left: String, right: UIFont) -> NSAttributedString {
//    let result = NSAttributedString(string: left, attributes: [NSFontAttributeName: right])
//    return result
// }
//
// func &&(left: String, right: UIColor) -> NSAttributedString {
//    let result = NSAttributedString(string: left, attributes: [NSForegroundColorAttributeName: right])
//    return result
// }
//
// func &&(left: NSAttributedString, right: UIColor) -> NSAttributedString {
//    let result = NSMutableAttributedString(attributedString: left)
//    result.addAttributes([NSForegroundColorAttributeName: right], range: NSMakeRange(0, result.length))
//    return result
// }
//
// func &&(left: NSAttributedString, right: [String: AnyObject]) -> NSAttributedString {
//    let result = NSMutableAttributedString(attributedString: left)
//    result.addAttributes(right, range: NSMakeRange(0, result.length))
//    return result
// }

@resultBuilder
public struct NSAttributedStringBuilder {
    public static func buildBlock(
        _ strings: NSAttributedStringConvertible...
    ) -> [NSAttributedStringConvertible] {
        return strings
    }
}

public extension NSAttributedString {
    public convenience init(
    @NSAttributedStringBuilder _ content: () -> [NSAttributedStringConvertible],
    joined separator: NSAttributedStringConvertible? = nil
    ) {
        if let sep = separator {
            self.init(attributedString: content().map({ [$0] }).joined(by: sep).joined())
        } else {
            self.init(attributedString: content().joined())
        }
    }
}


@resultBuilder
public struct StringBuilder {
    public static func buildBlock(
        _ strings: String...
    ) -> [String] {
        return strings
    }
}


public extension String {
    public init(
    @StringBuilder _ content: () -> [String],
    joined separator: String? = nil
    ) {
        if let sep = separator {
            self = content().joined(by: sep)
        } else {
            self = content().joined()
        }
    }
}

