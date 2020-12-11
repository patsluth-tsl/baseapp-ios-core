//
//  URL+BA.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-12-08.
//  Copyright © 2017 Pat Sluth. All rights reserved.
//

import AVFoundation
import AVKit
import Foundation

public extension URL {
    var uti: String? {
        return (try? resourceValues(forKeys: [URLResourceKey.typeIdentifierKey]))?.typeIdentifier
    }
    
    func isFileTypeOf(_ pathExtension: String) -> Bool {
        guard isFileURL else { return false }
        return (pathExtension.lowercased() == pathExtension.lowercased())
    }
    
    func isReachableFileTypeOf(_ pathExtension: String) -> Bool {
        return (isReachableFile && isFileTypeOf(pathExtension))
    }
    
    var fileName: String {
        if hasDirectoryPath {
            return lastPathComponent.removingPercentEncodingSafe
        }
        return deletingPathExtension().lastPathComponent.removingPercentEncodingSafe
    }
    
    @available(*, deprecated, renamed: "fileNameFull")
    var fileNameWithExtension: String {
        return fileNameFull
    }
    
    var fileNameFull: String {
        if hasDirectoryPath {
            return lastPathComponent.removingPercentEncodingSafe
        }
        return lastPathComponent.removingPercentEncodingSafe
    }
    
    var isFile: Bool {
        return !isDirectory
    }
    
    var isDirectory: Bool {
        return hasDirectoryPath
    }
    
    var isReachable: Bool {
        //        guard let _ = try? self.checkResourceIsReachable() else { return false }
        //        return true
        guard let filePath = absoluteURL.path.removingPercentEncoding else { return false }
        return FileManager.default.fileExists(atPath: filePath)
    }
    
    var isReachableFile: Bool {
        return isFile && isReachable
    }
    
    var isReachableDirectory: Bool {
        return isDirectory && isReachable
    }
    
    var isImageURL: Bool {
        return mime.contentType.lowercased().starts(with: "image")
    }
    
    var isVideoURL: Bool {
        guard let uti = uti else {
            return AVURLAsset.audiovisualMIMETypes().contains(mime.contentType)
        }
        
        return AVURLAsset.audiovisualTypes().contains(AVFileType(uti))
    }
    
    var isPDFURL: Bool {
        return mime.contentType.lowercased().contains("pdf")
    }
    
    var fileAttributes: [FileAttributeKey: Any]? {
        return try? FileManager.default.attributesOfItem(atPath: absoluteURL.path)
    }
    
    var fileSize: Int64 {
        return fileAttributes?[.size] as? Int64 ?? 0
    }
}
