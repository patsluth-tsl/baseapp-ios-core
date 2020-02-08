//
//  StoryboardResourceWithInitialControllerType.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-02-25.
//

import Rswift
import UIKit

public extension StoryboardResourceWithInitialControllerType {
    func instantiate(initial viewController: (InitialController) -> Void) {
        guard let initialViewController = self.instantiateInitialViewController() else { return }
        viewController(initialViewController)
    }
}
