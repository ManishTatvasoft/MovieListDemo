//
//  UIImageView+Extension.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//

import UIKit

//MARK: UIImageView Extension For Cache Image
extension UIImageView: URLSessionDelegate{
    
    private static var taskKey = 0
    private static var urlKey = 0
    
    private var currentTask: URLSessionTask? {
        get { objc_getAssociatedObject(self, &UIImageView.taskKey) as? URLSessionTask }
        set { objc_setAssociatedObject(self, &UIImageView.taskKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    private var currentURL: URL? {
        get { objc_getAssociatedObject(self, &UIImageView.urlKey) as? URL }
        set { objc_setAssociatedObject(self, &UIImageView.urlKey, newValue, .OBJC_ASSOCIATION_RETAIN_NONATOMIC) }
    }
    
    func setImageUsingUrlSession(_ url: String?, placeholder image: UIImage?){
        self.image = image
        
        
        guard let urlString = url else { return }
        
        
        if let cachedImage = ImageCache.shared.image(forKey: urlString) {
            self.image = cachedImage
            return
        }
        let url = URL(string: urlString)!
        currentURL = url
        let session = URLSession(configuration: URLSessionConfiguration.default, delegate: self, delegateQueue: OperationQueue.main)
        let task = session.dataTask(with: url) { [weak self] data, response, error in
            self?.currentTask = nil
            if let error = error {
                if (error as NSError).domain == NSURLErrorDomain && (error as NSError).code == NSURLErrorCancelled {
                    return
                }
                print(error)
                return
            }
            guard let data = data, let downloadedImage = UIImage(data: data) else {
                print("unable to extract image")
                return
            }
            ImageCache.shared.save(image: downloadedImage, forKey: urlString)
            if url == self?.currentURL {
                DispatchQueue.main.async {
                    self?.image = downloadedImage
                }
            }
        }
        currentTask = task
        task.resume()
    }
    
    public func urlSession(_ session: URLSession, didReceive challenge: URLAuthenticationChallenge, completionHandler: (URLSession.AuthChallengeDisposition, URLCredential?) -> Void) {
        completionHandler(.useCredential, URLCredential(trust: challenge.protectionSpace.serverTrust!))
    }
    
}
