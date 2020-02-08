//
//  PersistantVariable.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2018-10-27.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

/// A BehaviorRelay wrapper that saves and reads value from UserDefaults
public class PersistantVariable<T>: ObservableType {
    // swiftlint:disable:next type_name
	public typealias E = T?
    
	let key: String
	let userDefaults: UserDefaults
	private let _relay: BehaviorRelay<E>
	
	public var value: Element {
		get {
			return _relay.value
		}
		set {
			accept(newValue)
		}
	}
    
    public init(_ type: T.Type,
                key _key: String,
                userDefaults _userDefaults: UserDefaults = UserDefaults.standard) {
        key = _key
        userDefaults = _userDefaults
        _relay = BehaviorRelay(value: nil)
        
        defer {
            value = readValue()
        }
    }
	
	func readValue() -> Element {
		let value = userDefaults.value(forKey: key) as? T
//		base.log(sender: self, "\(key) = \(value)")
		return value
	}
	
	func write(value: Element) {
        userDefaults.setValue(value, forKey: key)
//		base.log(sender: self, "\(key) = \(value)")
	}
	
	public func accept(_ event: E) {
        _relay.accept(event)
		
		write(value: value)
	}
	
	// MARK: ObservableType
	public func subscribe<O>(_ observer: O) -> Disposable
		where O: ObserverType, O.Element == Element {
		return _relay.subscribe(observer)
	}
	
	public func asObservable() -> Observable<E> {
		return _relay.asObservable()
	}
}
