//
//  SimilarViewModel.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import Foundation
final class SimilarViewModel {
    
    var currentPage = 1
    var isAllMovieFetched = false
    
    private let controller: SimilarViewController
    
    // MARK: - Methods
    init(_ viewController: SimilarViewController) {
        controller = viewController
    }
}

extension SimilarViewModel{
    func callSimilarMovieApi(){
        controller.startLoading()
        let param = [AppConstants.apiKey: AppConstants.apiKeyValue, AppConstants.pageKey: "\(currentPage)"]
        SimilarController.shared.getSimilarMovieList(parameters: param) { response in
            self.controller.stopLoading()
            if response.total_pages == self.currentPage{
                self.isAllMovieFetched = true
            }
            self.controller.successApiResponse(response.results)
        } failureCompletion: { failure, errorMessage in
            self.controller.stopLoading()
            DispatchQueue.main.async {
                self.controller.showValidationMessage(withMessage: errorMessage)
            }
        }

    }
}
