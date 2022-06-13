//
//  DetailsNavigator.swift
//  MovieListDemo
//
//  Created by PCQ229 on 07/06/22.
//

import UIKit

final class DetailsNavigator {
    
    // MARK: - Variables
    private let controller: DetailsViewController
    
    // MARK: - Methods
    init(_ viewController: DetailsViewController) {
        controller = viewController
    }
}

extension DetailsNavigator{
    
    func moveToReview(_ name: String?){
        guard let vc = UIStoryboard.details.get(ReviewViewController.self) else {
            return
        }
        vc.name = name
        self.controller.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToCredits(_ name: String?){
        guard let vc = UIStoryboard.details.get(CreditsViewController.self) else{
            return
        }
        vc.name = name
        self.controller.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToSimilar(_ name: String?){
        guard let vc = UIStoryboard.details.get(SimilarViewController.self) else{
            return
        }
        vc.name = name
        self.controller.navigationController?.pushViewController(vc, animated: true)
    }
    
    func moveToVideo(_ name: String?){
        guard let vc = UIStoryboard.details.get(VideoViewController.self) else{
            return
        }
        vc.name = name
        self.controller.navigationController?.pushViewController(vc, animated: true)
    }
}
    
