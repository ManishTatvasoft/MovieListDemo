//
//  TopRatedAndPopular.swift
//  MovieListDemo
//
//  Created by PCQ229 on 17/06/22.
//

import Foundation

enum DiscoverType {
    case genre
    case topRated
    case popular
}


struct TopRatedAndPopular{
    var title: String
    var subTitle: String
    var type: DiscoverType
    
    static func getData() -> [TopRatedAndPopular]{
        let array = [
            TopRatedAndPopular(title: AppConstants.strPopularMovieTitle, subTitle: AppConstants.strPopularMovieSubTitle, type: .popular),
            TopRatedAndPopular(title: AppConstants.strTopRatedMovieTitle, subTitle: AppConstants.strTopRatedMovieSubTitle, type: .topRated)
        ]
        return array
    }
}
