//
//  UICollectionView+BaseReusableView.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-10-16.
//  Copyright © 2019 SilverLogic. All rights reserved.
//

#if os(iOS)

import RxCocoa
import RxSwift
import UIKit

extension UICollectionView {
	open class BaseReusableView: UICollectionReusableView {
		public private(set) var disposeBag = DisposeBag()
        
		open override func prepareForReuse() {
			self.disposeBag = DisposeBag()
			
			super.prepareForReuse()
		}
	}
}

#endif
