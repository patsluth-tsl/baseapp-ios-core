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
    
    public var debugOnly: Self? {
        #if DEBUG
        return self
        #endif
        return nil
    }
    
    fileprivate init() {
        _logger = SwiftyBeaver.self
        _logger.removeAllDestinations()
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
    @available(*, deprecated, message: "Use logger.debugOnly?.log()")
    func log(file: String = #file,
             function: String = #function,
             line: Int = #line,
             level: LogLevel = .info,
             when: LogWhen = .debugOnly,
             _ items: Any...
    ) -> Self {
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
    
    func log(
        file: String = #file,
        function: String = #function,
        line: Int = #line,
        _ level: LogLevel,
        _ items: Any...
    ) {
        let message = items.joined(by: " ")
        _logger.custom(level: level, message: {
            switch level {
            case .verbose, .error:
                return "\(file.fileNameFull).\(function)[\(line)]\n\(message)"
            default:
                return message
            }
        }())
    }
    
    func verbose(
        file: String = #file,
        function: String = #function,
        line: Int = #line,
        _ items: Any...
    ) {
        log(file: file, function: function, line: line,
            level: .verbose, items)
    }
    
    func debug(
        file: String = #file,
        function: String = #function,
        line: Int = #line,
        _ items: Any...
    ) {
        log(file: file, function: function, line: line,
            level: .debug, items)
    }
    
    func info(
        file: String = #file,
        function: String = #function,
        line: Int = #line,
        _ items: Any...
    ) {
        log(file: file, function: function, line: line,
            level: .info, items)
    }
    
    func warning(
        file: String = #file,
        function: String = #function,
        line: Int = #line,
        _ items: Any...
    ) {
        log(file: file, function: function, line: line,
            level: .warning, items)
    }
    
    func error<T>(
        file: String = #file,
        function: String = #function,
        line: Int = #line,
        _ error: T
    ) where T: Error {
        log(file: file, function: function, line: line,
            level: .error, type(of: error), error.localizedDescription)
    }
}
