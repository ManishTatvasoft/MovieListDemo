//
//  ReviewViewController.swift
//  MovieListDemo
//
//  Created by PCQ229 on 07/06/22.
//

import UIKit

class ReviewViewController: BaseViewController {

    @IBOutlet private weak var tableReview: UITableView!
    
    private lazy var viewModel = ReviewsViewModel()
    var arrayData = [ReviewResults]()
    var name: String?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = name ?? "Review"
        prepareView()
        // Do any additional setup after loading the view.
    }
    
    func prepareView(){
        tableReview.register(ReviewCell.self, reuseIdentifier: "ReviewCell")
        self.startLoading()
        apiResponse { [weak self] in
            self?.stopLoading()
        }
    }
    
    func apiResponse(completion: (() -> Void)?){
        viewModel.callReviewsListApi { [weak self] results, isSuccess, errorMessage in
            guard let self = self else{
                completion?()
                self?.showValidationMessage(withMessage: String.Title.somthingWentWrong)
                return
            }
            
            completion?()
            if isSuccess{
                guard let results = results else {
                    self.showValidationMessage(withMessage: String.Title.dataNotFound)
                    return
                }
                self.arrayData = results
                if self.arrayData.count == 0{
                    self.showValidationMessage(withMessage: String.Title.noReviewFound, preferredStyle: .alert) {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                DispatchQueue.main.async {
                    self.tableReview.reloadData()
                }
            }else{
                self.showValidationMessage(withMessage: errorMessage)
            }
            
        }
    }
}

extension ReviewViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = arrayData[indexPath.row]
        let cell: ReviewCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setupData(data)
        return cell
    }
    
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            var spinner = UIActivityIndicatorView()
            if #available(iOS 13.0, *) {
                spinner = UIActivityIndicatorView(style: .medium)
            } else {
                spinner = UIActivityIndicatorView(style: .gray)
            }
            spinner.startAnimating()
            spinner.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44)
            self.tableReview.tableFooterView = spinner
            if !viewModel.isAllReviewFetched{
                apiResponse(completion: nil)
            }
            self.tableReview.tableFooterView?.isHidden = viewModel.isAllReviewFetched
        }
    }
}
