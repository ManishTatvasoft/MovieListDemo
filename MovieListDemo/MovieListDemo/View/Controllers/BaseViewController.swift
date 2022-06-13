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
                self.navigationController?.navigationBar.topItem?.backButtonDisplayMode = .minimal
            } else {
                self.navigationController?.navigationBar.topItem?.backButtonTitle = ""
            }
        }
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
