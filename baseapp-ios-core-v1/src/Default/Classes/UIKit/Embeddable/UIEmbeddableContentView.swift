//
//  UIEmbeddableContentView.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-03-01.
//  Copyright © 2017 SilverLogic. All rights reserved.
//

import UIKit

#if os(iOS)

public protocol HighlightableViewProtocol: UIView {
	var isHighlighted: Bool { get set }
}

public protocol SelectableViewProtocol: UIView {
	var isSelected: Bool { get set }
}

extension UITableViewCell: SelectableViewProtocol, HighlightableViewProtocol {
}

extension UICollectionViewCell: SelectableViewProtocol, HighlightableViewProtocol {
}

extension UIImageView: HighlightableViewProtocol {
}


@objc public protocol UIEmbeddedContentView
	where Self: UIView {
	@objc optional func prepareForReuse()
}

#endif
