//
//  NSRange+String.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-12-19.
//  Copyright © 2020 SilverLogic. All rights reserved.
//

import Foundation

public extension NSRange {
    init(string: String) {
        self.init(string.startIndex..<string.endIndex, in: string)
    }
}

public extension String {
    var nsRange: NSRange {
        return NSRange(string: self)
    }
}
