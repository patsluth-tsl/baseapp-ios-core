//
// 	UITableViewHeaderFooterWithEmbeddedContentView.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-03-01.
//

import SnapKit
import UIKit

// swiftlint:disable line_length

public extension NSObjectProtocol
	where Self: UIView {
	typealias TVReusableView = UITableViewHeaderFooterWithEmbeddedContentView<Self>
}

// swiftlint:disable:next type_name
public class UITableViewHeaderFooterWithEmbeddedContentView<T>: UITableView.BaseHeaderFooterView, UIViewWithEmbeddedContent
	where T: UIView {
	public typealias Embedded = T
    
	public var embedded: T!
    
	public override init(reuseIdentifier: String?) {
		super.init(reuseIdentifier: reuseIdentifier)
		
		embedded = T.make({
			self.contentView.addSubview($0)
		}).make(constraints: {
			$0.edges.equalTo(self.contentView.snp.margins)
		})
		
		backgroundColor = nil
	}
	
	required init?(coder aDecoder: NSCoder) {
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
    
	deinit {
		prepareForReuse()
	}
}
