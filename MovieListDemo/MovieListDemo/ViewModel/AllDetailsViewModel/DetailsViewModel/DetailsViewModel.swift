//
//  DetailsViewModel.swift
//  MovieListDemo
//
//  Created by PCQ229 on 07/06/22.
//

import Foundation


final class DetailsViewModel {
    
    
    private let controller: DetailsViewController
    
    // MARK: - Methods
    init(_ viewController: DetailsViewController) {
        controller = viewController
    }
}

extension DetailsViewModel{
    func callGenreListApi(){
        controller.startLoading()
        let param = ["api_key":"0141e6d543b187f0b7e6bb3a1902209a"]
        DetailsController.shared.getGenreList(parameters: param) { response in
            self.controller.stopLoading()
            self.controller.successApiResponse(response)
        } failureCompletion: { failure, errorMessage in
            self.controller.stopLoading()
        }

        
    }
}
