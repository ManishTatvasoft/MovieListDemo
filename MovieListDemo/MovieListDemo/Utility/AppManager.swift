//
//  AppManager.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//

import UIKit


class AppManager{
    static let shared = AppManager()
    static let appDelegate = UIApplication.shared.delegate as! AppDelegate
    var timer: Timer?
    var reachability : Reachability?
    
    func prepareNavigation() {
        AppManager.appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        AppManager.appDelegate.initialViewController = UIStoryboard.main.get(CustomTabarViewController.self)!
        AppManager.appDelegate.customNavigationController = UINavigationController(rootViewController: AppManager.appDelegate.initialViewController)
        AppManager.appDelegate.window?.rootViewController = AppManager.appDelegate.customNavigationController
        AppManager.appDelegate.window?.makeKeyAndVisible()
    }
}
