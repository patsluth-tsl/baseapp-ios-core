//
//  StoryboardResourceWithInitialControllerType.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-10-16.
//  Copyright © 2019 SilverLogic. All rights reserved.
//

#if os(iOS)

import PromiseKit
import Rswift
import UIKit

public extension StoryboardResourceWithInitialControllerType {
    @discardableResult
    func instantiateInitial(_ _viewController: ((InitialController) -> Void)? = nil) -> InitialController {
        let viewController = instantiateInitialViewController()!
        _viewController?(viewController)
        return viewController
    }
    
    func instantiateInitial() -> Guarantee<InitialController> {
        return Guarantee<InitialController>.value(instantiateInitial())
    }
}

public extension StoryboardResourceType {
    @discardableResult
    func instantiateResource<T>(
        _ _resource: (Self) -> StoryboardViewControllerResource<T>,
        _ _viewController: ((T) -> Void)? = nil
    ) -> T {
        let viewController = UIKit.UIStoryboard(resource: self)
            .instantiateViewController(withResource: _resource(self))!
        _viewController?(viewController)
        return viewController
    }
    
    func instantiateResource<T>(_ _resource: (Self) -> StoryboardViewControllerResource<T>) -> Guarantee<T> {
       return Guarantee<T>.value(instantiateResource(_resource))
    }
}

#endif
