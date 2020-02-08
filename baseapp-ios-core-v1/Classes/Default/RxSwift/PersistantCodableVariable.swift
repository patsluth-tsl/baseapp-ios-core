//
//  PersistantCodableVariable.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2018-10-27.
//  Copyright © 2018 Pat Sluth. All rights reserved.
//

import Foundation
import RxCocoa
import RxSwift

/// A BehaviorRelay wrapper that saves and reads value from UserDefaults
/// RawType is the value that E will be encoded/decoded to/from
public final class PersistantCodableVariable<T, RawType>: PersistantVariable<T>
    where T: Codable {
    public required init(_ type: T.Type,
                         rawType: RawType.Type,
                         key: String = "",
                         userDefaults: UserDefaults = UserDefaults.standard) {
        super.init(type, key: "\(T.self)_\(key)", userDefaults: userDefaults)
    }
    
    override func readValue() -> E {
        var value: E = nil
        do {
            let rawValue = self.userDefaults.value(forKey: self.key)
            value = try Element.decode(rawValue)
        } catch {
            logger.log(error: error)
        }
//        base.log(sender: self, "\(self.key) = \(value)")
        return value
    }
    
    override func write(value: Element) {
        do {
            let rawValue = try value?.encode(RawType.self)
            self.userDefaults.setValue(rawValue, forKey: self.key)
//            base.log(sender: self, "\(self.key) = \(value)")
        } catch {
            logger.log(error: error)
        }
    }
}
