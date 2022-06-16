//
//  CreditsController.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import Foundation
import Alamofire


final class CreditsController {
    
    static let shared = CreditsController()
    
    func getCreditsList(parameters: Parameters, successCompletion: @escaping (_ response: Credits) -> Void,
    failureCompletion: @escaping ( _ failure: WebError, _ errorMessage: String) -> Void) {
        APIManager.API.sendRequest(.credits(parameters), type: Credits.self, successCompletion: successCompletion, failureCompletion: failureCompletion)
    }
}
