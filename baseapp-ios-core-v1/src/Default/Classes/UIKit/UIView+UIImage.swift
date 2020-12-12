//
//  UIView+UIImage.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation

#if os(iOS)

public extension UIView {
    func imageRepresentation(afterScreenUpdates: Bool = false,
                             opaque: Bool = false) -> UIImage? {
		var image: UIImage? = nil
		
		UIGraphicsBeginImageContextWithOptions(bounds.size, opaque, 0.0)
        drawHierarchy(in: bounds, afterScreenUpdates: afterScreenUpdates)
//		if let context = UIGraphicsGetCurrentContext() {
//			self.layer.render(in: context)
//			image = UIGraphicsGetImageFromCurrentImageContext()
//		}
        image = UIGraphicsGetImageFromCurrentImageContext()
		UIGraphicsEndImageContext()
		
		return image
	}
}

#endif
