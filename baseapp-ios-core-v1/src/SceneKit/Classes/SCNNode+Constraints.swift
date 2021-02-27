//
//  SCNNode+Constraints.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-10-18.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import SceneKit

public extension SCNNode {
    func addConstraint(_ constraint: SCNConstraint) {
        if constraints == nil {
            constraints = [constraint]
        } else {
            constraints!.append(constraint)
        }
    }
    
    func removeConstraint(_ constraint: SCNConstraint) {
        if let index = constraints?.firstIndex(of: constraint) {
            constraints?.remove(at: index)
        }
        if constraints?.isEmpty ?? false {
            constraints = nil
        }
    }
    
    func removeAllConstraints() {
        constraints?.removeAll()
    }
}
