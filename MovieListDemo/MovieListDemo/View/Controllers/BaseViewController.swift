//
//  BaseViewController.swift
//  MovieListDemo
//
//  Created by PCQ229 on 13/06/22.
//

import UIKit

class BaseViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        if #available(iOS 11.0, *) {
            if #available(iOS 14.0, *) {
                navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
            } else {
                navigationController?.navigationBar.topItem?.backButtonTitle = ""
            }
        }
    }
}
