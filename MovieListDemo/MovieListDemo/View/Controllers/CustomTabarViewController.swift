//
//  CustomTabarViewController.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//

import UIKit

class CustomTabarViewController: UITabBarController {

    override func viewDidLoad() {
        super.viewDidLoad()
        delegate = self
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.setNavigationBarHidden(true, animated: false)
        let upcomingVC = UIStoryboard.main.get(UpcomingViewController.self)!
        let upcomingNav = UINavigationController(rootViewController: upcomingVC)
        let upcomingIcon = UITabBarItem(title: "Upcoming", image: UIImage.universalImage("film"), selectedImage: UIImage.universalImage("film.fill"))
        upcomingVC.tabBarItem = upcomingIcon
        
        let searchVC = UIStoryboard.main.get(SearchViewController.self)!
        let searchNav = UINavigationController(rootViewController: searchVC)
        let searchIcon = UITabBarItem(title: "Search", image: UIImage.universalImage("magnifyingglass"), selectedImage: UIImage.universalImage("magnifyingglass.circle.fill"))
        searchVC.tabBarItem = searchIcon
        
        let profileVC = UIStoryboard.main.get(ProfileViewController.self)!
        let profileNav = UINavigationController(rootViewController: profileVC)
        let profileIcon = UITabBarItem(title: "Account", image: UIImage.universalImage("person"), selectedImage: UIImage.universalImage("person.fill"))
        profileVC.tabBarItem = profileIcon
        
        let controllers = [upcomingNav, searchNav, profileNav]
        self.viewControllers = controllers
        self.title = self.viewControllers?[selectedIndex].title
        self.navigationController?.setNavigationBarHidden(true, animated: false)
    }

}


extension CustomTabarViewController: UITabBarControllerDelegate{
    func tabBarController(_ tabBarController: UITabBarController, shouldSelect viewController: UIViewController) -> Bool {
        return true
    }
    
}
