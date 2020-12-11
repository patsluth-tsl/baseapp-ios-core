//
//  FileDownloader.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-10-08.
//  Copyright © 2017 patsluth. All rights reserved.
//

#if os(iOS)

import Alamofire
import CancelForPromiseKit
import Foundation


public final class FileDownloader: NSObject {
    public static let shared = FileDownloader()
    
    private override init() {
    }
    
    public func download(
        fileAt url: URL,
        andSaveIn directoryURL: URL,
        overwriteExisting: Bool = false,
        onProgress: DownloadRequest.ProgressHandler? = nil
    ) -> CancellablePromise<URL> {
        return download(
            fileAt: url,
            andSaveTo: directoryURL.appendingPathComponent(url.fileNameFull),
            overwriteExisting: overwriteExisting,
            onProgress: onProgress
        )
    }
    
    public func download(
        fileAt url: URL,
        andSaveTo fileURL: URL,
        overwriteExisting: Bool = false,
        onProgress: DownloadRequest.ProgressHandler? = nil
    ) -> CancellablePromise<URL> {
        return self.download(
            Alamofire.download(url, to: { _, _ in
                return (fileURL, [
                    DownloadRequest.DownloadOptions.createIntermediateDirectories
                ])
            }),
            andSaveTo: fileURL,
            overwriteExisting: overwriteExisting,
            onProgress: onProgress
        )
    }
}
    
    
public extension FileDownloader {
    func download(
        _ downloadRequest: DownloadRequest,
        andSaveTo fileURL: URL,
        overwriteExisting: Bool = false,
        onProgress: DownloadRequest.ProgressHandler? = nil
    ) -> CancellablePromise<URL> {
        if !overwriteExisting && (fileURL.isReachableFile && fileURL.fileSize > 0) {
            return CancellablePromise<URL>.valueCC(fileURL)
        }
        
        try? FileManager.default.removeItem(at: fileURL)
        
        downloadRequest.downloadProgress(closure: { progress in
            onProgress?(progress)
        })
        
        return downloadRequest
            .responseDataCC()
            .map({ response -> URL in
                switch response.result {
                case .success(let data):
                    guard let destinationURL = response.destinationURL else {
                        throw PMKError.cancelled
                    }
                    try data.write(to: destinationURL)
                    return destinationURL
                case .failure(let error):
                    throw error
                }
            })
            .recover(policy: .allErrors, { error -> CancellablePromise<URL> in
                logger.log(error: error)
                try? FileManager.default.removeItem(at: fileURL)
                throw error
            })
    }
}

#endif
