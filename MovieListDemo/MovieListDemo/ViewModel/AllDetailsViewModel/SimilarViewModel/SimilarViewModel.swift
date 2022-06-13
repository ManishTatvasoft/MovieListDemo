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
        SimilarController.shared.getSimilarMovieList(parameters: param) { [weak self] response in
            guard let self = self else{
                return
            }
            
            self.controller.stopLoading()
            self.isSecondTimeFetching = true
            if response.total_pages == self.currentPage{
                self.isAllMovieFetched = true
            }
            self.controller.successApiResponse(response.results)
        } failureCompletion: { [weak self] failure, errorMessage in
            guard let self = self else{
                return
            }
            self.controller.stopLoading()
            DispatchQueue.main.async {
                self.controller.showValidationMessage(withMessage: errorMessage)
            }
        }
    }
}
