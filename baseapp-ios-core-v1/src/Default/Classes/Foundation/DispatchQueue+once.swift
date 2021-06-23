//
//  DispatchQueue+once.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2018-10-20.
//  Copyright © 2018 SilverLogic. All rights reserved.
//

import Foundation

public extension DispatchQueue {
	private static var _onceTokens = Set<String>()
	
    @discardableResult
    class func once(file: String = #file,
                    function: String = #function,
                    line: Int = #line,
                    token: String = "",
                    _ block: () -> Void) -> String {
        let token = "\(file):\(function):\(line)"
        DispatchQueue.once(token: token, block)
        return token
    }
	
	/**
	Executes a block of code, associated with a unique token, only once.  The code is thread safe and will
	only execute the code once even in the presence of multithreaded calls.
	
	- parameter token: A unique reverse DNS style name such as com.vectorform.<name> or a GUID
	- parameter block: Block to execute once
	*/
	class func once(token: String, _ block: () -> Void) {
		objc_sync_enter(self)
		defer { objc_sync_exit(self) }
		
		guard _onceTokens.insert(token).inserted else { return }
		
		block()
	}
	
	class func once(object: AnyObject, _ block: () -> Void) {
		let token = "\(ObjectIdentifier(object))"
		
		DispatchQueue.once(token: token, block)
	}
	
	class func clear(onceToken token: String) {
		_onceTokens.remove(token)
	}
	
	class func clear(onceTokenFor object: AnyObject) {
		clear(onceToken: "\(ObjectIdentifier(object))")
	}
}
