//
//  SearchController.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import Foundation
import Alamofire


final class SearchController {
    
    static let shared = SearchController()
    
    func getUpcomingMovieList(parameters: Parameters, successCompletion: @escaping (_ response: Search) -> Void,
    failureCompletion: @escaping ( _ failure: WebError, _ errorMessage: String) -> Void){
        APIManager.API.sendRequest(.search(parameters), type: Search.self, successCompletion: successCompletion, failureCompletion: failureCompletion)
    }
}
