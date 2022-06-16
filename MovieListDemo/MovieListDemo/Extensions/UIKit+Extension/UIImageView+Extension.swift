//
//  UIImageView+Extension.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//

import UIKit
import Kingfisher

//MARK: UIImageView Extension For Cache Image
extension UIImageView: URLSessionDelegate {
    
    func setImageUsingUrl(_ url: String?, placeholder image: UIImage?) {
        let source = URL(string: url ?? "")
        self.kf.setImage(with: source, placeholder: image, options: nil, completionHandler: nil)
    }
    
    
}
