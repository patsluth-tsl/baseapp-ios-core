//
//  SnapKit+BA.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-02-25.
//  Copyright © 2019 SilverLogic. All rights reserved.
//

#if os(iOS)

import SnapKit
import UIKit

extension NSObjectProtocol
where Self: UIView {
    @discardableResult
    public func make(constraints block: (ConstraintMaker) -> Void) -> Self {
        snp.makeConstraints({
            block($0)
        })
        return self
    }
    
    @discardableResult
    public func make(constraints block: (ConstraintMaker, Self) -> Void) -> Self {
        snp.makeConstraints({
            block($0, self)
        })
        return self
    }
    
    @discardableResult
    public func remake(constraints block: (ConstraintMaker) -> Void) -> Self {
        snp.remakeConstraints({
            block($0)
        })
        return self
    }
    
    @discardableResult
    public func remake(constraints block: (ConstraintMaker, Self) -> Void) -> Self {
        snp.remakeConstraints({
            block($0, self)
        })
        return self
    }
    
    @discardableResult
    public func update(constraints block: (ConstraintMaker) -> Void) -> Self {
        snp.updateConstraints({
            block($0)
        })
        return self
    }
    
    @discardableResult
    public func update(constraints block: (ConstraintMaker, Self) -> Void) -> Self {
        snp.updateConstraints({
            block($0, self)
        })
        return self
    }
}


extension NSObjectProtocol
where Self: UILayoutGuide {
    @discardableResult
    public func make(constraints block: (ConstraintMaker) -> Void) -> Self {
        snp.makeConstraints({
            block($0)
        })
        return self
    }
    
    @discardableResult
    public func make(constraints block: (ConstraintMaker, Self) -> Void) -> Self {
        snp.makeConstraints({
            block($0, self)
        })
        return self
    }
    
    @discardableResult
    public func remake(constraints block: (ConstraintMaker) -> Void) -> Self {
        snp.remakeConstraints({
            block($0)
        })
        return self
    }
    
    @discardableResult
    public func remake(constraints block: (ConstraintMaker, Self) -> Void) -> Self {
        snp.remakeConstraints({
            block($0, self)
        })
        return self
    }
    
    @discardableResult
    public func update(constraints block: (ConstraintMaker) -> Void) -> Self {
        snp.updateConstraints({
            block($0)
        })
        return self
    }
    
    @discardableResult
    public func update(constraints block: (ConstraintMaker, Self) -> Void) -> Self {
        snp.updateConstraints({
            block($0, self)
        })
        return self
    }
}

#endif
