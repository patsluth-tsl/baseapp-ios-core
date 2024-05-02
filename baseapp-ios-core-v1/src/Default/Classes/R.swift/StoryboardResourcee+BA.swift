//
//  StoryboardResourceWithInitialControllerType.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-10-16.
//  Copyright © 2019 SilverLogic. All rights reserved.
//

#if os(iOS)

import PromiseKit
import RswiftResources
import UIKit

public extension StoryboardReference where Self: RswiftResources.InitialControllerContainer {
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

public extension StoryboardReference {
    @discardableResult
    func instantiateResource<T>(
        _ _resource: (Self) -> StoryboardViewControllerIdentifier<T>,
        _ _viewController: ((T) -> Void)? = nil
    ) -> T
    where T: UIViewController {
        let viewController = UIKit.UIStoryboard(resource: self)
            .instantiateViewController(withIdentifier: _resource(self))!
        _viewController?(viewController)
        return viewController
    }
    
    func instantiateResource<T>(
        _ _resource: (Self) -> StoryboardViewControllerIdentifier<T>
    ) -> Guarantee<T>
    where T: UIViewController {
       return Guarantee<T>.value(instantiateResource(_resource))
    }
}

#endif
