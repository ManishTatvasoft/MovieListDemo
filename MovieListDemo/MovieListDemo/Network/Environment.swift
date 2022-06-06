//
//  Environment.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//

import Foundation
import UIKit

enum Server {
    case developement
    case staging
    case production
}

class Environment {
    
    static let server:Server    =   .developement
    
    static let buildVersion: String = "1.0.1"

    static let latestBuildVersion: Double = 1.0
    
    class func basePosterImageURL() -> String{
        return "https://image.tmdb.org/t/p/w200"
    }
    
    class func baseCoverImageURL() -> String{
        return "https://image.tmdb.org/t/p/w500"
    }
    
    class func APIBasePath() -> String {
        return "https://api.themoviedb.org/3"
    }
}
