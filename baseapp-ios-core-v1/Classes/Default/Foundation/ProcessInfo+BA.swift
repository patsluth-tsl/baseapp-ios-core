//
//  ProcessInfo+Extension.swift
//  baseapp-ios-core-v1
//
//  Created by Emanuel  Guerrero on 3/23/17.
//  Copyright © 2017 SilverLogic. All rights reserved.
//

import Foundation

public enum ProcessInfoKey: String {
    case runningUnitTests = "RUNNING_UNIT_TESTS"
    case runningIntegrationTests = "RUNNING_INTEGRATION_TESTS"
    case runningUITests = "RUNNING_UI_TESTS"
}

public extension ProcessInfo {
    /// Determines if the application is running unit tests.
    @available(*, deprecated, renamed: "ProcessInfo.subscript(key:)")
    static var isRunningUnitTests: Bool {
        return self[ProcessInfoKey.runningUnitTests, "FALSE"] == "TRUE"
    }
    
    /// Determines if the application is running integration tests.
    @available(*, deprecated, renamed: "ProcessInfo.subscript(key:)")
    static var isRunningIntegrationTests: Bool {
        return self[ProcessInfoKey.runningIntegrationTests, "FALSE"] == "TRUE"
    }
    
    static subscript(key: ProcessInfoKey) -> String? {
        return processInfo.environment[key.rawValue]
    }
    
    static subscript(key: ProcessInfoKey, _ _default: String) -> String {
        return self[key] ?? _default
    }
}
