//
//  NibProvider.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation
import UIKit

#if os(iOS)

public extension UINib {
    public enum InstantiationType {
        case firstView
        case fileOwner
    }
}

public protocol NibProvider {
    static var nib: UINib { get }
    static var instantiation: UINib.InstantiationType { get }
}

// MARK: - Defaults
public extension NibProvider
where Self: UIView {
    static var instantiation: UINib.InstantiationType {
        .firstView
    }
}

public extension NibProvider
where Self: UIViewController {
    static var instantiation: UINib.InstantiationType {
        .fileOwner
    }
}

public extension UINib {
    typealias Provider = NibProvider
}

public extension UINib.Provider
where Self: UIView {
    static func instantiate(
        _ instantiation: UINib.InstantiationType = Self.instantiation
    ) -> Self {
        var _self: Self!
        switch instantiation {
        case .firstView:
            _self = Self.nib.instantiate(withOwner: nil, options: nil).compactMap({
                $0 as? Self
            }).first ?? Self()
        case .fileOwner:
            _self = Self()
            _self.translatesAutoresizingMaskIntoConstraints = false
            _self.installNib()
        }
        return _self
    }
    
    @available(*, deprecated, renamed: "installNib")
    func installNibView() {
        installNib()
    }
    
    func installNib() {
        guard self.get(associatedObject: "nibProviderView", UIView.self) == nil else { return }
        guard let nibView = Self.nib.instantiate(
            withOwner: self,
            options: nil
        ).first as? UIView else { return }
        
        setNeedsLayout()
        
        set(associatedObject: "nibProviderView", object: nibView)
        nibView.translatesAutoresizingMaskIntoConstraints = false
        backgroundColor = nibView.backgroundColor
        nibView.backgroundColor = UIColor.clear
        addSubview(nibView)
        
        NSLayoutConstraint.activate([
            nibView.topAnchor.constraint(equalTo: topAnchor),
            nibView.leftAnchor.constraint(equalTo: leftAnchor),
            nibView.rightAnchor.constraint(equalTo: rightAnchor),
            nibView.bottomAnchor.constraint(equalTo: bottomAnchor)
        ])
        
        nibView.setNeedsLayout()
    }
}

#endif
