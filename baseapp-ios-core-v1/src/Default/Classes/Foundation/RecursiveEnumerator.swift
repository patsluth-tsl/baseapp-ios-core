//
//  RecursiveEnumerator.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-12-19.
//  Copyright © 2017 SilverLogic. All rights reserved.
//

import Foundation

public struct RecursiveEnumerator<T> {
    private let getNext: (T) -> [T]?
    
    public init(next: @escaping (T) -> [T]?) {
        getNext = next
    }
    
    public init(next: @escaping (T) -> T?) {
        self.init(next: {
            [next($0)].compactMap({ $0 })
        })
    }
    
    public func enumerate(_ object: T!, _ block: (T, inout Bool) -> Void) {
        guard let object = object else { return }
        guard let nextObjects = getNext(object) else { return }
        var stop = false
        var _nextObjects = Array(nextObjects)
        while !_nextObjects.isEmpty, !stop {
            let nextObject = _nextObjects.removeFirst()
            enumerateHierarchy(nextObject, { _object, _stop in
                block(_object, &_stop)
                stop = _stop
            })
        }
    }
    
    public func enumerateHierarchy(_ object: T!, _ block: (T, inout Bool) -> Void) {
        guard let object = object else { return }
        var stop = false
        block(object, &stop)
        guard !stop else { return }
        guard let nextObjects = getNext(object) else { return }
        var _nextObjects = Array(nextObjects)
        while !_nextObjects.isEmpty, !stop {
            let nextObject = _nextObjects.removeFirst()
            enumerateHierarchy(nextObject, { _object, _stop in
                block(_object, &_stop)
                stop = _stop
            })
        }
    }
}
