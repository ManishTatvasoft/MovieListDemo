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
        let upcomingVC = UpcomingViewController()
        let upcomingIcon = UITabBarItem(title: "Upcoming", image: UIImage(systemName: "film"), selectedImage: UIImage(systemName: "film.fill"))
        upcomingVC.tabBarItem = upcomingIcon
        
        let searchVC = SearchViewController()
        let searchIcon = UITabBarItem(title: "Search", image: UIImage(systemName: "magnifyingglass"), selectedImage: UIImage(systemName: "magnifyingglass.circle.fill"))
        searchVC.tabBarItem = searchIcon
        
        let profileVC = ProfileViewController()
        let profileIcon = UITabBarItem(title: "Account", image: UIImage(systemName: "person"), selectedImage: UIImage(systemName: "person.fill"))
        profileVC.tabBarItem = profileIcon
        
        let controllers = [upcomingVC, searchVC, profileVC]
        self.viewControllers = controllers
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
