//
//  UIViewController+DisposeBags.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-08-07.
//  Copyright © 2017 patsluth. All rights reserved.
//

import RxCocoa
import RxSwift
#if os(iOS)
import UIKit

public extension UIViewController {
	/// A container for dispose bags. You must manually
	/// set the values other than deinit to dispose
	struct DisposeBags {
		public let `deinit`: DisposeBag
		public var willDisappear: DisposeBag
		public var didDisappear: DisposeBag
		
		public init() {
			self.deinit = DisposeBag()
			self.willDisappear = DisposeBag()
			self.didDisappear = DisposeBag()
		}
	}
}

#endif
