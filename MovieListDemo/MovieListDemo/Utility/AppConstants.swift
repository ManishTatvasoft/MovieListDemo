//
//  AppConstants.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//

import Foundation


let ApplicationName         = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? "Upcoming Movie App"
let ApplicationVersion      = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String ?? ""
let ApplicationBuildNumber  = Bundle.main.infoDictionary!["CFBundleVersion"] as? String ?? ""

struct AppConstants{
    
    static let apiKey       = "api_key"
    static let apiKeyValue  = "0141e6d543b187f0b7e6bb3a1902209a"
    static let pageKey      = "page"
    static var movieID      = ""
}
