//
//  ObservableType+ignore.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2018-10-27.
//  Copyright © 2018 SilverLogic. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

public extension ObservableType {
	func ignore<O>(until otherObservable: O) -> Observable<Element>
		where O: ObservableType {
		return otherObservable.flatMapLatest({ _ in
			self
		})
	}
}
