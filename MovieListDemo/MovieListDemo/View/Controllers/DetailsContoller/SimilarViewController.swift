//
//  SimilarViewController.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import UIKit

class SimilarViewController: BaseViewController {

    @IBOutlet private weak var tableSimilar: UITableView!
    private lazy var viewModel = SimilarViewModel()
    private lazy var navigator = SimilarNavigator(self)
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
        self.startLoading()
        apiResponse { [weak self] in
            self?.stopLoading()
        }
    }
    
    func apiResponse(completion: (() -> Void)?){
        viewModel.callSimilarMovieApi { [weak self] results, isSuccess, errorMessage in
            guard let self = self else{
                completion?()
                return
            }
            if isSuccess{
                guard let results = results else {
                    self.showValidationMessage(withMessage: String.Title.dataNotFound)
                    return
                }
                
                self.arrayData.append(contentsOf: results)
                DispatchQueue.main.async { [weak self] in
                    self?.tableSimilar.reloadData()
                }
            }else{
                self.showValidationMessage(withMessage: String.Title.dataNotFound)
            }
            completion?()
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
            var spinner = UIActivityIndicatorView()
            if #available(iOS 13.0, *) {
                spinner = UIActivityIndicatorView(style: .medium)
            } else {
                spinner = UIActivityIndicatorView(style: .gray)
            }
            spinner.startAnimating()
            spinner.frame = CGRect(x: 0, y: 0, width: tableView.bounds.width, height: 44)
            self.tableSimilar.tableFooterView = spinner
            if !viewModel.isAllMovieFetched{
                apiResponse(completion: nil)
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
