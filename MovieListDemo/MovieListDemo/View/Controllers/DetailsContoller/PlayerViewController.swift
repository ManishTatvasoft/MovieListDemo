//
//  PlayerViewController.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import UIKit
import WebKit

class PlayerViewController: UIViewController {

    @IBOutlet weak var videoPlayerView: WKWebView!
    
    var url: URL?
    var name: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = name
        videoPlayerView.configuration.allowsInlineMediaPlayback = true
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        guard let url = url else {
            self.showValidationMessage(withMessage: AppConstants.couldNotPlayVideo)
            return
        }
        let youtubeRequest = URLRequest(url: url)
        videoPlayerView.load(youtubeRequest)

    }

}
