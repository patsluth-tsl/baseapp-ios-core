//
//  Font.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation

#if os(iOS) || os(watchOS) || os(tvOS)
public typealias Font = UIFont
public typealias FontDescriptor = UIFontDescriptor
#elseif os(macOS)
public typealias Font = NSFont
public typealias FontDescriptor = NSFontDescriptor
#endif

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
