//
//  Collection+KeyPath.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-09-30.
//  Copyright © 2017 patsluth. All rights reserved.
//

import Foundation

public extension Collection
where Self: ExpressibleByArrayLiteral {
    func grouped<Value>(
        by keyPath: KeyPath<Element, Value>
    ) -> [Value: [Element]] where Value: Hashable {
        return self.reduce(into: [Value: [Element]](), {
            let key = $1[keyPath: keyPath]
            var elements = $0[key, default: []]
            elements.append($1)
            $0[key] = elements
        })
    }
    
    func sorted<Value>(
        by keyPath: KeyPath<Element, Value>,
        _ comparator: (Value, Value) -> Bool
    ) -> [Element]
    where Value: Comparable {
        return self.sorted(by: {
            comparator($0[keyPath: keyPath], $1[keyPath: keyPath])
        })
    }
}



// TODO: Move somewhere else
public extension Dictionary
where Key: Comparable {
    func sorted(
        by keyComparator: (Key, Key) -> Bool,
        _ valueTransformer: (Value) -> Value
    ) -> [(key: Key, value: Value)] {
        return self.sorted(by: {
            keyComparator($0.key, $1.key)
        }).map({
            (key: $0.key, value: valueTransformer($0.value))
        })
    }
}
