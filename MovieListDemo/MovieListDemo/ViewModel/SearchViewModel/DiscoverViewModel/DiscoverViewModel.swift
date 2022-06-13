//
//  DiscoverViewModel.swift
//  MovieListDemo
//
//  Created by PCQ229 on 09/06/22.
//

import Foundation


final class DiscoverViewModel {
    
    var currentPage = 1
    var isAllMovieFetched = false
    var isListView = false
    var genreId = 0
    var isSecondTimeFetching = false
    
    private let controller: DiscoverViewController
    
    // MARK: - Methods
    init(_ viewController: DiscoverViewController) {
        controller = viewController
    }
}

extension DiscoverViewModel{
    func callGenreMovieApi(){
        if !isSecondTimeFetching{
            controller.startLoading()
        }
        let param = [AppConstants.apiKey: AppConstants.apiKeyValue,AppConstants.withGenreKey: "\(genreId)", AppConstants.pageKey: "\(currentPage)"]
        DiscoverController.shared.getGenreMovieList(parameters: param) { [weak self] response in
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
    
    func callPopularMovieApi(){
        if !isSecondTimeFetching{
            controller.startLoading()
        }
        let param = [AppConstants.apiKey: AppConstants.apiKeyValue, AppConstants.pageKey: "\(currentPage)"]
        DiscoverController.shared.getPopularMovieList(parameters: param) {[weak self] response in
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
    
    func callTopRatedMovieApi(){
        if !isSecondTimeFetching{
            controller.startLoading()
        }
        let param = [AppConstants.apiKey: AppConstants.apiKeyValue, AppConstants.pageKey: "\(currentPage)"]
        DiscoverController.shared.getTopRatedMovieList(parameters: param) { [weak self] response in
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
