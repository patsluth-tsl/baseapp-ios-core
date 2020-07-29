//
//  DateInRegion.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-04-04.
//

import Foundation
import SwiftDate

public extension DateInRegion {
    /// String representation of date in provided region, defaults to current device region.
    func toString(_ format: String, _ region: Region = Region.local) -> String {
        if self.region == region {
            return toFormat(format, locale: region.locale)
        } else {
            return convertTo(region: region).toFormat(format, locale: region.locale)
        }
    }
}
