//
//  UITintedLabell.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-12-19.
//  Copyright © 2017 SilverLogic. All rights reserved.
//

#if os(iOS)

/// A `UILabel` subclass that automatically adjusts it's text color to the tintColor
public class UITintedLabel: UILabel {
	override public func tintColorDidChange() {
		super.tintColorDidChange()
		textColor = tintColor
	}
}

#endif
