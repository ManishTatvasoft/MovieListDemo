//
//  String+Extension.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//


import Foundation
extension String {
    
    struct Title {
        static let title = ApplicationName
        static let noInternet = "You need an active data connection to use this application, please check your internet settings and try again"
        static let internalServerError = "Internal Server Error"
        static let invalidUrl = "Invalid Url"
        static let jsonparseFail = "Json Parse error"
        static let ok = "OK"
        static let cancel = "Cancel"
        static let share = "Share"
        static let invalidApiKey = "Invalid Api Key"
        static let noDataFound = "Opps...\nNo data found"
        static let genereNotFound = "Genres could not get."
        static let dataNotFound = "Data could not get."
        static let shareMessage = "Share this movie to your frinds."
        static let movieDefaultTitle = "Movie"
        static let noReviewFound = "No review found"
    }
}
