//
//  SCNNode+Constraints.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-10-16.
//  Copyright © 2019 SilverLogic. All rights reserved.
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
