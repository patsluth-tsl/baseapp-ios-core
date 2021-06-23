//
//  Font.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 SilverLogic. All rights reserved.
//

import CoreGraphics
import Foundation
import UIKit

#if os(iOS) || os(tvOS)
public typealias Font = UIFont
public typealias FontDescriptor = UIFontDescriptor
#elseif os(macOS)
public typealias Font = NSFont
public typealias FontDescriptor = NSFontDescriptor
#endif

#if os(iOS) || os(tvOS) || os(macOS)

public extension Font {
    func scaledBy(percent: CGFloat) -> Font! {
        return withSize(pointSize * percent)
    }
    
    func withSize(_ fontSize: CGFloat) -> Font! {
        return Font(descriptor: fontDescriptor, size: fontSize)
    }
    
    func with(traits: FontDescriptor.SymbolicTraits) -> Font? {
        #if os(macOS)
        let fontDescriptor = self.fontDescriptor.withSymbolicTraits(traits)
        return Font(descriptor: fontDescriptor, size: pointSize)
        #else
        if let fontDescriptor = self.fontDescriptor.withSymbolicTraits(traits) {
            return Font(descriptor: fontDescriptor, size: pointSize)
        }
        return nil
        #endif
    }
}
#endif
