//
//  DetailsController.swift
//  MovieListDemo
//
//  Created by PCQ229 on 07/06/22.
//

import Foundation
import Alamofire


final class DetailsController {
    
    static let shared = DetailsController()
    
    func getGenreList(parameters: Parameters, successCompletion: @escaping (_ response: Genre) -> Void,
    failureCompletion: @escaping ( _ failure: WebError, _ errorMessage: String) -> Void){
        APIManager.API.sendRequest(.genre(parameters), type: Genre.self, successCompletion: successCompletion, failureCompletion: failureCompletion)
    }
}
