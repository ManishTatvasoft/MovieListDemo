//
//  CreditsViewModel.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import Foundation
final class CreditsViewModel {}

extension CreditsViewModel{
    func callCreditsApi(_ completion: @escaping ((_ credits: Credits?,_ isSuccess: Bool,_ errorMessage: String) -> ())){
        let param = [AppConstants.apiKey: AppConstants.apiKeyValue]
        CreditsController.shared.getCreditsList(parameters: param) { response in
            completion(response, true, "")
        } failureCompletion: { failure, errorMessage in
            completion(nil, false, errorMessage)
        } 
    }
}
