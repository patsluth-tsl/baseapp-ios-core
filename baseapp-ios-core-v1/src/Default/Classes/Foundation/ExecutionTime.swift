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
    public static func of(_ closure: () -> Void, completedIn: (TimeInterval) -> Void) {
        let start = CACurrentMediaTime()
        closure()
        completedIn(CACurrentMediaTime() - start)
    }
}

#endif
