//
//  ARCamera.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-10-16.
//  Copyright © 2019 SilverLogic. All rights reserved.
//

import ARKit
import Foundation

@available(iOS 11.0, *)
public extension ARCamera.TrackingState {
    static func == (lhs: Self, rhs: Self) -> Bool {
        return ARCamera.TrackingState.isEqual(lhs, rhs)
    }
    
    static func isEqual(_ lhs: Self, _ rhs: Self) -> Bool {
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
