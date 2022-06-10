//
//  AppDelegate.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//

import UIKit

let SharedAppDelegate = UIApplication.shared.delegate as! AppDelegate


@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var customNavigationController = UINavigationController()
    var initialViewController = UIViewController()



    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        DatabaseManager.shared.createDatabase()
        if #available(iOS 13.0, *){
            
        }else{
            SharedAppDelegate.window = UIWindow(frame: UIScreen.main.bounds)
            SharedAppDelegate.initialViewController = UIStoryboard.main.get(CustomTabarViewController.self)!
            SharedAppDelegate.customNavigationController = UINavigationController(rootViewController: SharedAppDelegate.initialViewController)
            SharedAppDelegate.window?.rootViewController = SharedAppDelegate.customNavigationController
            SharedAppDelegate.window?.makeKeyAndVisible()
        }
        return true
    }

    // MARK: UISceneSession Lifecycle

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, configurationForConnecting connectingSceneSession: UISceneSession, options: UIScene.ConnectionOptions) -> UISceneConfiguration {
        // Called when a new scene session is being created.
        // Use this method to select a configuration to create the new scene with.
        return UISceneConfiguration(name: "Default Configuration", sessionRole: connectingSceneSession.role)
    }

    @available(iOS 13.0, *)
    func application(_ application: UIApplication, didDiscardSceneSessions sceneSessions: Set<UISceneSession>) {
        // Called when the user discards a scene session.
        // If any sessions were discarded while the application was not running, this will be called shortly after application:didFinishLaunchingWithOptions.
        // Use this method to release any resources that were specific to the discarded scenes, as they will not return.
    }


}

