//
//  NSManagedObjectContext+BA.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-11-14.
//  Copyright © 2019 SilverLogic. All rights reserved.
//

import CoreData

extension NSManagedObjectContext {
    func fetchFirst<T>(_ request: NSFetchRequest<T>) throws -> T?
        where T: NSFetchRequestResult {
            return try fetch(request).first
    }
}
