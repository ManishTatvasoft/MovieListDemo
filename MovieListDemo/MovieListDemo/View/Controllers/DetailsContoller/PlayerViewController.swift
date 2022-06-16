//
//  PlayerViewController.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import UIKit
import WebKit

class PlayerViewController: BaseViewController {
    
    var url: URL?
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = name
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        guard let url = url else {
            self.showValidationMessage(withMessage: AppConstants.couldNotPlayVideo)
            return
        }
        let youtubeRequest = URLRequest(url: url)
        if #available(iOS 11.0, *) {
            let videoPlayerView = WKWebView()
            videoPlayerView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(videoPlayerView)
            setupView(videoPlayerView)
            videoPlayerView.configuration.allowsInlineMediaPlayback = true
            videoPlayerView.load(youtubeRequest)
        } else {
            let videoPlayerView = UIWebView()
            videoPlayerView.translatesAutoresizingMaskIntoConstraints = false
            self.view.addSubview(videoPlayerView)
            setupView(videoPlayerView)
            videoPlayerView.allowsInlineMediaPlayback = true
            videoPlayerView.loadRequest(youtubeRequest)
        }
    }
    
    func setupView(_ webView: UIView) {
        if #available(iOS 11, *) {
            let guide = view.safeAreaLayoutGuide
            NSLayoutConstraint.activate([
                webView.topAnchor.constraint(equalToSystemSpacingBelow: guide.topAnchor, multiplier: 1.0),
                guide.bottomAnchor.constraint(equalToSystemSpacingBelow: webView.bottomAnchor, multiplier: 1.0),
                webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        } else {
            let standardSpacing: CGFloat = 8.0
            NSLayoutConstraint.activate([
                webView.topAnchor.constraint(equalTo: topLayoutGuide.bottomAnchor, constant: standardSpacing),
                bottomLayoutGuide.topAnchor.constraint(equalTo: webView.bottomAnchor, constant: standardSpacing),
                webView.leadingAnchor.constraint(equalTo: view.leadingAnchor),
                webView.trailingAnchor.constraint(equalTo: view.trailingAnchor)
            ])
        }
    }
}
