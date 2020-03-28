//
//  User+CoreDataProperties.swift
//  Chat-0.1
//
//  Created by Sunrise on 28.03.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import Foundation
import CoreData
import UIKit

extension User {

    @nonobjc public class func fetchRequest() -> NSFetchRequest<User> {
        return NSFetchRequest<User>(entityName: "User")
    }

    @NSManaged public var name: String?
    @NSManaged public var information: String?
    @NSManaged public var image: UIImage?
    @NSManaged public var appUser: AppUser?
    
}
