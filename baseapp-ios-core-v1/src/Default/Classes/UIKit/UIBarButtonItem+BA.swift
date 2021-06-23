//
//  UICollectionView.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-10-16.
//  Copyright © 2019 SilverLogic. All rights reserved.
//

import Foundation

#if os(iOS)

// MARK: - Init Helpers
public extension UIBarButtonItem {
    convenience init(image: UIImage?,
                     style: UIBarButtonItem.Style) {
        self.init(image: image,
                  style: style,
                  target: nil,
                  action: nil)
    }
    
    // swiftlint:disable:next deployment_target
    @available(iOS 5.0, *)
    convenience init(image: UIImage?,
                     landscapeImagePhone: UIImage?,
                     style: UIBarButtonItem.Style) {
        self.init(image: image,
                  landscapeImagePhone: landscapeImagePhone,
                  style: style,
                  target: nil,
                  action: nil)
    }
    
    convenience init(title: String?,
                     style: UIBarButtonItem.Style) {
        self.init(title: title,
                  style: style,
                  target: nil,
                  action: nil)
    }
    
    convenience init(systemItem: UIBarButtonItem.SystemItem) {
        self.init(barButtonSystemItem: systemItem,
                  target: nil,
                  action: nil)
    }
}

#endif
