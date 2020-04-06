//
//  QLPreviewController.swift
//  FilePreviewer
//
//  Created by Pat Sluth on 2017-12-08.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation
import QuickLook

@objc public extension QLPreviewController {
	var section: Int {
		get {
			return self.view.tag
		}
		set {
			self.view.tag = newValue
		}
	}
}
