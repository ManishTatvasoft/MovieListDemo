//
//  Environment.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//

import Foundation
import UIKit

class Environment {
    
    class func basePosterImageURL() -> String {
        return "https://image.tmdb.org/t/p/w200"
    }
    
    class func baseCoverImageURL() -> String {
        return "https://image.tmdb.org/t/p/w500"
    }
    
    class func APIBasePath() -> String {
        return "https://api.themoviedb.org/3"
    }
}
