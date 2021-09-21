//
//  UIBarButtonCustomItem.swift
//  baseapp-ios-core-v1
//
//  Created by patsluth on 01/15/2021.
//  Copyright © 2021 SilverLogic. All rights reserved.
//

import Foundation
#if os(iOS)
import UIKit


open class UIBarButtonCustomItem<T>: UIBarButtonItem
where T: UIView {
    public override var customView: UIView? {
        didSet {
            guard let _ = customView as? T else {
                fatalError("customView must be type of \(T.self)")
            }
        }
    }
    
    public var custom: T! {
        return customView as? T
    }
    
    public override init() {
        super.init()
        defer {
            customView = (customView as? T) ?? T.make()
        }
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        defer {
            customView = (customView as? T) ?? T.make()
        }
    }
}


// MARK: - Makeable
public extension UIBarButtonCustomItem {
    typealias CompoundMadeClosure = (UIBarButtonCustomItem<T>, T) -> Void
    
    @discardableResult
    static func make(
        _ block: CompoundMadeClosure? = nil
    ) -> Self {
        return Self.make(customView: T.make(), {
            block?($0, $0.custom)
        })
    }
}


public extension UIBarButtonItem {
    @discardableResult
    static func make<T>(
        custom type: T.Type,
        _ block: UIBarButtonCustomItem<T>.MadeClosure? = nil
    ) -> UIBarButtonCustomItem<T> {
        return UIBarButtonCustomItem<T>.make(block)
    }
    
    @discardableResult
    static func make<T>(
        custom type: T.Type,
        _ block: UIBarButtonCustomItem<T>.CompoundMadeClosure? = nil
    ) -> UIBarButtonCustomItem<T> {
        return UIBarButtonCustomItem<T>.make(block)
    }
}

#endif
