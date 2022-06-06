//
//  String+Extension.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//


import Foundation
extension String {
    
    struct Title {
        static let title                                = ApplicationName
        static let noInternet                           = "You need an active data connection to use this application, please check your internet settings and try again"
        static let internalServerError                  = "Internal Server Error"
        static let invalidUrl                           = "Invalid Url"
        static let jsonparseFail                        = "Json Parse error"
        static let ok                                   = "OK"
        static let invalidApiKey                        = "Invalid Api Key"
    }
}
