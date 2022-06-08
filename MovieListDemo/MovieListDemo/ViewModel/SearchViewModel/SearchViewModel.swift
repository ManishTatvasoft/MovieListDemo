//
//  SearchViewModel.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import Foundation


final class SearchViewModel {
    
    private let controller: SearchViewController
    
    // MARK: - Methods
    init(_ viewController: SearchViewController) {
        controller = viewController
    }
}

extension SearchViewModel{
    func callSearchMovieApi(){
        controller.startLoading()
        let param = [AppConstants.apiKey: AppConstants.apiKeyValue]
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
