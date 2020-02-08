//
//  AspectRatio.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-02-25.
//

import AVKit
import UIKit

public enum AspectRatio {
    /// Width by Height
    case wh
    /// Height by Width
    case hw
    
    func apply(_ sourceSize: CGSize, to size: inout CGSize) {
        switch self {
        case .wh:
            size.height = size.width * AspectRatio.heightPercentage(sourceSize)
        case .hw:
            size.width = size.height * AspectRatio.widthPercentage(sourceSize)
        }
    }
    
    public func applying(_ sourceSize: CGSize, to size: CGSize) -> CGSize {
        var size = size
        apply(sourceSize, to: &size)
        return size
    }
    
    public func apply(_ sourceRect: CGRect, to rect: inout CGRect) {
        apply(sourceRect.size, to: &rect.size)
    }
    
    public func applying(_ sourceRect: CGRect, to rect: CGRect) -> CGRect {
        var rect = rect
        apply(sourceRect, to: &rect)
        return rect
    }
    
    public static func widthPercentage(_ size: CGSize!) -> CGFloat {
        guard let size = size else { return 0 }
        return size.width / size.height
    }
    
    public static func heightPercentage(_ size: CGSize!) -> CGFloat {
        guard let size = size else { return 0 }
        return size.height / size.width
    }
    
    public static func fittedRect(aspectRatio size: CGSize,
                                  inside rect: CGRect,
                                  contentMode: UIView.ContentMode) -> CGRect {
        switch contentMode {
        case .scaleToFill:
            return rect
        case .scaleAspectFit:
            return AVMakeRect(aspectRatio: size, insideRect: rect)
        case .scaleAspectFill:
            let aspectRatio = AspectRatio.widthPercentage(size)
            if (rect.size.width / aspectRatio) > rect.size.height {
                let height = rect.width / aspectRatio
                return CGRect(
                    x: 0,
                    y: (rect.height - height) / 2,
                    width: rect.width,
                    height: height
                )
            } else {
                let width = rect.height * aspectRatio
                return CGRect(
                    x: (rect.width - width) / 2,
                    y: 0,
                    width: width,
                    height: rect.height
                )
            }
        case .redraw:
            return rect
        case .center:
            fatalError("not implemented")
        case .top:
            fatalError("not implemented")
        case .bottom:
            fatalError("not implemented")
        case .left:
            fatalError("not implemented")
        case .right:
            fatalError("not implemented")
        case .topLeft:
            fatalError("not implemented")
        case .topRight:
            fatalError("not implemented")
        case .bottomLeft:
            fatalError("not implemented")
        case .bottomRight:
            fatalError("not implemented")
        @unknown default:
            fatalError("not implemented")
        }
    }
    
    public static func fittedSize(aspectRatio: CGSize,
                                  inside: CGSize,
                                  contentMode: UIView.ContentMode) -> CGSize {
        return AspectRatio.fittedRect(
            aspectRatio: aspectRatio,
            inside: CGRect.zero.with(size: inside),
            contentMode: contentMode
        ).size
    }
}

public extension AspectRatio {
    class ImageView: UIImageView {
        public var type = AspectRatio.wh {
            didSet { invalidateIntrinsicContentSize() }
        }
        
        public override var image: UIImage? {
            didSet { invalidateIntrinsicContentSize() }
        }
        
        public override var intrinsicContentSize: CGSize {
            return type.applying(bounds.size, to: bounds.size)
        }
        
        public override init(frame: CGRect) {
            super.init(frame: frame)
            
            contentMode = .scaleAspectFit
            
            defer {
                image = { image }()
            }
        }
        
        required public init?(coder aDecoder: NSCoder) {
            super.init(coder: aDecoder)
        }
        
        open override func awakeFromNib() {
            super.awakeFromNib()
            
            image = { image }()
        }
        
        open override func layoutSubviews() {
            super.layoutSubviews()
            
            invalidateIntrinsicContentSize()
        }
    }
}
