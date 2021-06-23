//
//  UITableViewWithEmbeddedContentCell.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-03-01.
//  Copyright © 2019 SilverLogic. All rights reserved.
//

#if os(iOS)

import SnapKit
import UIKit


public extension NSObjectProtocol
	where Self: UIView {
	typealias TVCell = UITableViewWithEmbeddedContentCell<Self>
}

public class UITableViewWithEmbeddedContentCell<T>: UITableView.BaseCell, UIViewWithEmbeddedContent
	where T: UIView {
	public typealias Embedded = T
    
	public var embedded: T!
	
	public override var isSelected: Bool {
		didSet {
			(embedded as? SelectableViewProtocol)?.isSelected = isSelected
		}
	}
	
	public override var isHighlighted: Bool {
		didSet {
			(embedded as? HighlightableViewProtocol)?.isHighlighted = isHighlighted
		}
	}
    
	public override init(style: UITableViewCell.CellStyle, reuseIdentifier: String?) {
		super.init(style: style, reuseIdentifier: reuseIdentifier)
		
		embedded = T.make({
			self.contentView.addSubview($0)
		}).make(constraints: {
            $0.edges.equalTo(self.contentView.snp.margins)
		})
		
		backgroundColor = nil
	}
	
	public required init?(coder aDecoder: NSCoder) {
		super.init(coder: aDecoder)
	}
	
	public override func prepareForReuse() {
		super.prepareForReuse()
		
		(embedded as? UIReusableViewProtocol)?.prepareForReuse()
	}
	
	public override func prepareForInterfaceBuilder() {
		super.prepareForInterfaceBuilder()
		
		embedded.prepareForInterfaceBuilder()
	}
}

#endif
