//
//  VideoController.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import Foundation
import Alamofire


final class VideoController {
    
    static let shared = VideoController()
    
    func getVideoList(parameters: Parameters, successCompletion: @escaping (_ response: Video) -> Void,
    failureCompletion: @escaping ( _ failure: WebError, _ errorMessage: String) -> Void) {
        APIManager.API.sendRequest(.video(parameters), type: Video.self, successCompletion: successCompletion, failureCompletion: failureCompletion)
    }
}
