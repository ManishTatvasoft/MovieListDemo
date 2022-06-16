//
//  SearchViewModel.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import Foundation


final class SearchViewModel {
    
    var isSearchingMode = false
    var currentPage = 1
    var isAllMovieFetched = false
    var queryString = ""
}

extension SearchViewModel {
    func callSearchMovieApi(_ completion: @escaping ((_ results:[Results]?,_ isSuccess: Bool,_ errorMessage: String) -> ())){
        if queryString != "" {
            let param = [AppConstants.apiKey: AppConstants.apiKeyValue, AppConstants.queryKey: queryString, AppConstants.pageKey : "\(currentPage)"]
            SearchController.shared.getSearchMovieList(parameters: param) { response in
                completion(response.results, true, "")
            } failureCompletion: { failure, errorMessage in
                completion([], false, errorMessage)
            }
        }
        
    }
    
    func callGenreListApi(_ completion: @escaping ((_ results:[Genres]?,_ isSuccess: Bool,_ errorMessage: String) -> ())) {
        let param = [AppConstants.apiKey: AppConstants.apiKeyValue]
        
        DetailsController.shared.getGenreList(parameters: param) { response in
            completion(response.genres, true, "")
        } failureCompletion: { failure, errorMessage in
            completion([], false, errorMessage)
        }
    }
    
    func getResultFromMovieID(movieID: String,_ completion: @escaping ((Results?) -> ())) {
        let param = [AppConstants.apiKey: AppConstants.apiKeyValue]
        SearchController.shared.getMovieDetails(parameters: param) { response in
            completion(response)
        } failureCompletion: { failure, errorMessage in
            completion(nil)
        }
    }
    
}
