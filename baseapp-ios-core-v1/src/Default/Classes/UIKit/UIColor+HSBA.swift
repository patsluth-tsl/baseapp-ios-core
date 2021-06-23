//
//  UIColor+HSBA.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-11-02.
//  Copyright © 2017 SilverLogic. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
	/**
	Hue, Saturation, Brightness, Alpha
	*/
    struct HSBA: Codable, ReflectedStringConvertible {
		var h: CGFloat
		var s: CGFloat
		var b: CGFloat
		var a: CGFloat
		
		public var uiColor: UIColor {
            return UIColor(
                hue: h,
                saturation: s,
                brightness: b,
                alpha: a
            )
		}
	}
    
    func getHSBA() throws -> HSBA {
		var hsba = HSBA(h: 0.0, s: 0.0, b: 0.0, a: 0.0)
		if !getHue(&hsba.h, saturation: &hsba.s, brightness: &hsba.b, alpha: &hsba.a) {
			throw Errors.Message("\(#function) failed")
		}
		
		return hsba
	}
}
