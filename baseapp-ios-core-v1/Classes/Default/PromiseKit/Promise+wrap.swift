//
//  Promise+attempt.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation

import PromiseKit
import CancelForPromiseKit






public extension Promise
{
    static func wrap<T>(on dispatchQueue: DispatchQueue = .main,
                        _ block: @escaping () throws -> T) -> Promise<T>
	{
        return promise_wrap(on: dispatchQueue, block)
	}
	
	static func wrap<T>(on dispatchQueue: DispatchQueue = .main,
                        _ block: @escaping (Resolver<T>) -> Void) -> Promise<T>
	{
		let (promise, resolver) = Promise<T>.pending()
        dispatchQueue.async(execute: {
            block(resolver)
        })
		return promise
	}
}

public extension Guarantee
{
	static func wrap<T>(on dispatchQueue: DispatchQueue = .main,
                        _ block: @escaping () -> T) -> Guarantee<T>
	{
		return promise_wrap(block)
	}
    
    static func wrap<T>(on dispatchQueue: DispatchQueue = .main,
                        _ block: @escaping ((T) -> Void) -> Void) -> Guarantee<T>
    {
        let (guarantee, resolver) = Guarantee<T>.pending()
        dispatchQueue.async(execute: {
            block(resolver)
        })
        return guarantee
    }
}





public extension CancellablePromise
{
	static func wrap<T>(on dispatchQueue: DispatchQueue = .main,
                        _ block: @escaping () throws -> T) -> CancellablePromise<T>
	{
		return promise_wrap(block)
	}
	
	static func wrap<T>(on dispatchQueue: DispatchQueue = .main,
                        _ block: @escaping (Resolver<T>) -> Void) -> CancellablePromise<T>
	{
		let (promise, resolver) = CancellablePromise<T>.pending()
        dispatchQueue.async(execute: {
            block(resolver)
        })
		return promise
	}
}

public extension CancellableGuarantee
{
	static func wrap<T>(on dispatchQueue: DispatchQueue = .main,
                        _ block: @escaping () -> T) -> CancellableGuarantee<T>
	{
		return promise_wrap(block)
	}
    
    static func wrap<T>(on dispatchQueue: DispatchQueue = .main,
                        _ block: @escaping ((T) -> Void) -> Void) -> CancellableGuarantee<T>
    {
        let (guarantee, resolver) = CancellableGuarantee<T>.pending()
        dispatchQueue.async(execute: {
            block(resolver)
        })
        return guarantee
    }
}





public func promise_wrap<T>(on dispatchQueue: DispatchQueue = .main,
                            _ block: @escaping () throws -> T) -> Promise<T>
{
    let (promise, resolver) = Promise<T>.pending()
    dispatchQueue.async(execute: {
        do {
            resolver.fulfill(try block())
        } catch {
            resolver.reject(error)
        }
    })
    return promise
}

public func promise_wrap<T>(on dispatchQueue: DispatchQueue = .main,
                            _ block: @escaping () -> T) -> Guarantee<T>
{
    let (guarantee, resolver) = Guarantee<T>.pending()
	dispatchQueue.async(execute: {
        resolver(block())
    })
    return guarantee
}





public func promise_wrap<T>(on dispatchQueue: DispatchQueue = .main,
                            _ block: @escaping () throws -> T) -> CancellablePromise<T>
{
    let (promise, resolver) = CancellablePromise<T>.pending()
    dispatchQueue.async(execute: {
        do {
            resolver.fulfill(try block())
        } catch {
            resolver.reject(error)
        }
    })
    return promise
}

public func promise_wrap<T>(on dispatchQueue: DispatchQueue = .main,
                            _ block: @escaping () -> T) -> CancellableGuarantee<T>
{
    let (guarantee, resolver) = CancellableGuarantee<T>.pending()
    dispatchQueue.async(execute: {
        resolver(block())
    })
    return guarantee
}

//public func promise_wrap<T>(_ block: () throws -> T) -> CancellablePromise<T>
//	where T: CancellableTask
//{
//	return CancellablePromise<T>(resolver: { resolver in
//		do {
//			resolver.fulfill(try block())
//		} catch {
//			resolver.reject(error)
//		}
//	})
//}
//
//public func promise_wrap<T>(_ block: () -> T) -> CancellableGuarantee<T>
//	where T: CancellableTask
//{
//	return CancellableGuarantee<T>(resolver: { resolver in
//		resolver(block())
//	})
//}

//func testCancellable<T>(_ t: T) -> DispatchWorkItem
//{
//	let task = DispatchWorkItem(qos: .background, flags: .enforceQoS, block: {
//		Thread.sleep(forTimeInterval: 3)
//		sw.log(t)
//	})
//
//	DispatchQueue.global(qos: DispatchQoS.QoSClass.background)
//		.async(execute: task)
//
//	return task
//}




