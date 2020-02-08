//
//  BaseLogger.swift
//  baseapp-ios-core-v1
//
//  Created by Emanuel  Guerrero on 3/7/17.
//  Copyright © 2017 SilverLogic. All rights reserved.
//

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

private let baseLogger = BaseLogger()

public var logger: LogFinalizer {
    return logger()
}

@discardableResult
public func logger(file: String = #file,
                   function: String = #function,
                   line: Int = #line,
                   _ level: LogLevel,
                   _ when: LogWhen) -> LogFinalizer {
    return LogFinalizer({ message in
        guard !when.shouldSkip else { return }
        baseLogger._logger.custom(level: level, message: {
            switch level {
            case .verbose, .error:
                return "\(file.fileNameFull).\(function)[\(line)]\n\t\(message)"
            default:
                return message
            }
        }())
    })
}

@discardableResult
public func logger(file: String = #file,
                   function: String = #function,
                   line: Int = #line,
                   _ level: LogLevel) -> LogFinalizer {
    return logger(file: file, function: function, line: line, level, .debugOnly)
}

@discardableResult
public func logger(file: String = #file,
                   function: String = #function,
                   line: Int = #line,
                   _ when: LogWhen) -> LogFinalizer {
    return logger(file: file, function: function, line: line, .info, when)
}

@discardableResult
public func logger(file: String = #file,
                   function: String = #function,
                   line: Int = #line) -> LogFinalizer {
    return logger(file: file, function: function, line: line, .info, .debugOnly)
}

/// `BaseAppLogger` to log to SwiftyBeaver destinations
public final class BaseLogger {
    fileprivate let _logger: SwiftyBeaver.Type
    //    var logFormat: String = "$DHH:mm:ss$d $C$L$c: $M" {
    //        didSet {
    //            _logger.destinations.forEach({
    //                $0.format = logFormat
    //            })
    //        }
    //    }
    
    fileprivate init() {
        _logger = SwiftyBeaver.self
        let format = "$DHH:mm:ss$d $C$L$c: $M"
        _logger.addDestination(configure(ConsoleDestination(), {
            $0.format = format
        }))
        _logger.addDestination(configure(FileDestination(), {
            $0.format = (ProcessInfo.isRunningUnitTests) ? "$M" : format
            $0.logFileURL = URL(fileURLWithPath: "/tmp/swiftybeaver.log")
        }))
    }
}

public struct LogFinalizer {
    fileprivate let _onLog: (_ message: String) -> Void
    fileprivate init(_ onLog: @escaping (_ message: String) -> Void) {
        _onLog = onLog
    }
}

public extension LogFinalizer {
    @discardableResult
    func log(_ items: Any...) -> LogFinalizer {
        _onLog(items.toString(separatedBy: " "))
        return self
    }
    
    @discardableResult
    func log<E>(
        error: E
    ) -> LogFinalizer where E: Error {
        return log(type(of: error), error.localizedDescription)
    }
}
