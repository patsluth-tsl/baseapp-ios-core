//
// NSManagedObject+BA.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-11-14.
//  Copyright © 2019 Pat Sluth. All rights reserved.
//

import CoreData

public extension NSManagedObject {
    static func entity(for context: NSManagedObjectContext?) -> NSEntityDescription {
        let entityName = NSStringFromClass(Self.self)
        let model = context?.persistentStoreCoordinator?.managedObjectModel
        let entity = model?.entities.first(where: { $0.managedObjectClassName == entityName })
        return entity ?? Self.entity()
    }
}
