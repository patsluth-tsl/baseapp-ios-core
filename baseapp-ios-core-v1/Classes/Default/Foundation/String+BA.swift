//
//  String+BA.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-12-19.
//

import Foundation

public extension String {
    var fileName: String {
        var fileName = (self as NSString)
        fileName = (fileName.deletingPathExtension as NSString)
        fileName = (fileName.lastPathComponent as NSString)
        return fileName.removingPercentEncoding ?? (fileName as String)
    }
    
    @available(*, deprecated, renamed: "fileNameFull")
    var fileNameWithExtension: String {
        return fileNameFull
    }
    
    var fileNameFull: String {
        var fileName = (self as NSString)
        fileName = (fileName.lastPathComponent as NSString)
        return fileName.removingPercentEncoding ?? (fileName as String)
    }
    
    var camelCaseToWords: [String] {
        return unicodeScalars.reduce([String]()) {
            var result = $0
            if CharacterSet.uppercaseLetters.contains($1) == true {
                result.append("\($1)")
            } else {
                let last = result.popLast() ?? ""
                result.append("\(last)\($1)")
            }
            return result
        }
    }
    
    var removingPercentEncodingSafe: String {
        return removingPercentEncoding ?? self
    }
    
    var url: URL? {
        return URL(string: self)
    }
    
    var fileURL: URL {
        return URL(fileURLWithPath: self)
    }
    
    
    
    
    
    func removing(charactersNotIn characterSet: CharacterSet) -> String {
        return String(unicodeScalars.filter { characterSet.contains($0) })
    }
}

public extension String {
    static func isEmpty(_ string: String?) -> Bool {
        return (string == nil || string!.isEmpty)
    }
    
    static func format(_ format: String, _ arguments: CVarArg...) -> String {
        return String.format(format, arguments)
    }
    
    static func format(_ format: String, _ arguments: [CVarArg]) -> String {
        return String(format: format, arguments: arguments)
    }
}
