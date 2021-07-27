//
//  KeyedEncodingContainer+DateInRegion.swift
//  baseapp-ios-core-v1
//
//  Created by patsluth on 01/15/2020.
//  Copyright (c) 2020 SilverLogic. All rights reserved.
//

import Foundation
import SwiftDate

public extension KeyedEncodingContainer {
    mutating func encodeDateInRegion(_ value: DateInRegion,
                                     forKey key: Key,
                                     transform: ((DateInRegion) -> String)? = nil) throws {
        let string = transform?(value) ?? value.toISO()
        try encode(string, forKey: key)
    }
    
    mutating func encodeDateInRegion(_ value: DateInRegion?,
                                     forKey key: Key,
                                     transform: ((DateInRegion?) -> String?)? = nil) throws {
        let string = transform?(value) ?? value?.toISO()
        try encodeIfPresent(string, forKey: key)
    }
}

public extension KeyedDecodingContainer {
    func decodeDateInRegion(forKey key: Key,
                            transform: ((String) -> DateInRegion)? = nil) throws -> DateInRegion {
        let string = try decode(String.self, forKey: key)
        if let dateInRegion = transform?(string) ?? string.toISODate() {
            return dateInRegion
        }
        throw Errors.Decoding(DateInRegion.self, codingPath: [key])
    }
    
    func decodeDateInRegion(forKey key: Key,
                            transform: ((String?) -> DateInRegion?)? = nil) throws -> DateInRegion? {
        let string = try decodeIfPresent(String.self, forKey: key)
        return transform?(string) ?? string?.toISODate()
    }
}
