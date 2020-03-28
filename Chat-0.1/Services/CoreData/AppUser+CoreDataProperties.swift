//
//  AppUser+CoreDataProperties.swift
//  Chat-0.1
//
//  Created by Sunrise on 28.03.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import Foundation
import CoreData


extension AppUser {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<AppUser> {
        return NSFetchRequest<AppUser>(entityName: "AppUser")
    }

    @NSManaged public var currentUser: User?

}
