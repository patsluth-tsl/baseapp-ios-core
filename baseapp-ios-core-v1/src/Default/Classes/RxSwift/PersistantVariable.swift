//
//  PersistantVariable.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2018-10-27.
//  Copyright © 2018 SilverLogic. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

/// A `BehaviorRelay` wrapper that saves and reads value from `UserDefaults`
public class PersistantVariable<T>: ObservableType {
    // swiftlint:disable:next type_name
    public typealias E = T
    public typealias Serializer = PersistantVariableValueSerializer<T>
    
    public let key: String
    let defaultValue: Element
    let serializer: Serializer
    let userDefaults: UserDefaults
    
    private let _relay = BehaviorRelay<Element?>(value: nil)
    
    public var value: Element {
        get {
            return _relay.value ?? defaultValue
        }
        set {
            accept(newValue)
        }
    }
    
    public init(_ type: T.Type,
                key: String,
                defaultValue: T,
                serializer: Serializer,
                userDefaults: UserDefaults = UserDefaults.standard) {
        self.key = key
        self.defaultValue = defaultValue
        self.serializer = serializer
        self.userDefaults = userDefaults
        defer {
            value = (try? readValue()) ?? defaultValue
        }
    }
    
    func readValue() throws -> Element {
        guard let value = userDefaults.value(forKey: key) else { return defaultValue }
        return try serializer.read(value)
    }
    
    func write(value: Element) throws {
        userDefaults.setValue(try serializer.write(value), forKey: key)
    }
    
    public func accept(_ event: E) {
        do {
            try write(value: event)
            _relay.accept(event)
        } catch {
            logger.error(error)
        }
    }
    
    
    // MARK: ObservableType
    public func subscribe<O>(_ observer: O) -> Disposable
    where O: ObserverType, O.Element == Element {
        return asObservable().subscribe(observer)
    }
    
    public func asObservable() -> Observable<E> {
        return _relay.asObservable().map({ [unowned self] in
            $0 ?? self.defaultValue
        })
    }
}


public final class PersistantVariableValueSerializer<T> {
    public let read: (Any) throws -> T
    public let write: (T) throws -> Any
    
    init(read: @escaping (Any) throws -> T, write: @escaping (T) throws -> Any) {
        self.read = read
        self.write = write
    }
}

public extension PersistantVariableValueSerializer
where T: RawRepresentable {
    convenience init() {
        self.init(read: {
            guard let rawValue = $0 as? T.RawValue, let value = T(rawValue: rawValue)
            else {
                throw Errors.Decoding(T.self, codingPath: [])
            }
            return value
        }, write: {
            return $0.rawValue
        })
    }
}

public extension PersistantVariableValueSerializer
where T: Codable {
    convenience init<R>(rawType: R.Type) {
        self.init(read: {
            return try T.decode($0)
        }, write: {
            return try $0.encode(R.self)
        })
    }
}


/// A property wrapper for `PersistantVariable`
@propertyWrapper public final class Persistant<T>: PersistantVariable<T> {
    public var projectedValue: PersistantVariable<T> {
        return self
    }
    
    public var wrappedValue: E {
        get {
            return value ?? defaultValue
        }
        set {
            value = newValue
        }
    }
    
    public init(wrappedValue: E,
                key: String,
                serializer: Serializer,
                userDefaults: UserDefaults = UserDefaults.standard) {
        super.init(
            T.self,
            key: key,
            defaultValue: wrappedValue,
            serializer: serializer,
            userDefaults: userDefaults
        )
    }
}
