//
//  APIManager.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//

import Foundation
import Alamofire

enum WebError: Error {
    
    case badRequest //400
    
    case conflictError //409
    
    case forbidden //403
    
    case internalServerError //500
    
    case notFound //404
    
    case serviceUnavailable  //503
    
    case unauthorized //401
    
    /// Throws when request timeout occurs
    case timeout
    
    /// Throws when application cancel running request
    case cancel
    
    /// Throws when error is none of the above
    case unknown
    
    /// Thows when custom error founds
    case custom(String?)
    
    /// Throws when server don't give any response
    case noData
    
    /// Throws when internet isn't connected
    case noInternet
    
    /// Throws when server is down because of any reason
    case hostFail
    
    /// Throws when response is not as per predefined json format
    case parseFail
    
    
    static func getErrorByCode(_ statusCode: Int, message : String) -> WebError {
        return .custom(message)
    }
    
    var errorMessage: String? {
        switch self {
        case .badRequest: //400
            return "Bad request"
        case .conflictError: //409
            return "ConflictError"
        case .forbidden: //403
            return "You do not have access to requested data."
        case .internalServerError: //500
            return "InternalServerError"
        case .notFound: //404
            return "NotFound"
        case .serviceUnavailable : //503
            return "ServiceUnavailable"
        case .unauthorized: //401
            return "You are not authorised."
        case .noData:
            return "No data found."
        case .noInternet:
            return "Network not reachable."
        case .hostFail:
            return "Failed to retrieve host."
        case .parseFail:
            return "Failed to parse data."
        case .timeout:
            return "Request timed out."
        case .cancel:
            return "Canceled request."
        case .unknown:
            //            return "Coundn't process request at the moment, please try again later."
            return "There is an error processing your request, Please try again later."
        case .custom(let errorMessage):
            return errorMessage
        }
    }
}

final class APIManager: Session {
    
    static let API: APIManager = APIManager()
    
    func sendRequest<T: Codable>(_ route: Router, type: T.Type,  successCompletion: @escaping (_ response: T) -> Void, failureCompletion: @escaping ( _ failure: WebError, _ message: String) -> Void) {
        
        guard let isReachable = Reachability()?.isReachable else {
            failureCompletion(WebError.noInternet,  String.Title.noInternet)
            return
        }
        
        if !isReachable {
            failureCompletion(WebError.noInternet,  String.Title.noInternet)
        }
        
        let path = route.path.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        
        guard let path = path else {
            failureCompletion(WebError.badRequest,  String.Title.invalidUrl)
            return
        }
        
        guard let _ = URL(string: path) else {
            failureCompletion(WebError.serviceUnavailable,  String.Title.invalidUrl)
            return
        }
        
        var parameter = route.parameters
        if route.parameters == nil || route.parameters?.count == 0 {
            parameter = [:]
            
        }
        request(path, method: route.method, parameters: parameter).responseData { (response) in
            if let statusCode = response.response?.statusCode,
               statusCode != 200 {
                failureCompletion(WebError.unauthorized,  response.error?.localizedDescription ?? String.Title.unknownError)
            } else {
                if let data = response.data, let resp = try? JSONDecoder().decode(type.self, from: data) {
                    successCompletion(resp)
                } else {
                    failureCompletion(WebError.unauthorized,  response.error?.localizedDescription ?? String.Title.unknownError)
                }
            }
        }
    }
}
