//
//  UIViewController+presentation.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-10-16.
//  Copyright © 2019 SilverLogic. All rights reserved.
//

import UIKit

#if os(iOS)


public extension NSObjectProtocol
where Self: UIViewController {
    @discardableResult
    func present(from vc: UIViewController) -> Self {
        return self.present(from: vc, animated: true, { _ in })
    }
    
    @discardableResult
    func present(from vc: UIViewController,
                 _ completion: @escaping (Self) -> Void) -> Self {
        return self.present(from: vc, animated: true, completion)
    }
    
    @discardableResult
    func present(from vc: UIViewController,
                 animated: Bool,
                 _ completion: @escaping (Self) -> Void) -> Self {
        if let presentedVC = vc.presentedViewController {
            if type(of: presentedVC) == type(of: self) {
                // continue
            } else {
                self.present(from: presentedVC, animated: animated, completion)
            }
            return self
        }
        
        vc.present(self, animated: animated, completion: {
            completion(self)
        })
        
        return self
    }
    
    @available(iOS 8.0, *)
    @discardableResult
    func show(from vc: UIViewController, sender: Any? = nil) -> Self {
        if let nc = vc.navigationController, vc !== nc.viewControllers.last {
            return self
        }
        
        vc.show(self, sender: sender)
        
        return self
    }
    
    @available(iOS 8.0, *)
    @discardableResult
    func showDetail(from vc: UIViewController, sender: Any? = nil) -> Self {
        vc.showDetailViewController(self, sender: sender)
        
        return self
    }
}

#endif
