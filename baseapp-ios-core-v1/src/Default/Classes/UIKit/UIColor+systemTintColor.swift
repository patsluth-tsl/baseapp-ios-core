//
//  UIColor+systemTintColor.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-11-02.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation
import UIKit
#if os(watchOS)
import WatchKit
#endif

public extension UIColor {
    static var systemTintColor: UIColor {
        #if os(iOS)
        return UIButton(type: .system).tintColor
        #elseif os(watchOS)
        return WKExtension.shared().globalTintColor
        #endif
	}
}
