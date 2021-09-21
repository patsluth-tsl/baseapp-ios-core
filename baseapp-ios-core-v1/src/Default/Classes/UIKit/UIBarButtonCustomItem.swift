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


public final class UIBarButtonCustomItem<T>: UIBarButtonItem
where T: UIView {
    public override var customView: UIView? {
        didSet {
            guard customView is T else {
                fatalError("customView must be type of \(T.self)")
            }
        }
    }
    
    public var custom: T! {
        return customView as? T
    }
    
    override init() {
        self.init(customView: T.make())
    }
    
    required init?(coder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
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
}

#endif
