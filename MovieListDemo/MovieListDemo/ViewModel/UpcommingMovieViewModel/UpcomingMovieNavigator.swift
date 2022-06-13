//
//  UpcomingMovieNavigator.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//

import UIKit
final class UpcomingMovieNavigator {
    
    // MARK: - Variables
    private let controller: UpcomingViewController
    
    // MARK: - Methods
    init(_ viewController: UpcomingViewController) {
        controller = viewController
    }
}

extension UpcomingMovieNavigator{
    
    func moveToCharecterListScreen(with Data: Results){
        guard let vc = UIStoryboard.details.get(DetailsViewController.self)else{
            return
        }
        vc.data = Data
        self.controller.navigationController?.pushViewController(vc, animated: true)
    }
    
}
