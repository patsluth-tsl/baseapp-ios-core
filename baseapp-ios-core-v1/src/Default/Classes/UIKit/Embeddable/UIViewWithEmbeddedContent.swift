//
//  UIViewWithEmbeddedContent.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-03-01.
//  Copyright © 2019 SilverLogic. All rights reserved.
//

import UIKit

#if os(iOS)

public protocol UIViewWithEmbeddedContent: UIView {
	associatedtype Embedded: UIView
    
	var embedded: Embedded! { get }
}

extension UIViewWithEmbeddedContent where Embedded: ModelConsumer {
	public typealias Model = Embedded.Model

	public var model: Embedded.Model! {
		get { return embedded.model }
		set { embedded.model = newValue }
	}
}

#endif
