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
    var isSecondTimeFetching = false
    
    private let controller: SimilarViewController
    
    // MARK: - Methods
    init(_ viewController: SimilarViewController) {
        controller = viewController
    }
}

extension SimilarViewModel{
    func callSimilarMovieApi(){
        
        if !isSecondTimeFetching{
            controller.startLoading()
        }
        let param = [AppConstants.apiKey: AppConstants.apiKeyValue, AppConstants.pageKey: "\(currentPage)"]
        SimilarController.shared.getSimilarMovieList(parameters: param) { response in
            
            self.controller.stopLoading()
            self.isSecondTimeFetching = true
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
