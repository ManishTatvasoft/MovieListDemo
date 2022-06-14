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
        guard let vc = UIStoryboard.searchDetails.get(DiscoverViewController.self)else{
            return
        }
        vc.genre = genre
        vc.discoverType = .genre
        self.controller.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToDiscover(withDiscover type: DiscoverType){
        guard let vc = UIStoryboard.searchDetails.get(DiscoverViewController.self)else{
            return
        }
        vc.discoverType = type
        self.controller.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToMovieDetailScreen(with Data: Results?, isDBData: Bool = false, genre: String = ""){
        guard let vc = UIStoryboard.details.get(DetailsViewController.self)else{
            return
        }
        vc.data = Data
        vc.isDBData = isDBData
        vc.genre = genre
        self.controller.navigationController?.pushViewController(vc, animated: true)
    }
}
