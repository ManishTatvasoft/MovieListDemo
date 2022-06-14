//
//  DiscoverViewModel.swift
//  MovieListDemo
//
//  Created by PCQ229 on 09/06/22.
//

import Foundation


final class DiscoverViewModel {
    
    private var currentPage = 1
    var isAllMovieFetched = false
    var genreId = 0
}

extension DiscoverViewModel{
    func callGenreMovieApi(_ completion: @escaping ((_ results:[Results]?,_ isSuccess: Bool,_ errorMessage: String) -> ())){
        let param = [AppConstants.apiKey: AppConstants.apiKeyValue, AppConstants.withGenreKey: "\(genreId)", AppConstants.pageKey: "\(currentPage)"]
        DiscoverController.shared.getGenreMovieList(parameters: param) { [weak self] response in
            guard let self = self else{
                completion([], false, String.Title.somthingWentWrong)
                return
            }
            if response.total_pages == self.currentPage{
                self.isAllMovieFetched = true
            }else{
                self.currentPage += 1
            }
            completion(response.results, true, "")
        } failureCompletion: { failure, errorMessage in
            completion([], false, "")
        }
    }
    
    func callPopularMovieApi(_ completion: @escaping ((_ results:[Results]?,_ isSuccess: Bool,_ errorMessage: String) -> ())){
        let param = [AppConstants.apiKey: AppConstants.apiKeyValue, AppConstants.pageKey: "\(currentPage)"]
        DiscoverController.shared.getPopularMovieList(parameters: param) { [weak self] response in
            guard let self = self else{
                completion([], false, String.Title.somthingWentWrong)
                return
            }
            if response.total_pages == self.currentPage{
                self.isAllMovieFetched = true
            }else{
                self.currentPage += 1
            }
            completion(response.results, true, "")
        } failureCompletion: { failure, errorMessage in
            completion([], false, "")
        }
    }
    
    func callTopRatedMovieApi(_ completion: @escaping ((_ results:[Results]?,_ isSuccess: Bool,_ errorMessage: String) -> ())){
        let param = [AppConstants.apiKey: AppConstants.apiKeyValue, AppConstants.pageKey: "\(currentPage)"]
        DiscoverController.shared.getTopRatedMovieList(parameters: param) { [weak self] response in
            guard let self = self else{
                completion([], false, String.Title.somthingWentWrong)
                return
            }
            if response.total_pages == self.currentPage{
                self.isAllMovieFetched = true
            }else{
                self.currentPage += 1
            }
            completion(response.results, true, "")
        } failureCompletion: { failure, errorMessage in
            completion([], false, "")
        }
    }
}
