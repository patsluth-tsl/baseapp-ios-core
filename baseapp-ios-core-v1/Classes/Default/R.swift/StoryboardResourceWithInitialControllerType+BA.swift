//
//  StoryboardResourceWithInitialControllerType.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-02-25.
//

import PromiseKit
import Rswift
import UIKit

public extension StoryboardResourceWithInitialControllerType {
    @discardableResult
    func instantiate(initial _viewController: (InitialController) -> Void) -> InitialController {
        let viewController = instantiateInitialViewController()!
        _viewController(viewController)
        return viewController
    }
    
    func instantiateInitial() -> Guarantee<InitialController> {
        return Guarantee<InitialController>(resolver: { resolver in
            self.instantiate(initial: {
                resolver($0)
            })
        })
    }
}

public extension StoryboardResourceType {
    func instantiate<T>(resource: (Self) -> StoryboardViewControllerResource<T>) -> Guarantee<T> {
        let viewController = UIKit.UIStoryboard(resource: self)
            .instantiateViewController(withResource: resource(self))!
        return Guarantee<T>(resolver: {
            $0(viewController)
        })
    }
}
