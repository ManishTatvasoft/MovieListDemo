//
//  AppDelegate.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//

import UIKit

@main
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?
    var customNavigationController = UINavigationController()
    var initialViewController = UIViewController()

    func application(_ application: UIApplication, didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?) -> Bool {
        // Override point for customization after application launch.
        DatabaseManager.shared.createDatabase()
        AppManager.shared.prepareNavigation()
        AppManager.shared.setupGenre()
        return true
    }

}

