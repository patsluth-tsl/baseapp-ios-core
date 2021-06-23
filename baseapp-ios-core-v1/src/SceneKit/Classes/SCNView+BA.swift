//
//  SCNView+BA.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-10-16.
//  Copyright © 2019 SilverLogic. All rights reserved.
//

import Foundation
import SceneKit

public extension SCNView {
    /// Return the `pointOfView` or fatalError
    var pointOfViewUnsafe: SCNNode {
        guard let pov = pointOfView else {
            fatalError("Expected a valid `pointOfView` from the scene.")
        }
        return pov
    }
    
    /// Return the `pointOfView.camera` or fatalError
    var cameraUnsafe: SCNCamera {
        guard let camera = pointOfViewUnsafe.camera else {
            fatalError("Expected a valid `camera` from the scene.")
        }
        return camera
    }
    
    ///
    /// Safe access to cached `bounds` on any thread.
    /// Will be null initially
    ///
    var boundsThreadSafe: CGRect {
        if Thread.isMainThread {
            set(associatedObject: "boundsThreadSafe", object: bounds, policy: .OBJC_ASSOCIATION_COPY)
            return bounds
        }
        DispatchQueue.main.async(execute: { [weak self] in
            _ = self?.boundsThreadSafe
        })
        return self.get(associatedObject: "boundsThreadSafe", CGRect.self) ?? CGRect.null
    }
}
