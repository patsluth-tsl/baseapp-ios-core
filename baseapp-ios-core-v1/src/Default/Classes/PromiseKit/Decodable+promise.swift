//
//  Decodable+promise.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-10-16.
//  Copyright © 2019 SilverLogic. All rights reserved.
//

import Foundation

import PromiseKit

public extension Decodable {
	static func decodePromise<T>(_ value: T) -> Promise<Self> {
		return Promise { resolver in
			do {
				resolver.fulfill(try Self.decode(value))
			} catch {
				resolver.reject(error)
			}
		}
	}
}
