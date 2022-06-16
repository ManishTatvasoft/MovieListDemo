//
//  SimilarController.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import Foundation
import Alamofire

final class SimilarController {
    
    static let shared = SimilarController()
    
    func getSimilarMovieList(parameters: Parameters, successCompletion: @escaping (_ response: Similar) -> Void,
    failureCompletion: @escaping ( _ failure: WebError, _ errorMessage: String) -> Void) {
        APIManager.API.sendRequest(.similar(parameters), type: Similar.self, successCompletion: successCompletion, failureCompletion: failureCompletion)
    }
}

