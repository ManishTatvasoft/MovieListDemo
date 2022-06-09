//
//  SearchViewModel.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import Foundation


final class SearchViewModel {
    
    private let controller: SearchViewController
    
    var isSearchingMode = false
    var currentPage = 1
    var isAllMovieFetched = false
    var isListView = false
    var isSecondTimeFetching = false
    var queryString = ""
    
    // MARK: - Methods
    init(_ viewController: SearchViewController) {
        controller = viewController
    }
}

extension SearchViewModel{
    func callSearchMovieApi(){
        if queryString != "" {
            let param = [AppConstants.apiKey: AppConstants.apiKeyValue, AppConstants.queryKey: queryString, AppConstants.pageKey : "\(currentPage)"]
            SearchController.shared.getSearchMovieList(parameters: param) { response in
                self.isSecondTimeFetching = true
                if response.total_pages == self.currentPage{
                    self.isAllMovieFetched = true
                }
                self.controller.successSearchApiResponse(response.results)
            } failureCompletion: { failure, errorMessage in
                DispatchQueue.main.async {
                    self.controller.showValidationMessage(withMessage: errorMessage)
                }
            }
        }
        
    }
    
    func callGenreListApi(){
        controller.startLoading()
        let param = [AppConstants.apiKey: AppConstants.apiKeyValue]
        DetailsController.shared.getGenreList(parameters: param) { response in
            self.controller.stopLoading()
            self.controller.successApiResponse(response.genres)
        } failureCompletion: { failure, errorMessage in
            self.controller.stopLoading()
            DispatchQueue.main.async {
                self.controller.showValidationMessage(withMessage: errorMessage)
            }
        }
    }
    
}
