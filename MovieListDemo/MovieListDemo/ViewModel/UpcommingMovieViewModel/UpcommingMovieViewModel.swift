//
//  UpcommingMovieViewModel.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//

import Foundation

final class UpcommingMovieViewModel {
    
    var currentPage = 1
    var isAllMovieFetched = false
    var isListView = false
    
    private let controller: UpcomingViewController
    
    // MARK: - Methods
    init(_ viewController: UpcomingViewController) {
        controller = viewController
    }
}

extension UpcommingMovieViewModel{
    func callUpcomingMovieApi(){
        controller.startLoading()
        let param = ["api_key":"0141e6d543b187f0b7e6bb3a1902209a", "page": "\(currentPage)"]
        UpcomingMovieController.shared.getUpcomingMovieList(parameters: param) { response in
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
