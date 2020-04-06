//
//  Runtime.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2018-10-20.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation

public enum Runtime {
	public enum Errors: Error {
		case Swizzle(Selector)
	}
    
    public static func swizzle(
        class _class: AnyClass!,
        _ originalSelector: Selector,
        _ swizzledSelector: Selector) throws {
        guard let _class = _class else { return }
        guard let originalMethod = class_getInstanceMethod(_class, originalSelector) else {
            throw Runtime.Errors.Swizzle(originalSelector)
        }
        guard let swizzledMethod = class_getInstanceMethod(_class, swizzledSelector) else {
            throw Runtime.Errors.Swizzle(swizzledSelector)
        }
        
        let didAddMethod = class_addMethod(_class,
                                           originalSelector,
                                           method_getImplementation(swizzledMethod),
                                           method_getTypeEncoding(swizzledMethod))
        
        if didAddMethod {
            class_replaceMethod(_class,
                                swizzledSelector,
                                method_getImplementation(originalMethod),
                                method_getTypeEncoding(originalMethod))
        } else {
            method_exchangeImplementations(originalMethod, swizzledMethod)
        }
    }
    
    public static func swizzle<T>(
        _ type: T.Type,
        _ originalSelector: Selector,
        _ swizzledSelector: Selector) throws where T: AnyObject {
        try Runtime.swizzle(class: T.self, originalSelector, swizzledSelector)
//        guard let originalMethod = class_getInstanceMethod(T.self, originalSelector) else {
//            throw Runtime.Errors.Swizzle(originalSelector)
//        }
//        guard let swizzledMethod = class_getInstanceMethod(T.self, swizzledSelector) else {
//            throw Runtime.Errors.Swizzle(swizzledSelector)
//        }
//
//        let didAddMethod = class_addMethod(T.self,
//                                           originalSelector,
//                                           method_getImplementation(swizzledMethod),
//                                           method_getTypeEncoding(swizzledMethod))
//
//        if didAddMethod {
//            class_replaceMethod(T.self,
//                                swizzledSelector,
//                                method_getImplementation(originalMethod),
//                                method_getTypeEncoding(originalMethod))
//        } else {
//            method_exchangeImplementations(originalMethod, swizzledMethod)
//        }
	}
}
