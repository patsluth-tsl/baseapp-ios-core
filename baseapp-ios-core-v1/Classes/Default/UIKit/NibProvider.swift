//
//  NibProvider.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation
import UIKit

public protocol NibProvider {
    static var nib: UINib { get }
}

public extension UINib {
    typealias Provider = NibProvider
}

public extension UINib.Provider
where Self: UIView {
    @available(*, deprecated, renamed: "installNib")
    func installNibView() {
        installNib()
    }
    
    func installNib() {
        guard self.get(associatedObject: "nibProviderView", UIView.self) == nil else { return }
        guard let nibView = Self.nib.instantiate(withOwner: self, options: nil).first as? UIView else { return }
        
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
