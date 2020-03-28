//
//  StorageManagerProtocol.swift
//  Chat-0.1
//
//  Created by Sunrise on 28.03.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import Foundation
import CoreData

protocol StorageManagerProtocol {
    func performSave(context: NSManagedObjectContext, completionHandler: @escaping (Bool) -> Void)
    func findOrInsertAppUser(with id: String, in context: NSManagedObjectContext) -> AppUser?
}
