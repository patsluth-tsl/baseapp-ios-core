//
//  BaseLogger.swift
//  baseapp-ios-core-v1
//
//  Created by Emanuel  Guerrero on 3/7/17.
//  Copyright © 2017 SilverLogic. All rights reserved.
//

#if os(iOS)
import AssistantKit
#endif
import Foundation
import SwiftyBeaver

public typealias LogLevel = SwiftyBeaver.Level

public enum LogWhen {
    case always
    case debugOnly
    
    fileprivate var shouldSkip: Bool {
        switch self {
        case .debugOnly:
            #if !DEBUG
            return true
            #endif
        case .always:
            break
        }
        return false
    }
}

public let logger = BaseLogger()

/// `BaseAppLogger` to log to SwiftyBeaver destinations
public final class BaseLogger {
    fileprivate let _logger: SwiftyBeaver.Type
    
    fileprivate init() {
        _logger = SwiftyBeaver.self
        let format = "$DHH:mm:ss$d $C$L$c: $M"
        _logger.addDestination(configure(ConsoleDestination(), {
            $0.format = format
        }))
        _logger.addDestination(configure(FileDestination(), {
            $0.format = (ProcessInfo.isRunningUnitTests) ? "$M" : format
            #if os(iOS)
            if Device.isSimulator {
                $0.logFileURL = URL(fileURLWithPath: "/tmp/swiftybeaver.log")
            }
            #endif
            // TODO: Add Watch session to send logs to device
        }))
    }
}

public extension BaseLogger {
    @discardableResult
    func log(file: String = #file,
             function: String = #function,
             line: Int = #line,
             level: LogLevel = .info,
             when: LogWhen = .debugOnly,
             _ items: Any...) -> Self {
        guard !when.shouldSkip else { return self }
        let message = items.joined(by: " ")
        _logger.custom(level: level, message: {
            switch level {
            case .verbose, .error:
                return "\(file.fileNameFull).\(function)[\(line)]\n\(message)"
            default:
                return message
            }
        }())
        return self
    }
    
    @discardableResult
    func log<T>(
        file: String = #file,
        function: String = #function,
        line: Int = #line,
        when: LogWhen = .always,
        error: T
    ) -> Self where T: Error {
        return log(
            file: file,
            function: function,
            line: line,
            level: .error,
            when: when,
            type(of: error), error.localizedDescription
        )
    }
}
