//
//  ObservableType+unwrapOrComplete.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2018-10-25.
//  Copyright © 2018 SilverLogic. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

public extension ObservableType {
    /// Alias for `do`
    public func tap(onNext: ((Element) throws -> Void)? = nil, afterNext: ((Element) throws -> Void)? = nil, onError: ((Swift.Error) throws -> Void)? = nil, afterError: ((Swift.Error) throws -> Void)? = nil, onCompleted: (() throws -> Void)? = nil, afterCompleted: (() throws -> Void)? = nil, onSubscribe: (() -> Void)? = nil, onSubscribed: (() -> Void)? = nil, onDispose: (() -> Void)? = nil) -> Observable<Element> {
        return `do`(onNext: onNext, afterNext: afterNext, onError: onError, afterError: afterError, onCompleted: onCompleted, afterCompleted: afterCompleted, onSubscribe: onSubscribe, onSubscribed: onSubscribed, onDispose: onDispose)
    }
}
