//
//  SimilarNavigator.swift
//  MovieListDemo
//
//  Created by PCQ229 on 09/06/22.
//

import UIKit

final class SimilarNavigator {
    
    // MARK: - Variables
    private let controller: SimilarViewController
    
    // MARK: - Methods
    init(_ viewController: SimilarViewController) {
        controller = viewController
    }
}

extension SimilarNavigator{
    
    func moveToMovieDetailScreen(with Data: Results){
        let vc = UIStoryboard.details.get(DetailsViewController.self)!
        vc.data = Data
        self.controller.navigationController?.pushViewController(vc, animated: true)
    }
    
}
