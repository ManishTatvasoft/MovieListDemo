//
//  AppConstants.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//

import Foundation
import UIKit


let ApplicationName         = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? "Upcoming Movie App"
let ApplicationVersion      = Bundle.main.infoDictionary!["CFBundleShortVersionString"] as? String ?? ""
let ApplicationBuildNumber  = Bundle.main.infoDictionary!["CFBundleVersion"] as? String ?? ""

struct AppConstants{
    
    static let apiKey       = "api_key"
    static let apiKeyValue  = "0141e6d543b187f0b7e6bb3a1902209a"
    static let pageKey      = "page"
    static var movieID      = ""
    
    
    static func getGenreString(_ data: Results, _ genreData: Genre) -> String{
        var arrayGenre = [String]()
        data.genre_ids?.forEach({ id in
            genreData.genres?.forEach({ Genre in
                if id == Genre.id{
                    arrayGenre.append(Genre.name ?? "")
                }
            })
        })
        
        let genre = arrayGenre.joined(separator: ", ")
        return genre
    }
    
    static func share(_ image: UIImage?){
        let imageToShare = [image]
        let activityViewController = UIActivityViewController(activityItems: imageToShare, applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = AppConstants.topViewController()?.view
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        AppConstants.topViewController()?.present(activityViewController, animated: true, completion: nil)
    }
    
    static func topViewController() -> UIViewController?{
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
}
