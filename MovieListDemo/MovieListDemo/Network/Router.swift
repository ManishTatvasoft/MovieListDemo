//
//  Router.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//

import Foundation
import Alamofire

protocol Routable{
    associatedtype T
    
    var path : String { get }
    var method : HTTPMethod { get }
    var parameters : Parameters? { get }
}

enum Router{
    typealias T = Codable.Type
    case upcoming(Parameters)
    case details(Parameters)
    case review(Parameters)
    case video(Parameters)
    case credits(Parameters)
    case similar(Parameters)
    case search(Parameters)
    case popular(Parameters)
    case topRated(Parameters)
    case genre(Parameters)
    case discover(Parameters)
}

extension Router: Routable{
    
    
    var path: String {
        switch self {
        case .upcoming:
            return Environment.APIBasePath() + "/movie/upcoming"
        case .details:
            return Environment.APIBasePath() + "/movie/\(AppConstants.movieID)"
        case .review:
            return Environment.APIBasePath() + "/movie/\(AppConstants.movieID)/reviews"
        case .video:
            return Environment.APIBasePath() + "/movie/\(AppConstants.movieID)/videos"
        case .credits:
            return Environment.APIBasePath() + "/movie/\(AppConstants.movieID)/credits"
        case .similar:
            return Environment.APIBasePath() + "/movie/\(AppConstants.movieID)/similar"
        case .search:
            return Environment.APIBasePath() + "/search/movie"
        case .popular:
            return Environment.APIBasePath() + "/movie/popular"
        case .topRated:
            return Environment.APIBasePath() + "/movie/top_rated"
        case .genre:
            return Environment.APIBasePath() + "/genre/movie/list"
        case .discover:
            return Environment.APIBasePath() + "/discover/movie"
        }
    }
    
    var method: HTTPMethod {
        switch self {
        case .upcoming,.details,.review,.video,.credits,.similar,.search,.popular,.topRated,.genre,.discover:
            return .get
        }
    }
    
    var parameters: Parameters? {
        switch self {
        case .upcoming(let param):
            return param
        case .details(let param):
            return param
        case .review(let param):
            return param
        case .video(let param):
            return param
        case .credits(let param):
            return param
        case .similar(let param):
            return param
        case .search(let param):
            return param
        case .popular(let param):
            return param
        case .topRated(let param):
            return param
        case .genre(let param):
            return param
        case .discover(let param):
            return param
        }
    }
    
}
