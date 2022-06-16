//
//  SimilarViewModel.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import Foundation
final class SimilarViewModel {
    
    private var currentPage = 1
    var isAllMovieFetched = false
}

extension SimilarViewModel {
    func callSimilarMovieApi(_ completion: @escaping ((_ results:[Results]?,_ isSuccess: Bool,_ errorMessage: String) -> ())) {
        
        let param = [AppConstants.apiKey: AppConstants.apiKeyValue, AppConstants.pageKey: "\(currentPage)"]
        
        SimilarController.shared.getSimilarMovieList(parameters: param) { [weak self] response in
            guard let self = self else {
                completion([], false, String.Title.somthingWentWrong)
                return
            }
            if response.total_pages == self.currentPage {
                self.isAllMovieFetched = true
            } else {
                self.currentPage += 1
            }
            completion(response.results, true, "")
        } failureCompletion: { failure, errorMessage in
            completion([], false, errorMessage)
        }
    }
}
