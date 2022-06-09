//
//  DiscoverViewController.swift
//  MovieListDemo
//
//  Created by PCQ229 on 09/06/22.
//

import UIKit

class DiscoverViewController: UIViewController {

    @IBOutlet weak var tableDiscover: UITableView!
    private lazy var viewModel         = DiscoverViewModel(self)
    lazy var navigator                 = DiscoverNavigator(self)
    var arrayData = [Results]()
    var genre: Genres?
    var discoverType: DiscoverType?
    var data: Results?
    override func viewDidLoad() {
        super.viewDidLoad()
        preparView()
        // Do any additional setup after loading the view.
    }
    
    
    
    func preparView(){
        tableDiscover.register(DiscoverCell.self)
        callApiAccordingToType()
        
    }
    
    
    func successApiResponse(_ data: [Results]?){
        guard let data = data else {
            self.showValidationMessage(withMessage: "Genres could not get.")
            return
        }
        arrayData.append(contentsOf: data)
        
        DispatchQueue.main.async {
            self.tableDiscover.reloadData()
        }
    }
    
    func callApiAccordingToType() {
        switch discoverType {
        case .genre:
            viewModel.genreId = genre?.id ?? 28
            self.title = genre?.name
            viewModel.callGenreMovieApi()
        case .topRated:
            self.title = AppConstants.topRatedMovieTitle
            viewModel.callTopRatedMovieApi()
        case .popular:
            self.title = AppConstants.popularMovieTitle
            viewModel.callPopularMovieApi()
        case .none:
            self.showValidationMessage(withMessage: "Opps...\nNo data found", preferredStyle: .alert) {
                self.navigationController?.popViewController(animated: true)
            }
        }
    }
}

extension DiscoverViewController: UITableViewDelegate, UITableViewDataSource{
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
        let lastSectionIndex = tableView.numberOfSections - 1
        let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            let spinner = UIActivityIndicatorView(style: .medium)
            spinner.startAnimating()
            spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
            self.tableDiscover.tableFooterView = spinner
            if !viewModel.isAllMovieFetched{
                viewModel.currentPage += 1
                self.callApiAccordingToType()
            }
            self.tableDiscover.tableFooterView?.isHidden = viewModel.isAllMovieFetched
        }
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let result = arrayData[indexPath.row]
        tableView.deselectRow(at: indexPath, animated: true)
        AppConstants.addDataToDb(result)
        navigator.moveToMovieDetailScreen(with: result)
    }
}
