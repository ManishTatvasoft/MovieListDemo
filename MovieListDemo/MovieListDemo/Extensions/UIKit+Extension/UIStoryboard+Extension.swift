//
//  UIStoryboard+Extension.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//

import UIKit


extension UIStoryboard {
    static var main: UIStoryboard = {
        let storyboard = UIStoryboard.storyboard(name: "Main")
        return storyboard
    }()
    
    static var details: UIStoryboard = {
        let storyboard = UIStoryboard.storyboard(name: "Details")
        return storyboard
    }()

    class func storyboard(name: String) -> UIStoryboard {
        return UIStoryboard(name: name, bundle: Bundle.main)
    }
    
    public func get<T:UIViewController>(_ identifier: T.Type) -> T? {
        let storyboardID = String(describing: identifier)

        guard let viewController = instantiateViewController(withIdentifier: storyboardID) as? T else {
            return nil
        }

        return viewController
    }
}
