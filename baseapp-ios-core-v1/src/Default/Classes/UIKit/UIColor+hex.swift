//
//  UIColor+hex.swift
//  BaseApp
//
//  Created by Pat Sluth on 2017-07-25.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation
import UIKit

public extension UIColor {
    @objc convenience init(hex: String!) {
        var hex = hex ?? "FFFFFF"
        
        if hex.prefix(1) == "#" {
            hex.removeFirst(1)
        }
        if hex.prefix(2).lowercased() == "0x" {
            hex.removeFirst(2)
        }
        if hex.count == 6 {
            hex.append("FF")
        }
        
        let hexValue: UInt64 = {
            var hexValue: UInt64 = 0
            let scanner = Scanner(string: hex)
            scanner.scanLocation = 0
            scanner.scanHexInt64(&hexValue)
            return hexValue
        }()
        
        //        if hex.count == 8 {
        ////            let r = CGFloat((hexValue & 0xFF000000) >> 24) / 0xFF
        ////            let g = CGFloat((hexValue & 0x00FF0000) >> 16) / 0xFF
        ////            let b = CGFloat((hexValue & 0x0000FF00) >> 08) / 0xFF
        ////            let a = CGFloat((hexValue & 0x000000FF) >> 00) / 0xFF
        ////
        ////            self.init(red: r, green: g, blue: b, alpha: a)
        //        } else {
        //            return nil
        //        }
        self.init(hexValue: UInt(hexValue))
    }
    
    @objc convenience init(hexValue: UInt) {
        switch hexValue {
        case (0...0xFFFFFF):
            self.init(
                red: CGFloat((hexValue & 0xFF0000) >> 16) / 0xFF,
                green: CGFloat((hexValue & 0x00FF00) >> 8) / 0xFF,
                blue: CGFloat((hexValue & 0x0000FF) >> 0) / 0xFF,
                alpha: 1.0
            )
        default:
            self.init(
                red: CGFloat((hexValue & 0xFF000000) >> 24) / 0xFF,
                green: CGFloat((hexValue & 0x00FF0000) >> 16) / 0xFF,
                blue: CGFloat((hexValue & 0x0000FF00) >> 8) / 0xFF,
                alpha: CGFloat((hexValue & 0x000000FF) >> 0) / 0xFF
            )
        }
    }
    
    @objc func toHex() -> String {
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        return String(format: "0x%02X%02X%02X%02X",
                      UInt8(r * 0xFF),
                      UInt8(g * 0xFF),
                      UInt8(b * 0xFF),
                      UInt8(a * 0xFF)
        )
    }
    
    @objc func toHexValue() -> UInt {
        var r: CGFloat = 0.0
        var g: CGFloat = 0.0
        var b: CGFloat = 0.0
        var a: CGFloat = 0.0
        
        self.getRed(&r, green: &g, blue: &b, alpha: &a)
        
        let float0xFF = CGFloat(0xFF)
        return
            (UInt((r * float0xFF)) << 24) +
                (UInt((g * float0xFF)) << 16) +
                (UInt((b * float0xFF)) << 8) +
                (UInt((a * float0xFF)) << 0)
    }
}
