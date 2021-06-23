//
//  Collection+BA.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-11-28.
//  Copyright © 2017 SilverLogic. All rights reserved.
//

import Foundation

public extension Collection {
	@available(*, deprecated, renamed: "joined(by:)")
	func toString(separatedBy separator: String) -> String {
		return joined(by: separator)
	}

	func joined(by separator: String) -> String {
		return map({ "\($0)" }).joined(separator: separator)
	}
}
