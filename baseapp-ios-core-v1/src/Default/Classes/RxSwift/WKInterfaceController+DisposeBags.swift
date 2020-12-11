//
//  WKInterfaceController+DisposeBags.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-08-07.
//  Copyright © 2017 patsluth. All rights reserved.
//

import RxCocoa
import RxSwift
#if os(watchOS)
import WatchKit

public extension WKInterfaceController {
    /// A container for dispose bags. You must manually
    /// set the values other than deinit to dispose
    struct DisposeBags {
        public let `deinit`: DisposeBag
        public var willActivate: DisposeBag
        public var didDeactivate: DisposeBag
        public var didAppear: DisposeBag
        public var willDisappear: DisposeBag
        
        public init() {
            self.deinit = DisposeBag()
            self.willActivate = DisposeBag()
            self.didDeactivate = DisposeBag()
            self.didAppear = DisposeBag()
            self.willDisappear = DisposeBag()
        }
    }
}

#endif
