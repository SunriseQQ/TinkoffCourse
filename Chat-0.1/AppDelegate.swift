//
//  AppDelegate.swift
//  Chat-0.1
//
//  Created by Sunrise on 13.02.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//

import UIKit
import CoreData


@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {
    
        var window: UIWindow?

    
    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        if #available(iOS 13, *) {
            return true
        } else {
            if doYouWannaHaveLogs {
                print("Application moved from <Non running> to <Inactive>: \(#function)")
            }
        // Override point for customization after application launch.
            return true
        }
    }
  


    // MARK: UISceneSession Lifecycle

    func applicationWillResignActive(_ application: UIApplication) {
        if doYouWannaHaveLogs {
            print("Application moved from <Active> to <Inactive>: \(#function)")
        }
    }
    func applicationDidBecomeActive(_ application: UIApplication) {
        if doYouWannaHaveLogs {
            print("Application moved from <Inactive> to <Active>: \(#function)")
        }
    }
    func applicationDidEnterBackground(_ application: UIApplication) {
        if doYouWannaHaveLogs {
            print("Application moved from <Inactive> to <Background>: \(#function)")
            /* Так же тут может происходить переход в Suspended
             в случае отсутсвия фоновой работы приложение, что и
             является причиной отсутствия вызова
             applicationWillTerminate, подразумевая наличие  */
        }
    }
    func applicationWillEnterForeground(_ application: UIApplication) {
        if doYouWannaHaveLogs {
            print("Application moved from <Background> to <Inactive>: \(#function)")
            
        }
    }
    
    func applicationWillTerminate(_ application: UIApplication) {
        if doYouWannaHaveLogs {
           print("Application moved from <Background> to <Suspended>: \(#function)")
            /* В случае выхода из окна выбора приложений или выбора
             другого приложения с последующим закрытием нашего
             метод не буден вызван */
        }

    }
    
    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        if doYouWannaHaveLogs {
            print("Application moved from <Background> to <Suspended>: \(#function)")
        }
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }

    // MARK: - Core Data stack

    lazy var persistentContainer: NSPersistentContainer = {
        /*
         The persistent container for the application. This implementation
         creates and returns a container, having loaded the store for the
         application to it. This property is optional since there are legitimate
         error conditions that could cause the creation of the store to fail.
        */
        let container = NSPersistentContainer(name: "Chat_0_1")
        container.loadPersistentStores(completionHandler: { (storeDescription, error) in
            if let error = error as NSError? {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                 
                /*
                 Typical reasons for an error here include:
                 * The parent directory does not exist, cannot be created, or disallows writing.
                 * The persistent store is not accessible, due to permissions or data protection when the device is locked.
                 * The device is out of space.
                 * The store could not be migrated to the current model version.
                 Check the error message to determine what the actual problem was.
                 */
                fatalError("Unresolved error \(error), \(error.userInfo)")
            }
        })
        return container
    }()

    // MARK: - Core Data Saving support

    func saveContext () {
        let context = persistentContainer.viewContext
        if context.hasChanges {
            do {
                try context.save()
            } catch {
                // Replace this implementation with code to handle the error appropriately.
                // fatalError() causes the application to generate a crash log and terminate. You should not use this function in a shipping application, although it may be useful during development.
                let nserror = error as NSError
                fatalError("Unresolved error \(nserror), \(nserror.userInfo)")
            }
        }
    }

}

