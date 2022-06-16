//
//  AppManager.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//

import UIKit


class AppManager {
    
    static let shared = AppManager()
    static let appDelegate = UIApplication.shared.delegate as? AppDelegate
    var timer: Timer?
    var reachability: Reachability?
    var genre: Genre?
    
    func prepareNavigation() {
        guard let appDelegate = AppManager.appDelegate else {
            return
        }
        guard let tabbar = UIStoryboard.main.get(CustomTabarViewController.self) else {
            return
        }
        appDelegate.window = UIWindow(frame: UIScreen.main.bounds)
        appDelegate.initialViewController = tabbar
        appDelegate.customNavigationController = UINavigationController(rootViewController: appDelegate.initialViewController)
        appDelegate.window?.rootViewController = appDelegate.customNavigationController
        appDelegate.window?.makeKeyAndVisible()
    }
    
    func setupGenre(){
        let param = [AppConstants.apiKey: AppConstants.apiKeyValue]
        DetailsController.shared.getGenreList(parameters: param) { [weak self] response in
            guard let self = self else {
                return
            }
            self.genre = response
        } failureCompletion: { [weak self] failure, errorMessage in
            guard let self = self else {
                return
            }
            self.genre = nil
        }
    }
}
