//
//  ShapeView.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-03-01.
//

import UIKit

@IBDesignable
public class ShapeView: UIView {
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

// TODO: Add more shapes
public enum Shape: String {
	case Circle
	case Triangle
	
	func bezierPath(for view: UIView) -> UIBezierPath {
		var path = UIBezierPath()
        
		switch self {
		case .Circle:
			path = UIBezierPath(ovalIn: view.bounds)
		case .Triangle:
			// UP
			path.move(to: CGPoint(x: view.bounds.minX, y: view.bounds.maxY))
			//		trianglePath.addLine(to: CGPoint(x: -size, y: up ? size : -size))
			//		trianglePath.addLine(to: CGPoint(x: size, y: up ? size : -size))
			path.addLine(to: CGPoint(x: view.bounds.midX, y: view.bounds.minY))
			path.addLine(to: CGPoint(x: view.bounds.maxX, y: view.bounds.maxY))
			path.close()
			
			// Rotation
			//			path.apply(CGAffineTransform(rotationAngle: 75.0))
		}
		
		return path
	}
}
