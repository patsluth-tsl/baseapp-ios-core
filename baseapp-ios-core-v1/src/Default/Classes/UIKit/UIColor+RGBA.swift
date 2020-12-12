//
//  UIColor+RGBA.swift
//  BaseApp
//
//  Created by Pat Sluth on 2017-11-02.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
	/**
	Red, Green, Blue, Alpha
	*/
    struct RGBA: Codable, ReflectedStringConvertible {
		var r: CGFloat
		var g: CGFloat
		var b: CGFloat
		var a: CGFloat
		
		public var uiColor: UIColor {
            return UIColor(
                red: (0.0...1.0).clamp(r),
                green: (0.0...1.0).clamp(g),
                blue: (0.0...1.0).clamp(b),
                alpha: (0.0...1.0).clamp(a)
            )
		}
	}
    
    func getRGBA() throws -> RGBA {
		var rgba = RGBA(r: 0.0, g: 0.0, b: 0.0, a: 0.0)
		
		if !getRed(&rgba.r, green: &rgba.g, blue: &rgba.b, alpha: &rgba.a) {
			throw Errors.Message("\(#function) failed")
		}
		
		return rgba
	}
}
