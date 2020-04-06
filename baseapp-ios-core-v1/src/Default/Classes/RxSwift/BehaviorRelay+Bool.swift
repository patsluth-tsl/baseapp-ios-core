//
//  BehaviorRelay+Bool.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2018-10-27.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

public extension BehaviorRelay
	where Element == Bool {
	func toggle() {
        accept(!value)
	}
}
