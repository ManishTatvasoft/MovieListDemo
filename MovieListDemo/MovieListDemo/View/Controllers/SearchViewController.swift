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

    @IBOutlet private weak var tableSearch: UITableView!
    
    
    private lazy var viewModel = SearchViewModel(self)
    private lazy var navigator = SearchNavigator(self)
    
    var arrayData = [Genres]()
    var arraySearch = [Results]()
    var arrayTopRatedAndPopular = [
        ["Title": "Popular movies", "SubTitle": "The hottest movies on the internet", "type": DiscoverType.popular],
        ["Title": "Top rated movies", "SubTitle": "The top rated movies on the internet", "type" : DiscoverType.topRated]
    ]
    
    var arrayMovies = [Movie]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(_ animated: Bool) {
        arrayMovies = DatabaseManager.shared.getData()
        if #available(iOS 11.0, *) {
            self.navigationItem.hidesSearchBarWhenScrolling = false
        }
        
        prepareView()
        
    }
    
    override func viewDidAppear(_ animated: Bool) {
        if #available(iOS 11.0, *) {
            self.navigationItem.hidesSearchBarWhenScrolling = true
        }
        self.navigationController?.navigationBar.sizeToFit()
    }
    
    func prepareView(){
        tableSearch.register(GenreCell.self)
        tableSearch.register(DiscoverCell.self)
        tableSearch.register(PopularAndTopRatedCell.self)
        tableSearch.register(RecentlyVisitedCell.self)
        viewModel.callGenreListApi()
    }
    
    func successApiResponse(_ genreData: [Genres]?){
        guard let genreData = genreData else {
            self.showValidationMessage(withMessage: String.Title.genereNotFound)
            return
        }
        arrayData = genreData
        
        DispatchQueue.main.async { [weak self] in
            self?.tableSearch.reloadData()
        }
    }
    
    func successSearchApiResponse(_ result: [Results]?){
        guard let result = result else {
            self.showValidationMessage(withMessage: String.Title.genereNotFound)
            return
        }
        arraySearch = result
        
        DispatchQueue.main.async { [weak self] in
            self?.tableSearch.reloadData()
        }
    }
    
    func configureSearchBar() {
        let search = UISearchController(searchResultsController: nil)
        search.delegate = self
        search.searchBar.delegate = self
        if #available(iOS 11.0, *) {
            self.navigationItem.searchController = search
        } else {
            self.navigationItem.titleView = search.view
        }
    }
}

extension SearchViewController: UISearchBarDelegate, UISearchControllerDelegate{
    func willPresentSearchController(_ searchController: UISearchController) {
        viewModel.isSearchingMode = true
        
        DispatchQueue.main.async { [weak self] in
            self?.tableSearch.reloadData()
        }
        print("Present")
    }
    func willDismissSearchController(_ searchController: UISearchController) {
        viewModel.isSearchingMode = false
        viewModel.queryString = searchController.searchBar.text ?? ""
        viewModel.currentPage = 1
        arraySearch = []
        DispatchQueue.main.async { [weak self] in
            self?.tableSearch.reloadData()
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
        }else if arrayMovies.count > 0{
            return 3
        }else{
            return 2
        }
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if viewModel.isSearchingMode{
            return arraySearch.count
        }else{
            if arrayMovies.count > 0{
                if section == 0{
                    return 1
                }else if section == 1{
                    return arrayTopRatedAndPopular.count
                }else{
                    return arrayData.count
                }
            }else{
                if section == 0{
                    return arrayTopRatedAndPopular.count
                }else{
                    return arrayData.count
                }
            }
        }
    }
    
    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if viewModel.isSearchingMode{
            return AppConstants.searchResultHeader
        }else{
            if arrayMovies.count > 0{
                if section == 0{
                    return AppConstants.recentlyVisitedHeader
                }else if section == 1{
                    return AppConstants.popularTopRatedMoviesHeader
                }else{
                    return AppConstants.genreHeader
                }
            }else{
                if section == 0{
                    return AppConstants.popularTopRatedMoviesHeader
                }else{
                    return AppConstants.genreHeader
                }
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
            if arrayMovies.count > 0{
                if indexPath.section == 0{
                    let cell : RecentlyVisitedCell = tableView.dequeueReusableCell(for: indexPath)
                    cell.delegate = self
                    cell.setupData(arrayMovies.reversed())
                    return cell
                }else if indexPath.section == 1{
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
        
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if viewModel.isSearchingMode{
            let result = arraySearch[indexPath.row]
            var movie = Movie()
            movie.movieName = result.title ?? ""
            movie.movieID = "\(result.id ?? 0)"
            movie.posterPath = result.poster_path ?? ""
            movie.time = "\(Date())"
            DatabaseManager.shared.checkAndInserData(movie)
            navigator.moveToMovieDetailScreen(with: result)
        }else{
            if arrayMovies.count > 0{
                if indexPath.section == 0{
                        print("")
                }else if indexPath.section == 1{
                    let data = arrayTopRatedAndPopular[indexPath.row]
                    navigator.moveToDiscover(withDiscover: ((data["type"] as? DiscoverType) ?? DiscoverType.popular))
                }else{
                    let data = arrayData[indexPath.row]
                    navigator.moveToDiscover(with: data, withDiscover: .genre)
                }
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
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if viewModel.isSearchingMode{
            return UITableView.automaticDimension
        }else{
            if arrayMovies.count > 0{
                if indexPath.section == 0{
                    let width = (self.view.bounds.width - 20) / 3
                    let height = width * 1.5
                    return height
                }else{
                    return UITableView.automaticDimension
                }
            }else{
                return UITableView.automaticDimension
            }
        }
    }
    
}
 
extension SearchViewController: RecentlyVisitedCellDelegate{
    func getMovieResult(with movieID: String, _ genre: String) {
        AppConstants.movieID = movieID
        viewModel.getResultFromMovieID(movieID: movieID) { data in
            DispatchQueue.main.async {
                self.navigator.moveToMovieDetailScreen(with: data, isDBData: true, genre: genre)
            }
            
        }
    }
}
