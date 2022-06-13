//
//  VideoViewModel.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import Foundation



final class VideoViewModel {
    
    
    private let controller: VideoViewController
    
    // MARK: - Methods
    init(_ viewController: VideoViewController) {
        controller = viewController
    }
}

extension VideoViewModel{
    func callVideoListApi(){
        controller.startLoading()
        let param = [AppConstants.apiKey: AppConstants.apiKeyValue]
        VideoController.shared.getVideoList(parameters: param) { [weak self] response in
            guard let self = self else{
                return
            }
            self.controller.stopLoading()
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
