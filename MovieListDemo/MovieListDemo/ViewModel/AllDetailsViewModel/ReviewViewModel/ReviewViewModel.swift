//
//  ReviewViewModel.swift
//  MovieListDemo
//
//  Created by PCQ229 on 07/06/22.
//

import Foundation

final class ReviewsViewModel {
    
    private var currentPage = 1
    var isAllReviewFetched = false
}

extension ReviewsViewModel{
    func callReviewsListApi(_ completion: @escaping ((_ results:[ReviewResults]?,_ isSuccess: Bool,_ errorMessage: String) -> ())){
        let param = [AppConstants.apiKey:AppConstants.apiKeyValue,AppConstants.pageKey: "\(currentPage)"]
        ReviewsController.shared.getReviewsList(parameters: param) { [weak self] response in
            guard let self = self else{
                completion([], false, String.Title.somthingWentWrong)
                return
            }
            if response.total_pages == self.currentPage{
                self.isAllReviewFetched = true
            }else{
                self.currentPage += 1
            }
            completion(response.results, true, "")
        } failureCompletion: { failure, errorMessage in
            completion([], false, errorMessage)
        }
    }
}
