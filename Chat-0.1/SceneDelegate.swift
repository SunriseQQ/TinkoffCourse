//
//  SceneDelegate.swift
//  Chat-0.1
//
//  Created by Sunrise on 13.02.2020.
//  Copyright © 2020 Sunrise. All rights reserved.
//
//Так как в iOS 13 жизненный цикл немного отличается от других версий, данная реализация не является верной, а лишь имитирует логирование подобное прошлым версиям
import UIKit



class SceneDelegate: UIResponder, UIWindowSceneDelegate {

    var window: UIWindow?


    @available(iOS 13.0, *)
    func scene(_ scene: UIScene, willConnectTo session: UISceneSession, options connectionOptions: UIScene.ConnectionOptions) {
        if doYouWannaHaveLogs {
            print("Application moved from <Non running> to <Inactive>: \(#function)")
        }
        
        // Use this method to optionally configure and attach the UIWindow `window` to the provided UIWindowScene `scene`.
        // If using a storyboard, the `window` property will automatically be initialized and attached to the scene.
        // This delegate does not imply the connecting scene or session are new (see `application:configurationForConnectingSceneSession` instead).
        guard let _ = (scene as? UIWindowScene) else { return }
    }

    @available(iOS 13.0, *)
    func sceneDidDisconnect(_ scene: UIScene) {
        if doYouWannaHaveLogs {
            print("Application moved from <Background> to <Suspended>: \(#function)")
        }
        // Called as the scene is being released by the system.
        // This occurs shortly after the scene enters the background, or when its session is discarded.
        // Release any resources associated with this scene that can be re-created the next time the scene connects.
        // The scene may re-connect later, as its session was not neccessarily discarded (see `application:didDiscardSceneSessions` instead).
        print(#function)
    }

    @available(iOS 13.0, *)
    func sceneDidBecomeActive(_ scene: UIScene) {
        if doYouWannaHaveLogs {
            print("Application moved from <Inactive> to <Active>: \(#function)")
        }
        // Called when the scene has moved from an inactive state to an active state.
        // Use this method to restart any tasks that were paused (or not yet started) when the scene was inactive.
    }

    @available(iOS 13.0, *)
    func sceneWillResignActive(_ scene: UIScene) {
        if doYouWannaHaveLogs {
            print("Application moved from <Active> to <Inactive>: \(#function)")
        }
        // Called when the scene will move from an active state to an inactive state.
        // This may occur due to temporary interruptions (ex. an incoming phone call).
    }

    @available(iOS 13.0, *)
    func sceneWillEnterForeground(_ scene: UIScene) {
        if doYouWannaHaveLogs {
            print("Application moved from <Background> to <Inactive>: \(#function)")
        }
        // Called as the scene transitions from the background to the foreground.
        // Use this method to undo the changes made on entering the background.
    }

    @available(iOS 13.0, *)
    func sceneDidEnterBackground(_ scene: UIScene) {
        if doYouWannaHaveLogs {
            print("Application moved from <Inactive> to <Background>: \(#function)")
        }
        // Called as the scene transitions from the foreground to the background.
        // Use this method to save data, release shared resources, and store enough scene-specific state information
        // to restore the scene back to its current state.

        // Save changes in the application's managed object context when the application transitions to the background.
        (UIApplication.shared.delegate as? AppDelegate)?.saveContext()
    }


}

