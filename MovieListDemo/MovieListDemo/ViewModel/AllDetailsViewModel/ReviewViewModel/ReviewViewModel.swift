//
//  ReviewViewModel.swift
//  MovieListDemo
//
//  Created by PCQ229 on 07/06/22.
//

import Foundation

final class ReviewsViewModel {
    
    var currentPage = 1
    var isAllReviewFetched = false
    private let controller: ReviewViewController
    
    // MARK: - Methods
    init(_ viewController: ReviewViewController) {
        controller = viewController
    }
}

extension ReviewsViewModel{
    func callReviewsListApi(){
        controller.startLoading()
        let param = [AppConstants.apiKey:AppConstants.apiKeyValue,AppConstants.pageKey: "\(currentPage)"]
        ReviewsController.shared.getReviewsList(parameters: param) { [weak self] response in
            guard let self = self else{
                return
            }
            self.controller.stopLoading()
            if response.total_pages == self.currentPage{
                self.isAllReviewFetched = true
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
