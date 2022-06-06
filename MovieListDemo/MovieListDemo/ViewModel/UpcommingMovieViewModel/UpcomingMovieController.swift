//
//  UpcomingMovieController.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//

import Foundation
import Alamofire


final class UpcomingMovieController {
    
    static let shared = UpcomingMovieController()
    
    func getUpcomingMovieList(parameters: Parameters, successCompletion: @escaping (_ response: UpcomingMovie) -> Void,
    failureCompletion: @escaping ( _ failure: WebError, _ errorMessage: String) -> Void){
        APIManager.API.sendRequest(.upcoming(parameters), type: UpcomingMovie.self, successCompletion: successCompletion, failureCompletion: failureCompletion)
    }
}
