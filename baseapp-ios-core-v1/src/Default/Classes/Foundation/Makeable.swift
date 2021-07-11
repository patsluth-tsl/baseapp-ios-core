//
//  Makeable+DateInRegion.swift
//  baseapp-ios-core-v1
//
//  Created by patsluth on 01/15/2020.
//  Copyright © 2020 SilverLogic. All rights reserved.
//

import Foundation
#if os(iOS)
import UIKit
#endif


public protocol Makeable: NSObjectProtocol {
    typealias MadeClosure = (Self) -> Void
    init()
}


extension NSObject: Makeable {  }


public extension Makeable {
    @discardableResult
    static func make(_ block: MadeClosure? = nil) -> Self {
        let made = Self()
        defer {
            block?(made)
        }
        return made
    }
}


#if os(iOS)


public extension Makeable
where Self: UIView {
    @discardableResult
    static func make(_ block: MadeClosure? = nil) -> Self {
        var made: Self! = nil
        if let nibProvider = Self.self as? (NibProvider & UIView).Type {
            // swiftlint:disable:next force_cast
            made = nibProvider.instantiate() as! Self
        } else {
            made = Self()
            made.translatesAutoresizingMaskIntoConstraints = false
        }
        defer {
            made.setNeedsUpdateConstraints()
            made.setNeedsLayout()
            block?(made)
        }
        return made
    }
}


public extension Makeable
where Self: UIButton {
    @discardableResult
    static func make(type: UIButton.ButtonType, _ block: MadeClosure? = nil) -> Self {
        let made = Self(type: type)
        made.translatesAutoresizingMaskIntoConstraints = false
        defer {
            block?(made)
        }
        return made
    }
}


public extension Makeable
where Self: UICollectionView {
    @discardableResult
    static func make<T>(layout: T, _ block: MadeClosure? = nil) -> Self
        where T: UICollectionViewLayout {
            let made = Self(frame: .zero, collectionViewLayout: layout)
            made.translatesAutoresizingMaskIntoConstraints = false
            defer {
                block?(made)
            }
            return made
    }
}


public extension Makeable
where Self: UIBarButtonItem {
    @discardableResult
    static func make(
        image: UIImage?,
        style: UIBarButtonItem.Style,
        _ block: MadeClosure? = nil
    ) -> Self {
        let made = Self(image: image, style: style, target: nil, action: nil)
        block?(made)
        return made
    }
    
    @discardableResult
    static func make(
        image: UIImage?,
        landscapeImagePhone: UIImage?,
        style: UIBarButtonItem.Style,
        _ block: MadeClosure? = nil
    ) -> Self {
        let made = Self(
            image: image,
            landscapeImagePhone: landscapeImagePhone,
            style: style,
            target: nil,
            action: nil
        )
        block?(made)
        return made
    }
    
    @discardableResult
    static func make(
        barButtonSystemItem systemItem: UIBarButtonItem.SystemItem,
        _ block: MadeClosure? = nil
    ) -> Self {
        let made = Self(barButtonSystemItem: systemItem, target: nil, action: nil)
        block?(made)
        return made
    }
    
    @discardableResult
    static func make(
        customView: UIView,
        _ block: MadeClosure? = nil
    ) -> Self {
        let made = Self(customView: customView)
        block?(made)
        return made
    }
}

#endif
