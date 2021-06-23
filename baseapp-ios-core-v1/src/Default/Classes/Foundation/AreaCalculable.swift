//
//  AreaCalculable.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-10-08.
//  Copyright © 2017 SilverLogic. All rights reserved.
//

import Foundation

public protocol AreaCalculable {
    associatedtype ComponentType: SignedNumeric
    var width: ComponentType { get }
    var height: ComponentType { get }
}

public extension AreaCalculable {
    var area: ComponentType {
        return self.width * self.height
    }
}
