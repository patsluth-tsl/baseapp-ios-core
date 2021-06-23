//
//  Error.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2018-10-20.
//  Copyright © 2018 SilverLogic. All rights reserved.
//

import Foundation

public extension Error {
    var ns: NSError {
        return self as NSError
    }
}
