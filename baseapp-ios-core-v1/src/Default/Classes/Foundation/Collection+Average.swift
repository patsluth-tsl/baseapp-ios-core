//
//  Collection+Average.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-12-19.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import Foundation

public extension Collection {
    func weightedAverage<Weight>(
        weight weightProvider: (Element) -> Weight,
        value valueProvider: (Element) -> Weight
    ) -> Weight where Weight: FloatingPointType {
        let weightedValues = map({
            (weight: weightProvider($0), element: $0)
        })
        switch weightedValues.count {
        case 0:
            return 0
        case 1:
            return valueProvider(weightedValues[0].element)
        default:
            let totalWeight = weightedValues.reduce(0.0, { $0 + $1.weight })
            return weightedValues.reduce(0.0, {
                $0 + (valueProvider($1.element) * $1.weight)
            }) / totalWeight
        }
    }
    
    func weightedAverage<Weight, Output>(
        weight weightProvider: (Element) -> Weight,
        value valueProvider: (Element) -> Weight,
        map outputProvider: (Weight) -> Output
    ) -> Output where Weight: FloatingPointType {
        return outputProvider(weightedAverage(
            weight: weightProvider,
            value: valueProvider
        ))
    }
    
    func weightedAverage<Weight>(
        weight weightProvider: (Element) -> Weight,
        values valueProviders: [(Element) -> Weight]
    ) -> [Weight] where Weight: FloatingPointType {
        return valueProviders.map({ valueProvider in
            weightedAverage(
                weight: weightProvider,
                value: valueProvider
            )
        })
    }
    
    func weightedAverage<Weight, Output>(
        weight weightProvider: (Element) -> Weight,
        values valueProviders: [(Element) -> Weight],
        map outputProvider: ([Weight]) -> Output
    ) -> Output where Weight: FloatingPointType {
        return outputProvider(weightedAverage(
            weight: weightProvider,
            values: valueProviders
        ))
    }
}

public extension Collection {
    func average<Value>(
        value valueProvider: (Element) -> Value
    ) -> Value where Value: FloatingPointType {
        let values = map({
            (value: valueProvider($0), element: $0)
        })
        switch values.count {
        case 0:
            return 0
        case 1:
            return valueProvider(values[0].element)
        default:
            return values.reduce(0.0, {
                $0 + valueProvider($1.element)
            }) / Value(values.count)
        }
    }
    
    func average<Value, Output>(
        value valueProvider: (Element) -> Value,
        map outputProvider: (Value) -> Output
    ) -> Output where Value: FloatingPointType {
        return outputProvider(average(
            value: valueProvider
        ))
    }
    
    func average<Value>(
        values valueProviders: [(Element) -> Value]
    ) -> [Value] where Value: FloatingPointType {
        return valueProviders.map({ valueProvider in
            average(
                value: valueProvider
            )
        })
    }
    
    func average<Value, Output>(
        values valueProviders: [(Element) -> Value],
        map outputProvider: ([Value]) -> Output
    ) -> Output where Value: FloatingPointType {
        return outputProvider(average(
            values: valueProviders
        ))
    }
}
