//
//  WeakRef.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-10-08.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation

public final class WeakRef<T: AnyObject> {
    public private(set) weak var value: T?
    
    public init(_ value: T) {
        self.value = value
    }
}
