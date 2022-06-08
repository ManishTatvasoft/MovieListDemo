//
//  ReviewViewController.swift
//  MovieListDemo
//
//  Created by PCQ229 on 07/06/22.
//

import UIKit

class ReviewViewController: UIViewController {

    @IBOutlet weak var tableReview: UITableView!
    private lazy var viewModel = ReviewsViewModel(self)
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
        viewModel.callReviewsListApi()
    }

    func successApiResponse(_ reviewResults: [ReviewResults]?){
        guard let reviewResults = reviewResults else {
            self.showValidationMessage(withMessage: "Data could not get.")
            return
        }
        self.arrayData = reviewResults
        if arrayData.count == 0{
            self.showValidationMessage(withMessage: "No review found", preferredStyle: .alert) {
                self.navigationController?.popViewController(animated: true)
            }
        }
        DispatchQueue.main.async {
            self.tableReview.reloadData()
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
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height){
            if arrayData.count > 0{
                if !viewModel.isAllReviewFetched{
                    viewModel.currentPage += 1
                    viewModel.callReviewsListApi()
                }
            }
            
        }
    }
}
