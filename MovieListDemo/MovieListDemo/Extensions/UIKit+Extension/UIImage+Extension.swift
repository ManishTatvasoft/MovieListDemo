//
//  UIImage+Extension.swift
//  MovieListDemo
//
//  Created by PCQ229 on 10/06/22.
//

import UIKit

extension UIImage {
    
    class func universalImage(_ name: String) -> UIImage? {
        if #available(iOS 13.0, *) {
            return UIImage(systemName: name)
        } else {
            return UIImage(named: name)
        }
    }
}
