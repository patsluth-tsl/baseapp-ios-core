//
//  UIView+Constraints.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-12-02.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import UIKit

public extension UIView {
	var safeTopAnchor: NSLayoutYAxisAnchor {
		if #available(iOS 11.0, *) {
			return self.safeAreaLayoutGuide.topAnchor
		} else {
			return self.topAnchor
		}
	}
	
	var safeLeftAnchor: NSLayoutXAxisAnchor {
		if #available(iOS 11.0, *) {
			return self.safeAreaLayoutGuide.leftAnchor
		} else {
			return self.leftAnchor
		}
	}
	
	var safeLeadingAnchor: NSLayoutXAxisAnchor {
		if #available(iOS 11.0, *) {
			return self.safeAreaLayoutGuide.leadingAnchor
		} else {
			return self.leadingAnchor
		}
	}
	
	var safeRightAnchor: NSLayoutXAxisAnchor {
		if #available(iOS 11.0, *) {
			return self.safeAreaLayoutGuide.rightAnchor
		} else {
			return self.rightAnchor
		}
	}
	
	var safeTrailingAnchor: NSLayoutXAxisAnchor {
		if #available(iOS 11.0, *) {
			return self.safeAreaLayoutGuide.trailingAnchor
		} else {
			return self.trailingAnchor
		}
	}
	
	var safeBottomAnchor: NSLayoutYAxisAnchor {
		if #available(iOS 11.0, *) {
			return self.safeAreaLayoutGuide.bottomAnchor
		} else {
			return self.bottomAnchor
		}
	}
}
