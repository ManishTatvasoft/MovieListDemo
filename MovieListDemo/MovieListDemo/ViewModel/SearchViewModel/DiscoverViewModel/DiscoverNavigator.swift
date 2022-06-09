//
//  DiscoverNavigator.swift
//  MovieListDemo
//
//  Created by PCQ229 on 09/06/22.
//

import UIKit

final class DiscoverNavigator {
    
    // MARK: - Variables
    private let controller: DiscoverViewController
    
    // MARK: - Methods
    init(_ viewController: DiscoverViewController) {
        controller = viewController
    }
}

extension DiscoverNavigator{
    
    func moveToMovieDetailScreen(with Data: Results){
        let vc = UIStoryboard.details.get(DetailsViewController.self)!
        vc.data = Data
        self.controller.navigationController?.pushViewController(vc, animated: true)
    }
    
}
