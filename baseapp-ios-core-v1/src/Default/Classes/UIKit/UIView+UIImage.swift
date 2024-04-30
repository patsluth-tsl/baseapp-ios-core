//
//  UIView+UIImage.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 SilverLogic. All rights reserved.
//

import Foundation

#if os(iOS)
public extension UIView {
    public enum ImageRepresentatinRenderType {
        case drawHierarchy(afterScreenUpdates: Bool)
        case graphicsCurrentContext
        case graphicsImageRenderer
    }

    func imageRepresentation(
        renderType: ImageRepresentatinRenderType = .graphicsImageRenderer,
        opaque: Bool = false,
        scale: CGFloat = 0.0
    ) -> UIImage? {
        switch renderType {
        case .drawHierarchy(afterScreenUpdates: let afterScreenUpdates):
            UIGraphicsBeginImageContextWithOptions(bounds.size, opaque, scale)
            drawHierarchy(in: bounds, afterScreenUpdates: afterScreenUpdates)
            defer {
                UIGraphicsEndImageContext()
            }
            return UIGraphicsGetImageFromCurrentImageContext()
        case .graphicsCurrentContext:
            UIGraphicsBeginImageContextWithOptions(bounds.size, opaque, scale)
            if let context = UIGraphicsGetCurrentContext() {
                layer.render(in: context)
            }
            defer {
                UIGraphicsEndImageContext()
            }
            return UIGraphicsGetImageFromCurrentImageContext()
        case .graphicsImageRenderer:
            let format = UIGraphicsImageRendererFormat.default().configure({
                $0.opaque = opaque
                $0.scale = 0
            })
            return UIGraphicsImageRenderer(size: bounds.size, format: format).image(actions: {
                layer.render(in: $0.cgContext)
            })
        }
    }
}

#endif
