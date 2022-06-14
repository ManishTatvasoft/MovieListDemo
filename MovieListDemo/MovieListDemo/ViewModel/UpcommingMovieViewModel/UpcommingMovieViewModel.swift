//
//  UpcommingMovieViewModel.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//

import Foundation

final class UpcommingMovieViewModel {
    
    private var currentPage = 1
    var isAllMovieFetched = false
    var isListView = false
    
}

extension UpcommingMovieViewModel{
    func callUpcomingMovieApi(_ completion: @escaping ((_ data:[Results]?,_ isSuccess: Bool,_ errorMessage: String) -> ())){
        
        let param = [AppConstants.apiKey: AppConstants.apiKeyValue, AppConstants.pageKey: "\(currentPage)"]
        UpcomingMovieController.shared.getUpcomingMovieList(parameters: param) { [weak self] response in
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
            completion([], false, errorMessage)
        }

    }
}
