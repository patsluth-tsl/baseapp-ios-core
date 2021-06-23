//
//  Encodable+promise.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-10-16.
//  Copyright © 2019 SilverLogic. All rights reserved.
//

import Foundation

import PromiseKit

public extension Encodable {
	func encodePromise<T>(_ type: T.Type) -> Promise<T> {
		return Promise { resolver in
			do {
				resolver.fulfill(try self.encode(type))
			} catch {
				resolver.reject(error)
			}
		}
	}
}
