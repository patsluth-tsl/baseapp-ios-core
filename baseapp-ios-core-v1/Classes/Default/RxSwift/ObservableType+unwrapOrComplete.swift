//
//  ObservableType+unwrapOrComplete.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2018-10-25.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

public extension ObservableType {
    func unwrapOrComplete<T>() -> Observable<T>
        where Element == T? {
            return flatMap({ t -> Observable<T> in
                if let t = t {
                    return .just(t)
                } else {
                    return .empty()
                }
            })
    }
}
