//
//  UIViewController+Extension.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//

import UIKit
import SVProgressHUD

extension UIViewController{
    func startLoading() {
        SVProgressHUD.setDefaultMaskType(.black)
        SVProgressHUD.show()
    }
   
    func stopLoading() {
        SVProgressHUD.dismiss()
    }
    
    func showAlertAndSheet(with title: String, withMessage message: String, preferredStyle: UIAlertController.Style = .alert, success actions: (()->Void)? = nil, failure failAction: (()->Void)? = nil){
        let alert = UIAlertController(title: title, message: message, preferredStyle: preferredStyle)
        alert.addAction(UIAlertAction(title: String.Title.share, style: .default, handler: { (_) in
            actions?()
        }))
        alert.addAction(UIAlertAction(title: String.Title.cancel, style: .cancel, handler: { (_) in
            failAction?()
        }))
        self.navigationController?.present(alert, animated: true, completion: nil)
    }
    
    func showValidationMessage(withMessage message: String?, preferredStyle: UIAlertController.Style = .alert, withActions actions: (()->Void)? = nil) {
        let alert = UIAlertController(title: String.Title.title, message: message, preferredStyle: preferredStyle)
        alert.addAction(UIAlertAction(title: String.Title.ok, style: .default, handler: { (_) in
            actions?()
        }))
        self.navigationController?.present(alert, animated: true, completion: nil)
    }

}
