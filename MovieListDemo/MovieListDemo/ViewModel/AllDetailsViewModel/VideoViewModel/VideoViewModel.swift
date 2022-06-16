//
//  VideoViewModel.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import Foundation



final class VideoViewModel {}

extension VideoViewModel {
    func callVideoListApi(_ completion: @escaping ((_ videoResult:[VideoResults]?,_ isSuccess: Bool,_ errorMessage: String) -> ())) {
        let param = [AppConstants.apiKey: AppConstants.apiKeyValue]
        
        VideoController.shared.getVideoList(parameters: param) { response in
            completion(response.results, true, "")
        } failureCompletion: { failure, errorMessage in
            completion([], false, errorMessage)
        }
    }
}
