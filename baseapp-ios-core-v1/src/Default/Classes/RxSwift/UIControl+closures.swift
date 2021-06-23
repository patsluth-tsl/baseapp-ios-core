//
//  UIControl+closures.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2018-10-25.
//  Copyright © 2018 SilverLogic. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

// Wrapper to call disposed(by:) and map to self
public struct ControlObservableWrapper<Base, Element>
	where Base: AnyObject & ReactiveCompatible {
	private let base: Base
	private var observable: Observable<Element>
    
    
    
	fileprivate init(_ base: Base, _ controlEvent: ControlEvent<Element>) {
        self.base = base
		self.observable = controlEvent
			.asObservable()
			.takeUntil(base.rx.deallocated)
	}
	
	fileprivate init(_ base: Base, _ controlProperty: ControlProperty<Element>) {
        self.base = base
		self.observable = controlProperty
			.asObservable()
			.takeUntil(base.rx.deallocated)
	}
	
	fileprivate init(_ base: Base, _ observable: Observable<Element>) {
        self.base = base
		self.observable = observable
	}
	
	fileprivate func finalize() -> Driver<Element> {
		return observable
			//			.debug()
			.asDriver(onErrorRecover: { _ in
				.empty()
			})
	}
	
    // swiftlint:disable:next line_length
	/// Edit the current observable, to apply debounce or throttle for example
	public func prepare(
        changes: (Observable<Element>) -> Observable<Element>
    ) -> ControlObservableWrapper<Base, Element> {
		return ControlObservableWrapper(base, changes(observable))
	}
	
	public func map<O>(
        _ block: @escaping (Base, Element) -> O
    ) -> ControlObservableWrapper<Base, O.Element> where O: ObservableConvertibleType {
		let _observable = observable
			.flatMapLatest({ [unowned base = base] in
				block(base, $0)
			})
		
		return ControlObservableWrapper<Base, O.Element>(base, _observable)
	}
	
	public func map<O>(
        _ block: @escaping (Base) -> O
    ) -> ControlObservableWrapper<Base, O.Element> where O: ObservableConvertibleType {
		let _observable = observable
			.flatMapLatest({ [unowned base = base] _ in
				block(base)
			})
		
		return ControlObservableWrapper<Base, O.Element>(base, _observable)
	}
	
	public func on(
        _ event: @escaping (Base, Element) -> Void
    ) -> DisposableWrapper<Base> {
		let _disposable = finalize()
			.drive(onNext: { [unowned base = base] in
				event(base, $0)
			})
		
		return DisposableWrapper(base, _disposable)
	}
	
	public func on(
        _ event: @escaping (Base) -> Void
    ) -> DisposableWrapper<Base> {
		let _disposable = finalize()
			.drive(onNext: { [unowned base = base] _ in
				event(base)
			})
		
		return DisposableWrapper(base, _disposable)
	}
}

public struct DisposableWrapper<Value> {
	private let value: Value
	private let disposable: Disposable
	
	
	
	
	
	fileprivate init(_ _value: Value, _ _disposable: Disposable) {
        value = _value
		disposable = _disposable
	}
	
	@discardableResult
	public func dispose() -> Value {
		disposable.dispose()
		
		return value
	}
	
	@discardableResult
	public func disposed(by disposedBag: DisposeBag?) -> Value {
		if let disposedBag = disposedBag {
			disposable.disposed(by: disposedBag)
		}
        
		return value
	}
}


#if os(iOS)

public extension NSObjectProtocol
	where Self: UIControl {
	@discardableResult
	func on(_ controlEvent: UIControl.Event) -> ControlObservableWrapper<Self, Void> {
		let controlEvent = rx.controlEvent(controlEvent)
		return ControlObservableWrapper(self, controlEvent)
	}
	
    @discardableResult
    func on(_ controlEvent: UIControl.Event,
            _ event: @escaping (Self) -> Void) -> DisposableWrapper<Self> {
        return on(controlEvent).on(event)
    }
    
	@discardableResult
    // swiftlint:disable:next line_length
	func on<T>(controlProperty keyPath: KeyPath<Reactive<Self>, ControlProperty<T>>) -> ControlObservableWrapper<Self, T> {
		let controlProperty = rx[keyPath: keyPath]
		return ControlObservableWrapper(self, controlProperty)
	}
    
    func on<T>(controlProperty keyPath: KeyPath<Reactive<Self>, ControlProperty<T>>,
               _ event: @escaping (Self, T) -> Void) -> DisposableWrapper<Self> {
        return on(controlProperty: keyPath).on(event)
    }
	
	
	
	@discardableResult
	func onTap() -> ControlObservableWrapper<Self, Void> {
		return on(.touchUpInside)
	}
	
	@discardableResult
	func onTap(_ event: @escaping (Self) -> Void) -> DisposableWrapper<Self> {
		return onTap().on(event)
	}
}

public extension NSObjectProtocol
	where Self: UIBarButtonItem {
	@discardableResult
	func onTap() -> ControlObservableWrapper<Self, Void> {
		return ControlObservableWrapper(self, rx.tap)
	}
	
	@discardableResult
	func onTap(_ event: @escaping (Self) -> Void) -> DisposableWrapper<Self> {
		return onTap().on(event)
	}
}

#endif
