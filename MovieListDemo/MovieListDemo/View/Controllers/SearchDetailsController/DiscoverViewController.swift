//
//  DiscoverViewController.swift
//  MovieListDemo
//
//  Created by PCQ229 on 09/06/22.
//

import UIKit

class DiscoverViewController: BaseViewController {

    @IBOutlet private weak var tableDiscover: UITableView!
    private lazy var viewModel = DiscoverViewModel()
    lazy var navigator = DiscoverNavigator(self)
    var arrayData = [Results]()
    var genre: Genres?
    var discoverType: DiscoverType?
    var data: Results?
    override func viewDidLoad() {
        super.viewDidLoad()
        preparView()
        // Do any additional setup after loading the view.
    }
    
    func preparView() {
        tableDiscover.register(DiscoverCell.self)
        self.startLoading()
        callApiAccordingToType {
            self.stopLoading()
        }
    }
    
    func apiResponce(_ results: [Results]?, _ isSuccess : Bool, _ errorMessage: String, _ completion: (() -> ())?) {
        if isSuccess {
            guard let results = results else {
                completion?()
                self.showValidationMessage(withMessage: String.Title.genereNotFound)
                return
            }
            self.arrayData.append(contentsOf: results)
            completion?()
            DispatchQueue.main.async { [weak self] in
                self?.tableDiscover.reloadData()
            }
        } else {
            completion?()
            DispatchQueue.main.async { [weak self] in
                self?.showValidationMessage(withMessage: errorMessage)
            }
        }
    }
    
    func callApiAccordingToType(completion: (() -> ())?) {
        switch discoverType {
        case .genre:
            viewModel.genreId = genre?.id ?? 28
            self.title = genre?.name
            viewModel.callGenreMovieApi { [weak self] results, isSuccess, errorMessage in
                guard let self = self else{
                    completion?()
                    return
                }
                self.apiResponce(results,isSuccess, errorMessage) {
                    completion?()
                }
            }
        case .topRated:
            self.title = AppConstants.topRatedMovieTitle
            viewModel.callTopRatedMovieApi { [weak self] results, isSuccess, errorMessage in
                guard let self = self else{
                    completion?()
                    return
                }
                self.apiResponce(results,isSuccess, errorMessage) {
                    completion?()
                }
            }
        case .popular:
            self.title = AppConstants.popularMovieTitle
            viewModel.callPopularMovieApi { [weak self] results, isSuccess, errorMessage in
                guard let self = self else{
                    completion?()
                    return
                }
                self.apiResponce(results,isSuccess, errorMessage) {
                    completion?()
                }
            }
        case .none:
            self.showValidationMessage(withMessage: String.Title.noDataFound, preferredStyle: .alert) { [weak self] in
                self?.navigationController?.popViewController(animated: true)
            }
        }
    }
}

extension DiscoverViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = arrayData[indexPath.row]
        let cell: DiscoverCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setupData(data,genre?.name)
        return cell
    }
    
    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        let data = arrayData[indexPath.row]
        let cell: DiscoverCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setupData(data,genre?.name)
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
            self.tableDiscover.tableFooterView = spinner
            if !viewModel.isAllMovieFetched{
                callApiAccordingToType(completion: nil)
            }
            tableDiscover.tableFooterView?.isHidden = viewModel.isAllMovieFetched
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result = arrayData[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        AppConstants.addDataToDb(result)
        navigator.moveToMovieDetailScreen(with: result)
    }
}
