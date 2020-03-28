//
//  AppUser+CoreDataClass.swift
//  Chat-0.1
//
//  Created by Sunrise on 28.03.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import Foundation
import CoreData

@objc(AppUser)
public class AppUser: NSManagedObject {
    static func insertAppUser(with id: String, in context: NSManagedObjectContext) -> AppUser? {
        if let appUser = NSEntityDescription.insertNewObject(forEntityName: "AppUser", into: context) as? AppUser {
            appUser.currentUser = User.findOrInserUser(with: id, in: context)
            return appUser
        }
        return nil
    }
    
//    static func findOrInsertAppUser(with id: String, in context: NSManagedObjectContext) -> AppUser? {
//        
//        var appUser: AppUser?
//        let fetchRequest: NSFetchRequest<AppUser> = AppUser.fetchRequest()
//        
//        do {
//            let results = try context.fetch(fetchRequest)
//            //assert(results.count >= 2)
//            appUser = results.first
//        } catch {
//            print("ERRORAOJFPASFOP \(error.localizedDescription)")
//        }
//        
//        if appUser == nil {
//            appUser = self.insertAppUser(with: id, in: context)
//        }
//        return appUser
//    }
}
