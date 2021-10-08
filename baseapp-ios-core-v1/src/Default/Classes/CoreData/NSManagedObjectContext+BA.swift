//
//  NSManagedObjectContext+BA.swift
//  baseapp-ios-core-v1
//
//  Created by Pat Sluth on 2019-11-14.
//  Copyright © 2019 SilverLogic. All rights reserved.
//

import CoreData

public extension NSManagedObjectContext {
    func fetchFirst<T>(_ request: NSFetchRequest<T>) throws -> T?
        where T: NSFetchRequestResult {
            return try fetch(request).first
    }
    
    func perform(_ block: @escaping (NSManagedObjectContext) -> Void) {
        perform({ [weak self] in
            guard let self = self else { return }
            block(self)
        })
    }
    
    func performAndWait(_ block: (NSManagedObjectContext) -> Void) {
        performAndWait({ [weak self] in
            guard let self = self else { return }
            block(self)
        })
    }
    
    func performAndWait<T>(_ block: (NSManagedObjectContext) throws -> T) throws -> T {
        var result: Swift.Result<T, Error>!
        performAndWait({
            do {
                result = .success(try block(self))
            } catch {
                result = .failure(error)
            }
        })
        return try result.get()
    }
}
