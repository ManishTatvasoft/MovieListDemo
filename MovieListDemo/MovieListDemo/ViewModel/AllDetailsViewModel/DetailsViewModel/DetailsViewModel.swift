//
//  DetailsViewModel.swift
//  MovieListDemo
//
//  Created by PCQ229 on 07/06/22.
//

import Foundation


final class DetailsViewModel {}

extension DetailsViewModel{
    func callGenreListApi(_ completion: @escaping ((_ results:Genre?,_ isSuccess: Bool,_ errorMessage: String) -> ())) {
        let param = [AppConstants.apiKey: AppConstants.apiKeyValue]
        
        DetailsController.shared.getGenreList(parameters: param) { response in
            completion(response, true, "")
        } failureCompletion: { failure, errorMessage in
            completion(nil, false, errorMessage)
        }
    }
}
