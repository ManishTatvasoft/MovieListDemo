//
//  PlayerViewController.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import UIKit
import WebKit

class PlayerViewController: UIViewController {
    
    var url: URL?
    var name: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = name
        
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let url = url else {
            self.showValidationMessage(withMessage: AppConstants.couldNotPlayVideo)
            return
        }
        
        if #available(iOS 11.0, *){
            let videoPlayerView = WKWebView()
            videoPlayerView.configuration.allowsInlineMediaPlayback = true
            let youtubeRequest = URLRequest(url: url)
            videoPlayerView.load(youtubeRequest)
        }else{
            let videoPlayerView = UIWebView()
            videoPlayerView.allowsInlineMediaPlayback = true
            let youtubeRequest = URLRequest(url: url)
            videoPlayerView.loadRequest(youtubeRequest)
        }
        
        

    }

}
