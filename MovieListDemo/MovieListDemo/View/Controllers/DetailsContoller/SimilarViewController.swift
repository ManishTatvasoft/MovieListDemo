//
//  SimilarViewController.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import UIKit

class SimilarViewController: UIViewController {

    @IBOutlet weak var tableSimilar: UITableView!
    private lazy var viewModel = SimilarViewModel(self)
    lazy var navigator = SimilarNavigator(self)
    var arrayData = [Results]()
    
    var name: String?
    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = name
        prepareView()
        // Do any additional setup after loading the view.
    }
    

    func prepareView(){
        tableSimilar.register(SimilarCell.self)
        viewModel.callSimilarMovieApi()
    }
    
    func successApiResponse(_ data: [Results]?){
        guard let data = data else {
            self.showValidationMessage(withMessage: "Data could not get.")
            return
        }
        
        self.arrayData.append(contentsOf: data)
        DispatchQueue.main.async {
            self.tableSimilar.reloadData()
        }
    }

}

extension SimilarViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = arrayData[indexPath.row]
        let cell: SimilarCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setupData(data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            self.tableSimilar.tableFooterView = spinner
            if !viewModel.isAllMovieFetched{
                viewModel.currentPage += 1
                viewModel.callSimilarMovieApi()
            }
            self.tableSimilar.tableFooterView?.isHidden = viewModel.isAllMovieFetched
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result = arrayData[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        AppConstants.addDataToDb(result)
        navigator.moveToMovieDetailScreen(with: result)
    }
}
