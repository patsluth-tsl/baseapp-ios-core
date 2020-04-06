//
//  ObservableType+or.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2018-10-27.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift




public extension ObservableType {
	func or<B>(_ b: Observable<B>) -> Observable<ExclusivePair<Element, B>> {
		return Observable.create({ observable in
			let disposableA = self.bind(onNext: {
				observable.onNext(.A($0))
			})
			let disposableB = b.bind(onNext: {
				observable.onNext(.B($0))
			})
			return Disposables.create([disposableA, disposableB])
		})
	}
}
