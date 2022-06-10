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
        let youtubeRequest = URLRequest(url: url)
        
        if #available(iOS 11.0, *){
            let videoPlayerView = WKWebView()
            videoPlayerView.frame = self.view.bounds
            self.view.addSubview(videoPlayerView)
            videoPlayerView.configuration.allowsInlineMediaPlayback = true
            videoPlayerView.load(youtubeRequest)
        }else{
            let videoPlayerView = UIWebView()
            videoPlayerView.frame = self.view.bounds
            self.view.addSubview(videoPlayerView)
            videoPlayerView.allowsInlineMediaPlayback = true
            videoPlayerView.loadRequest(youtubeRequest)
        }
        
        

    }

}
