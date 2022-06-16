//
//  DiscoverController.swift
//  MovieListDemo
//
//  Created by PCQ229 on 09/06/22.
//

import Foundation
import Alamofire

final class DiscoverController {
    
    static let shared = DiscoverController()
    
    func getGenreMovieList(parameters: Parameters, successCompletion: @escaping (_ response: Discover) -> Void,
    failureCompletion: @escaping ( _ failure: WebError, _ errorMessage: String) -> Void) {
        APIManager.API.sendRequest(.discover(parameters), type: Discover.self, successCompletion: successCompletion, failureCompletion: failureCompletion)
    }
    func getTopRatedMovieList(parameters: Parameters, successCompletion: @escaping (_ response: Discover) -> Void,
    failureCompletion: @escaping ( _ failure: WebError, _ errorMessage: String) -> Void) {
        APIManager.API.sendRequest(.topRated(parameters), type: Discover.self, successCompletion: successCompletion, failureCompletion: failureCompletion)
    }
    func getPopularMovieList(parameters: Parameters, successCompletion: @escaping (_ response: Discover) -> Void,
    failureCompletion: @escaping ( _ failure: WebError, _ errorMessage: String) -> Void) {
        APIManager.API.sendRequest(.popular(parameters), type: Discover.self, successCompletion: successCompletion, failureCompletion: failureCompletion)
    }
}
