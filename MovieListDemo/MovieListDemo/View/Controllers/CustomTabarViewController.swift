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
        upcomingNav.navigationBar.prefersLargeTitles  = true
        let upcomingIcon = UITabBarItem(title: "Upcoming", image: UIImage(systemName: "film"), selectedImage: UIImage(systemName: "film.fill"))
        upcomingVC.tabBarItem = upcomingIcon
        
        let searchVC = UIStoryboard.main.get(SearchViewController.self)!
        let searchNav = UINavigationController(rootViewController: searchVC)
        searchNav.navigationBar.prefersLargeTitles  = true
        let searchIcon = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        searchVC.tabBarItem = searchIcon
        
        let profileVC = UIStoryboard.main.get(ProfileViewController.self)!
        let profileNav = UINavigationController(rootViewController: profileVC)
        profileNav.navigationBar.prefersLargeTitles  = true
        let profileIcon = UITabBarItem(title: "Account", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
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
