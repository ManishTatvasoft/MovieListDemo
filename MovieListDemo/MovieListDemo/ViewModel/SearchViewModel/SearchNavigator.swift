//
//  SearchNavigator.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import UIKit
final class SearchNavigator {
    
    // MARK: - Variables
    private let controller: SearchViewController
    
    // MARK: - Methods
    init(_ viewController: SearchViewController) {
        controller = viewController
    }
}

extension SearchNavigator{
    func moveToDiscover(with genre: Genres?, withDiscover type: DiscoverType){
        let vc = UIStoryboard.searchDetails.get(DiscoverViewController.self)!
        vc.genre = genre
        vc.discoverType = .genre
        self.controller.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToDiscover(withDiscover type: DiscoverType){
        let vc = UIStoryboard.searchDetails.get(DiscoverViewController.self)!
        vc.discoverType = type
        self.controller.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToMovieDetailScreen(with Data: Results){
        let vc = UIStoryboard.details.get(DetailsViewController.self)!
        vc.data = Data
        self.controller.navigationController?.pushViewController(vc, animated: true)
    }
}
