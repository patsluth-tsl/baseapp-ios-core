//
//  SCNNode+Actions.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-10-18.
//  Copyright © 2017 Apple. All rights reserved.
//

import Foundation
import SceneKit

public extension SCNNode {
    func removeAllActions() {
        guard hasActions else { return }
        actionKeys.forEach({ actionKey in
            removeAction(forKey: actionKey)
        })
    }
}
