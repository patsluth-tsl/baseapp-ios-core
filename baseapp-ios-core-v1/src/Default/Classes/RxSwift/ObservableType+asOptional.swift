//
//  ObservableType+asOptional.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2018-10-25.
//  Copyright © 2018 SilverLogic. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

public extension ObservableType {
	func asOptional(catchError: @escaping (Error) throws -> Observable<Element?>) -> Observable<Element?> {
        return materialize()
            .flatMap({ event -> Observable<Element?> in
                switch event {
                case .next(let value):
                    return .just(value)
                case .error(let error):
                    do {
                        return try catchError(error)
                    } catch {
                        return .error(error)
                    }
                case .completed:
                    return .empty()
                }
            })
	}
}
