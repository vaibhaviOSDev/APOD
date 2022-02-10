//
//  AppDelegate.swift
//  APOD
//
//  Created by Vaibhav Srivastava on 8.2.2022.
//

import UIKit
import CoreData

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        
        self.window = UIWindow(frame: UIScreen.main.bounds)
        
        let navigationController = UINavigationController()
        self.window?.rootViewController = navigationController

        let coordinator = APODCoordinator(navigationController: navigationController)
        coordinator.start()
        
        self.window?.makeKeyAndVisible()
        return true
    }
}

