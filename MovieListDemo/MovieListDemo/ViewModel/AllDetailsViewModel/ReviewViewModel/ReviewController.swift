//
//  ReviewController.swift
//  MovieListDemo
//
//  Created by PCQ229 on 07/06/22.
//

import Foundation
import Alamofire

final class ReviewsController {
    
    static let shared = ReviewsController()
    
    func getReviewsList(parameters: Parameters, successCompletion: @escaping (_ response: Review) -> Void,
    failureCompletion: @escaping ( _ failure: WebError, _ errorMessage: String) -> Void){
        APIManager.API.sendRequest(.review(parameters), type: Review.self, successCompletion: successCompletion, failureCompletion: failureCompletion)
    }
}
