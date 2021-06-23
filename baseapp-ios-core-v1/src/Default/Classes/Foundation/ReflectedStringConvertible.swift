//
//  ReflectedStringConvertible.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-10-16.
//  Copyright © 2019 SilverLogic. All rights reserved.
//

import Foundation

public protocol ReflectedStringConvertible: CustomStringConvertible {  }

public extension ReflectedStringConvertible {
    var description: String {
		let mirror = Mirror(reflecting: self)
		var mirrors = [mirror]
		var description = ""
		
		while let superMirror = mirrors.first?.superclassMirror {
			mirrors.insert(superMirror, at: 0)
		}
		
		func reduce(mirror: Mirror, into string: inout String) {
			for (index, element) in mirror.children.enumerated() {
				if let label = element.label {
					if index > 0 {
						string += ", "
					}
					string += label
					string += ": "
					string += "\(element.value)"
				}
			}
		}
		
		for (index, mirror) in mirrors.enumerated() {
			reduce(mirror: mirror, into: &description)
			if index < mirrors.count - 1 {
				description += ", "
			}
		}
		
		return "\(mirror.subjectType)(\(description))"
	}
}
