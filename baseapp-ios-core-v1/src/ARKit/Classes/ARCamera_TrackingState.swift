//
//  ARCamera.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-10-18.
//  Copyright © 2017 Apple. All rights reserved.
//

import ARKit
import Foundation

@available(iOS 11.0, *)
public extension ARCamera.TrackingState {
    static func == (lhs: Self, rhs: Self) -> Bool {
        switch (lhs, rhs) {
        case (.notAvailable, .notAvailable):
            return true
        case (.limited(let reasonA), .limited(let reasonB)):
            return reasonA == reasonB
        case (.normal, .normal):
            return true
        default:
            return false
        }
    }
}
