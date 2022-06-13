//
//  CreditsViewModel.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import Foundation
final class CreditsViewModel {
    
    
    private let controller: CreditsViewController
    
    // MARK: - Methods
    init(_ viewController: CreditsViewController) {
        controller = viewController
    }
}

extension CreditsViewModel{
    func callCreditsApi(){
        controller.startLoading()
        let param = [AppConstants.apiKey: AppConstants.apiKeyValue]
        CreditsController.shared.getCreditsList(parameters: param) { [weak self] response in
            guard let self = self else{
                return
            }
            self.controller.stopLoading()
            self.controller.successApiResponse(response)
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
