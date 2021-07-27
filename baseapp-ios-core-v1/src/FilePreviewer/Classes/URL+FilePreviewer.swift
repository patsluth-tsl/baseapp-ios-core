//
//  URL+FilePreviewer.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2017-12-08.
//  Copyright © 2017 SilverLogic. All rights reserved.
//

import Foundation
#if os(iOS)
import PDFKit
#endif
import AVKit

#if os(iOS)

// swiftlint:disable:next deployment_target
@available(iOS 11.0, OSX 10.4, *)
internal extension URL {
    var pdfDocument: PDFDocument? {
        return PDFDocument(url: self)
    }
}

#endif
