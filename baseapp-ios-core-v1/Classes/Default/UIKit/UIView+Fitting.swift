//
//  UIView+Fitting.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-12-03.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation
import UIKit

public extension UIView {
    public enum FittingType {
        case CompressedSize
        case ExpandedSize
        
        
        fileprivate var fittingSize: CGSize {
            switch self {
            case .CompressedSize:
                return UIView.layoutFittingCompressedSize
            case .ExpandedSize:
                return UIView.layoutFittingExpandedSize
            }
        }
    }
    
    public enum Fitting {
        case Default(FittingType)
        case Width(CGFloat, FittingType)
        case Height(CGFloat, FittingType)
        
        
        fileprivate var fittingSize: CGSize {
            switch self {
            case let .Default(fittingType):
                return fittingType.fittingSize
            case let .Width(width, fittingType):
                return fittingType.fittingSize.with(width: width)
            case let .Height(height, fittingType):
                return fittingType.fittingSize.with(width: height)
            }
        }
        
        fileprivate func systemSize(for view: UIView) -> CGSize {
            switch self {
            case let .Default(fittingType):
                return view.systemSize(fittingSize: self.fittingSize)
            case let .Width(width, fittingType):
                return view.systemSize(fittingSize: self.fittingSize,
                                       horizontal: .required,
                                       vertical: .fittingSizeLevel)
            case let .Height(height, fittingType):
                return view.systemSize(fittingSize: self.fittingSize,
                                       horizontal: .required,
                                       vertical: .fittingSizeLevel)
            }
            
//            switch self {
//            case .CompressedSize:
//                return view.systemSize(fittingSize: self.fittingSize)
//            case .ExpandedSize:
//                return view.systemSize(fittingSize: self.fittingSize)
//                //                case .Size(let fittingSize):
//            //                    return view.systemSize(fitting: fittingSize)
//            case .Width(_):
//                return view.systemSize(fittingSize: self.fittingSize,
//                                       horizontal: .required,
//                                       vertical: .fittingSizeLevel)
//            case .Height(_):
//                return view.systemSize(fittingSize: self.fittingSize,
//                                       horizontal: .required,
//                                       vertical: .fittingSizeLevel)
//            }
        }
    }
}

public extension NSObjectProtocol
	where Self: UIView {
    /// wrapper for systemLayoutSizeFitting(targetSize:)
	func systemSize(fittingSize targetSize: CGSize = UIView.layoutFittingCompressedSize) -> CGSize {
		return systemLayoutSizeFitting(targetSize)
	}
	
	/// wrapper for systemLayoutSizeFitting(targetSize:withHorizontalFittingPriority:verticalFittingPriority)
    func systemSize(fittingSize targetSize: CGSize = UIView.layoutFittingCompressedSize,
                    horizontal: UILayoutPriority,
                    vertical: UILayoutPriority) -> CGSize {
        return systemLayoutSizeFitting(
            targetSize,
            withHorizontalFittingPriority: horizontal,
            verticalFittingPriority: vertical
        )
    }
    
    func systemSize(fitting: UIView.Fitting = .Default(.CompressedSize)) -> CGSize {
		return fitting.systemSize(for: self)
		//		switch fitting {
		//		case .CompressedSize:
		//			return self.systemSize(fitting: UIView.layoutFittingCompressedSize)
		//		case .ExpandedSize:
		//			<#code#>
		////		case .Size(let fittingSize):
		////			<#code#>
		//		case .Width(let fittingWidth):
		//			<#code#>
		//		case .Height(let fittingHeight):
		//			<#code#>
		//		}
		//
		//		let fittingSize = UIView.layoutFittingCompressedSize.with(width: targetWidth)
		//
		//		return self.systemSize(fitting: fittingSize,
		//							   horizontal: .required,
		//							   vertical: .fittingSizeLevel)
	}
}
