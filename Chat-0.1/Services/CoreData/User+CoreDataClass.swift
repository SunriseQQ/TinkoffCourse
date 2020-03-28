//
//  User+CoreDataClass.swift
//  Chat-0.1
//
//  Created by Sunrise on 28.03.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import Foundation
import CoreData

@objc(User)
public class User: NSManagedObject {
    
    static func insertUser(with id: String, in context: NSManagedObjectContext) -> User? {
        return NSEntityDescription.insertNewObject(forEntityName: "User", into: context) as? User
    }
    
    static func findOrInserUser(with id: String, in context: NSManagedObjectContext) -> User? {
        
        var user: User?
        let fetchRequest: NSFetchRequest<User> = User.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            assert(results.count < 2)
            user = results.first
        } catch {
            print("ERROR: \(error.localizedDescription)")
        }
        
        if user == nil {
            user = self.insertUser(with: id, in: context)
        }
        
        return user
    }
}
