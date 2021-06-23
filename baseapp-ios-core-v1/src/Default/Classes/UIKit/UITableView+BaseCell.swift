//
//  UITableView+BaseCell.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-08-07.
//  Copyright © 2017 SilverLogic. All rights reserved.
//

import RxCocoa
import RxSwift
import UIKit

#if os(iOS)

extension UITableView {
	open class BaseCell: UITableViewCell {
		public private(set) var disposeBag = DisposeBag()
		
		open override var indentationLevel: Int {
			didSet {
				guard indentationLevel != oldValue else { return }
				updateLayoutMarginsForIndentation()
			}
		}
		
		open override var indentationWidth: CGFloat {
			didSet {
				guard indentationWidth != oldValue else { return }
				updateLayoutMarginsForIndentation()
			}
		}
        
		open override func prepareForReuse() {
			disposeBag = DisposeBag()
			super.prepareForReuse()
		}
		
		open func updateLayoutMarginsForIndentation() {
			contentView.layoutMargins.left = CGFloat(indentationLevel) * indentationWidth
			contentView.layoutIfNeeded()
		}
		
//		open override func layoutSubviews()
//		{
//			super.layoutSubviews()
//
//			self.contentView.layoutMargins.left = CGFloat(self.indentationLevel) * self.indentationWidth
//			self.contentView.layoutIfNeeded()
//		}
	}
}

#endif
