//
//  NSObjectProtocol+AssociatedObject.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2018-10-27.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

public extension NSObjectProtocol {
    func get<T>(associatedObject named: String,
                _ type: T.Type) -> T? {
        let key = UnsafeRawPointer(bitPattern: named.hash)!
        
        return objc_getAssociatedObject(self, key) as? T
    }
    
    func set<T>(associatedObject named: String,
                object: T?,
                policy: objc_AssociationPolicy = .OBJC_ASSOCIATION_RETAIN_NONATOMIC) {
        let key = UnsafeRawPointer(bitPattern: named.hash)!
        
        objc_setAssociatedObject(self, key, object, policy)
    }
}
