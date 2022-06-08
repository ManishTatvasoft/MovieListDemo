//
//  VideoNavigator.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import UIKit

final class VideoNavigator {
    
    // MARK: - Variables
    private let controller: VideoViewController
    
    // MARK: - Methods
    init(_ viewController: VideoViewController) {
        controller = viewController
    }
}

extension VideoNavigator{
    
    func playVideo(from data: VideoResults){
        guard let url = URL(string: AppConstants.youtubeVideoUrl(data.key ?? "")) else{
            controller.showValidationMessage(withMessage: AppConstants.couldNotPlayVideo)
            return
        }
        let vc = UIStoryboard.details.get(PlayerViewController.self)!
        vc.name = data.name
        vc.url = url
        self.controller.navigationController?.pushViewController(vc, animated: true)
    }
    
}
    


