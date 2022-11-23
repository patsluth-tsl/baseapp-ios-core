//
//  ExecutionTime.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2018-03-01.
//  Copyright © 2018 SilverLogic. All rights reserved.
//

import Foundation


#if os(iOS)

public enum ExecutionTime {
    public static func of<T>(_ closure: () throws -> T, completedIn: (TimeInterval) -> Void) rethrows -> T {
        let start = CACurrentMediaTime()
        let returnValue = try closure()
        completedIn(CACurrentMediaTime() - start)
        return returnValue
    }
}

#endif
