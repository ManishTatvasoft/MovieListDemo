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
    var isSecondTimeFetching = false
    
    private let controller: UpcomingViewController
    
    // MARK: - Methods
    init(_ viewController: UpcomingViewController) {
        controller = viewController
    }
}

extension UpcommingMovieViewModel{
    func callUpcomingMovieApi(){
        
        if !isSecondTimeFetching{
            controller.startLoading()
        }
        
        let param = [AppConstants.apiKey: AppConstants.apiKeyValue, AppConstants.pageKey: "\(currentPage)"]
        UpcomingMovieController.shared.getUpcomingMovieList(parameters: param) { [weak self] response in
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
