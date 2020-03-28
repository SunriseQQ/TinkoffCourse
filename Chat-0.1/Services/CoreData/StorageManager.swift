//
//  StorageManager.swift
//  Chat-0.1
//
//  Created by Sunrise on 28.03.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import UIKit
import CoreData

// NSPersistentStoreCoordinator extension
extension NSPersistentStoreCoordinator {
    
    // NSPersistentStoreCoordinator error types
    public enum CoordinatorError: Error {
        // .momd file not found
        case modelFileNotFound
        // NSManagedObjectModel creation fail
        case modelCreationError
        // Gettings document directory fail
        case storePathNotFound
    }
    
    // Return NSPersistentStoreCoordinator object
    static func coordinator(name: String) throws -> NSPersistentStoreCoordinator? {
        
        guard let modelURL = Bundle.main.url(forResource: name, withExtension: "momd") else {
            throw CoordinatorError.modelFileNotFound
        }
        
        guard let model = NSManagedObjectModel(contentsOf: modelURL) else {
            throw CoordinatorError.modelCreationError
        }
        
        let coordinator = NSPersistentStoreCoordinator(managedObjectModel: model)
        
        guard let documents = FileManager.default.urls(for: .documentDirectory, in: .userDomainMask).last else {
            throw CoordinatorError.storePathNotFound
        }
        
        do {
            let url = documents.appendingPathComponent("\(name).sqlite")
            let options = [ NSMigratePersistentStoresAutomaticallyOption : true,
                            NSInferMappingModelAutomaticallyOption : true ]
            try coordinator.addPersistentStore(ofType: NSSQLiteStoreType, configurationName: nil, at: url, options: options)
        } catch {
            throw error
        }
        
        return coordinator
    }
}

class StorageManager: StorageManagerProtocol {
    
    static var shared = StorageManager()
    
    @available(iOS 10.0, *)
    private lazy var persistentContainer: NSPersistentContainer = {
        let container = NSPersistentContainer(name: "Chat-0.1")
        container.loadPersistentStores { (storeDescription, error) in
            print("CoreData: Inited \(storeDescription)")
            guard error == nil else {
                print("CoreData: Unresolved error \(String(describing: error))")
                return
            }
        }
        return container
    }()
    
    //coreDataStack object 
    private lazy var persistentStoreCoordinator: NSPersistentStoreCoordinator? = {
        do {
            return try NSPersistentStoreCoordinator.coordinator(name: "Chat-0.1")
        } catch {
            print("CoreData: Unresolved error \(error)")
        }
        return nil
    }()
    
    lazy var masterContext: NSManagedObjectContext = {
        let coordinator = self.persistentStoreCoordinator
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.persistentStoreCoordinator = coordinator
        return managedObjectContext
    }()
    
    lazy var mainContext: NSManagedObjectContext = {
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .mainQueueConcurrencyType)
        managedObjectContext.parent = masterContext
        return managedObjectContext
    }()
    
    lazy var privateContext: NSManagedObjectContext = {
        var managedObjectContext = NSManagedObjectContext(concurrencyType: .privateQueueConcurrencyType)
        managedObjectContext.parent = mainContext
        return managedObjectContext
    }()
    
    // MARK: Public methods
    
    enum SaveStatus {
        case saved, rolledBack, hasNoChanges
    }
    
    var context: NSManagedObjectContext {
        get {
            if #available(iOS 10.0, *) {
                return persistentContainer.viewContext
            } else {
                return masterContext
            }
        }
    }
    
    func save() -> SaveStatus {
        if context.hasChanges {
            do {
                try context.save()
                return .saved
            } catch {
                context.rollback()
                return .rolledBack
            }
        }
        return .hasNoChanges
    }
    
    func performSave(context: NSManagedObjectContext, completionHandler: @escaping (Bool) -> Void) {
           if !context.hasChanges {
               completionHandler(false)
               return
           }
           
           context.perform {
               do {
                   try context.save()
               } catch {
                   print("err")
               }
               
               if let parent = context.parent {
                   self.performSave(context: parent, completionHandler: completionHandler)
               } else {
                   completionHandler(true)
               }
           }

       }
    
    
     func findOrInsertAppUser(with id: String, in context: NSManagedObjectContext) -> AppUser? {
        
        var appUser: AppUser?
        let fetchRequest: NSFetchRequest<AppUser> = AppUser.fetchRequest()
        
        do {
            let results = try context.fetch(fetchRequest)
            //assert(results.count >= 2)
            appUser = results.first
        } catch {
            print("ERRORAOJFPASFOP \(error.localizedDescription)")
        }
        
        if appUser == nil {
            appUser = AppUser.insertAppUser(with: id, in: context)
        }
        
        return appUser
    }
}


extension StorageManager {
    
    var appUser: AppUser? {
        let request: NSFetchRequest<AppUser> = AppUser.fetchRequest()
        let results = try? self.mainContext.fetch(request)
        return results?.first
    }
   
    
}

