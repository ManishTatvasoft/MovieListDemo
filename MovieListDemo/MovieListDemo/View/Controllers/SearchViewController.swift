//
//  SearchViewController.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//

import UIKit

enum DiscoverType{
    case genre
    case topRated
    case popular
}

class SearchViewController: UIViewController {

    @IBOutlet weak var tableSearch: UITableView!
    
    
    private lazy var viewModel = SearchViewModel(self)
    lazy var navigator = SearchNavigator(self)
    
    var arrayData = [Genres]()
    var arraySearch = [Results]()
    var arrayTopRatedAndPopular = [
        ["Title": "Popular movies", "SubTitle": "The hottest movies on the internet", "type": DiscoverType.popular],
        ["Title": "Top rated movies", "SubTitle": "The top rated movies on the internet", "type" : DiscoverType.topRated]
    ]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        configureSearchBar()
        // Do any additional setup after loading the view.
    }
    
    func prepareView(){
        tableSearch.register(GenreCell.self)
        tableSearch.register(DiscoverCell.self)
        tableSearch.register(PopularAndTopRatedCell.self)
        viewModel.callGenreListApi()
    }
    
    func successApiResponse(_ genreData: [Genres]?){
        guard let genreData = genreData else {
            self.showValidationMessage(withMessage: "Genres could not get.")
            return
        }
        arrayData = genreData
        
        DispatchQueue.main.async {
            self.tableSearch.reloadData()
        }
    }
    
    func successSearchApiResponse(_ result: [Results]?){
        guard let result = result else {
            self.showValidationMessage(withMessage: "Genres could not get.")
            return
        }
        arraySearch = result
        
        DispatchQueue.main.async {
            self.tableSearch.reloadData()
        }
    }
    
    func configureSearchBar() {
        let search = UISearchController(searchResultsController: nil)
        search.delegate = self
        search.searchBar.delegate = self
        self.navigationItem.searchController = search
    }
}

extension SearchViewController: UISearchBarDelegate, UISearchControllerDelegate{
    func willPresentSearchController(_ searchController: UISearchController) {
        viewModel.isSearchingMode = true
        
        DispatchQueue.main.async {
            self.tableSearch.reloadData()
        }
        print("Present")
    }
    func willDismissSearchController(_ searchController: UISearchController) {
        viewModel.isSearchingMode = false
        viewModel.queryString = searchController.searchBar.text ?? ""
        viewModel.currentPage = 1
        arraySearch = []
        DispatchQueue.main.async {
            self.tableSearch.reloadData()
        }
        print("Dismiss")
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.queryString = searchText
        viewModel.callSearchMovieApi()
    }
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewModel.queryString = searchBar.text ?? ""
        viewModel.callSearchMovieApi()
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        if viewModel.isSearchingMode{
            return 1
        }else{
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.isSearchingMode{
            return arraySearch.count
        }else{
            if section == 0{
                return arrayTopRatedAndPopular.count
            }else{
                return arrayData.count
            }
            
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if viewModel.isSearchingMode{
            return AppConstants.searchResultHeader
        }else{
            if section == 0{
                return AppConstants.popularTopRatedMoviesHeader
            }else{
                return AppConstants.genreHeader
            }
        }
        
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if viewModel.isSearchingMode{
            let data = arraySearch[indexPath.row]
            let cell : DiscoverCell = tableView.dequeueReusableCell(for: indexPath)
            cell.setupData(data)
            return cell
        }else{
            if indexPath.section == 0{
                let data = arrayTopRatedAndPopular[indexPath.row]
                let cell : PopularAndTopRatedCell = tableView.dequeueReusableCell(for: indexPath)
                cell.setupData(data)
                return cell
            }else{
                let data = arrayData[indexPath.row]
                let cell : GenreCell = tableView.dequeueReusableCell(for: indexPath)
                cell.setupData(data)
                return cell
            }
            
        }
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if viewModel.isSearchingMode{
            let result = arraySearch[indexPath.row]
            navigator.moveToMovieDetailScreen(with: result)
        }else{
            
            if indexPath.section == 0{
                let data = arrayTopRatedAndPopular[indexPath.row]
                navigator.moveToDiscover(withDiscover: ((data["type"] as? DiscoverType) ?? DiscoverType.popular))
            }else{
                let data = arrayData[indexPath.row]
                navigator.moveToDiscover(with: data, withDiscover: .genre)
            }
            
            
        }
        
    }
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//        if viewModel.isSearchingMode{
//            let lastSectionIndex = tableView.numberOfSections - 1
//            let lastRowIndex = tableView.numberOfRows(inSection: lastSectionIndex) - 1
//            if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
//                let spinner = UIActivityIndicatorView(style: .medium)
//                spinner.startAnimating()
//                spinner.frame = CGRect(x: CGFloat(0), y: CGFloat(0), width: tableView.bounds.width, height: CGFloat(44))
//                self.tableSearch.tableFooterView = spinner
//
//                if !viewModel.isAllMovieFetched{
//                    viewModel.currentPage += 1
//                    viewModel.callSearchMovieApi()
//                }
//                self.tableSearch.tableFooterView?.isHidden = viewModel.isAllMovieFetched
//            }
//        }
//
//    }
    
}
 
