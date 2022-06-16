//
//  AppConstants.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//

import Foundation
import UIKit
import AVFoundation


let ApplicationName = Bundle.main.object(forInfoDictionaryKey: "CFBundleDisplayName") as? String ?? "Upcoming Movie App"
let ApplicationVersion = Bundle.main.infoDictionary?["CFBundleShortVersionString"] as? String ?? ""
let ApplicationBuildNumber = Bundle.main.infoDictionary?["CFBundleVersion"] as? String ?? ""

struct AppConstants {
    
    static let apiKey = "api_key"
    static let apiKeyValue = "0141e6d543b187f0b7e6bb3a1902209a"
    static let pageKey = "page"
    static let withGenreKey = "with_genres"
    static var movieID = ""
    static let couldNotPlayVideo = "Could not play video\nerror occured."
    static let queryKey = "query"
    
    //MARK: For table header title
    static let searchResultHeader = "Search Result"
    static let genreHeader = "Movie Genres"
    static let popularTopRatedMoviesHeader = ""
    static let recentlyVisitedHeader = "Recently Visited"
    
    //MARK: View controller title
    static let topRatedMovieTitle = "Top Rated Movies"
    static let popularMovieTitle = "Popular Movies"
    
    
    //MARK: key for top rated and popular movie
    static let titleKey = "title"
    static let subTitleKey = "subTitle"
    static let typeKey = "type"
    
    //MARK: For collection header title
    static let castHeader = "Cast"
    static let crewHeader = "Crew"
    
    static func getGenreString(_ data: Results) -> String {
        var arrayGenre = [String]()
        data.genre_ids?.forEach({ id in
            AppManager.shared.genre?.genres?.forEach({ Genre in
                if id == Genre.id{
                    arrayGenre.append(Genre.name ?? "")
                }
            })
        })
        
        let genre = arrayGenre.count > 0 ? arrayGenre.joined(separator: ", ") : ""
        return genre
    }

    static func share(_ image: UIImage?) {
        let imageToShare = [image]
        let activityViewController = UIActivityViewController(activityItems: imageToShare as [Any], applicationActivities: nil)
        activityViewController.popoverPresentationController?.sourceView = AppConstants.topViewController()?.view
        activityViewController.excludedActivityTypes = [ UIActivity.ActivityType.airDrop, UIActivity.ActivityType.postToFacebook ]
        AppConstants.topViewController()?.present(activityViewController, animated: true, completion: nil)
    }
    
    static func addDataToDb(_ result: Results) {
        var movie = Movie()
        movie.movieName = result.title ?? ""
        movie.movieID = "\(result.id ?? 0)"
        movie.posterPath = result.poster_path ?? ""
        movie.time = "\(Date())"
        movie.genre = AppConstants.getGenreString(result)
        DatabaseManager.shared.checkAndInserData(movie)
        let param = [AppConstants.apiKey: AppConstants.apiKeyValue]
        
    }
    
    static func topViewController() -> UIViewController? {
        let keyWindow = UIApplication.shared.windows.filter {$0.isKeyWindow}.first

        if var topController = keyWindow?.rootViewController {
            while let presentedViewController = topController.presentedViewController {
                topController = presentedViewController
            }
            return topController
        }
        return nil
    }
    
    static func thumbnailForVideoAtURL(url: URL) -> UIImage? {

        let asset = AVAsset(url: url)
        let assetImageGenerator = AVAssetImageGenerator(asset: asset)

        var time = asset.duration
        time.value = min(time.value, 2)

        do {
            let imageRef = try assetImageGenerator.copyCGImage(at: time, actualTime: nil)
            return UIImage(cgImage: imageRef)
        } catch {
            print("error")
            return nil
        }
    }
    
    static func videoUrl(_ endPoint: String) -> String {
        let fullUrl = "https://img.youtube.com/vi/\(endPoint)/hqdefault.jpg"
        return fullUrl
    }
    
    static func youtubeVideoUrl(_ endPoint: String) -> String {
        let fullUrl = "https://www.youtube.com/watch?v=\(endPoint)"
        return fullUrl
    }
}
