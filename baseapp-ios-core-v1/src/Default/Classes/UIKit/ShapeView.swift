//
//  ShapeView.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2018-10-27.
//  Copyright © 2018 SilverLogic. All rights reserved.
//

import UIKit

#if os(iOS)

// TODO: Add more shapes
public enum Shape: String {
    case Circle
    case Triangle
    
    func bezierPath(for bounds: CGRect) -> UIBezierPath {
        switch self {
        case .Circle:
            return UIBezierPath(ovalIn: bounds)
        case .Triangle:
            return UIBezierPath.make({
                // UP
                $0.move(to: CGPoint(x: bounds.minX, y: bounds.maxY))
                //        trianglePath.addLine(to: CGPoint(x: -size, y: up ? size : -size))
                //        trianglePath.addLine(to: CGPoint(x: size, y: up ? size : -size))
                $0.addLine(to: CGPoint(x: bounds.midX, y: bounds.minY))
                $0.addLine(to: CGPoint(x: bounds.maxX, y: bounds.maxY))
                $0.close()
            })
        }
    }
    
    func bezierPath(for view: UIView) -> UIBezierPath {
        return bezierPath(for: view.bounds)
    }
}


/// A View that masks itself to a `Shape`
open class ShapeView: UIView {
    private lazy var maskLayer: CAShapeLayer = {
        let maskLayer = CAShapeLayer()
        layer.mask = maskLayer
        return maskLayer
    }()
    
    @IBInspectable
    var rawShape: String? {
        get { return shape?.rawValue }
        set { shape = Shape(rawValue: newValue ?? "") }
    }
    
    public var shape: Shape? = nil {
        didSet {
            clipsToBounds = true
            layer.masksToBounds = true
            
            maskLayer.path = shape?.bezierPath(for: self).cgPath
        }
    }
    
    public override func didMoveToSuperview() {
        super.didMoveToSuperview()
    }
    
    public override func layoutSubviews() {
        super.layoutSubviews()
        
        self.shape = { self.shape }()
    }
}


open class EmbeddedShapeView<Embedded: UIView>: ShapeView {
    public private(set) var embedded: Embedded!
    
    public override init(frame: CGRect) {
        super.init(frame: frame)
        postInit()
    }
    
    required public init?(coder: NSCoder) {
        super.init(coder: coder)
        postInit()
    }
    
    private func postInit() {
        embedded = Embedded.make({
            self.addSubview($0)
        }).make(constraints: {
            $0.edges.equalTo(self.snp.edges)
        })
        
        backgroundColor = nil
    }
}

#endif
