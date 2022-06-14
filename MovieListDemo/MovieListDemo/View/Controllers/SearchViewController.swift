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

enum SectionCount: Int{
    case search = 1
    case withOutRecentlyVisited
    case withRecentlyVisited
}

class SearchViewController: BaseViewController {

    @IBOutlet private weak var tableSearch: UITableView!
    
    
    private lazy var viewModel = SearchViewModel()
    private lazy var navigator = SearchNavigator(self)
    
    var arrayData = [Genres]()
    var arraySearch = [Results]()
    var arrayTopRatedAndPopular = [
        [AppConstants.titleKey: "Popular movies", AppConstants.subTitleKey: "The hottest movies on the internet", AppConstants.typeKey: DiscoverType.popular],
        [AppConstants.titleKey: "Top rated movies", AppConstants.subTitleKey: "The top rated movies on the internet", AppConstants.typeKey : DiscoverType.topRated]
    ]
    
    var arrayMovies = [Movie]()
    var sectionCount = SectionCount.withOutRecentlyVisited
    
    override func viewDidLoad() {
        super.viewDidLoad()
        configureSearchBar()
        
    }
    override func viewWillAppear(_ animated: Bool) {
        arrayMovies = DatabaseManager.shared.getData()
        
        
        if viewModel.isSearchingMode{
            sectionCount = .search
        }else if arrayMovies.count > 0{
            sectionCount = .withRecentlyVisited
        }else{
            sectionCount = .withOutRecentlyVisited
        }
        
        prepareView()
        
    }
    
    func prepareView(){
        tableSearch.register(GenreCell.self)
        tableSearch.register(DiscoverCell.self)
        tableSearch.register(PopularAndTopRatedCell.self)
        tableSearch.register(RecentlyVisitedCell.self)
        self.startLoading()
        viewModel.callGenreListApi { [weak self] results, isSuccess, errorMessage in
            
            guard let self = self else{
                self?.stopLoading()
                self?.showValidationMessage(withMessage: String.Title.genereNotFound)
                return
            }
            self.stopLoading()
            if isSuccess{
                guard let results = results else {
                    self.showValidationMessage(withMessage: String.Title.genereNotFound)
                    return
                }
                self.arrayData = results
                
                DispatchQueue.main.async {
                    self.tableSearch.reloadData()
                }
            }else{
                self.showValidationMessage(withMessage: errorMessage)
            }
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
        DispatchQueue.main.async { [weak self] in
            self?.navigationController?.navigationBar.sizeToFit()
        }
    }
}

extension SearchViewController: UISearchBarDelegate, UISearchControllerDelegate{
    func willPresentSearchController(_ searchController: UISearchController) {
        viewModel.isSearchingMode = true
        sectionCount = .search
        DispatchQueue.main.async { [weak self] in
            self?.tableSearch.reloadData()
        }
    }
    func willDismissSearchController(_ searchController: UISearchController) {
        viewModel.isSearchingMode = false
        viewModel.queryString = searchController.searchBar.text ?? ""
        arraySearch = []
        if arrayMovies.count > 0{
            sectionCount = .withRecentlyVisited
        }else{
            sectionCount = .withOutRecentlyVisited
        }
        DispatchQueue.main.async { [weak self] in
            self?.tableSearch.reloadData()
        }
    }
    
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        viewModel.queryString = searchText
        callSearchApi()
    }
    
    
    
    func searchBarTextDidEndEditing(_ searchBar: UISearchBar) {
        viewModel.queryString = searchBar.text ?? ""
        callSearchApi()
    }
    
    func callSearchApi(){
        viewModel.callSearchMovieApi { [weak self] results, isSuccess, errorMessage in
            guard let self = self else{
                self?.view.showToast(message: String.Title.somthingWentWrong)
                return
            }
            if isSuccess{
                guard let results = results else {
                    self.view.showToast(message: String.Title.somthingWentWrong)
                    return
                }
                self.arraySearch = results
                DispatchQueue.main.async { [weak self] in
                    self?.tableSearch.reloadData()
                }
            }else{
                self.view.showToast(message: errorMessage)
            }
        }
    }
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return sectionCount.rawValue
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
                    navigator.moveToDiscover(withDiscover: ((data[AppConstants.typeKey] as? DiscoverType) ?? DiscoverType.popular))
                }else{
                    let data = arrayData[indexPath.row]
                    navigator.moveToDiscover(with: data, withDiscover: .genre)
                }
            }else{
                if indexPath.section == 0{
                    let data = arrayTopRatedAndPopular[indexPath.row]
                    navigator.moveToDiscover(withDiscover: ((data[AppConstants.typeKey] as? DiscoverType) ?? DiscoverType.popular))
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
                    let width = (self.view.bounds.width - 20) / 4
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
    
    func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 60
    }
    
    func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        let headerView = UIView()
        
        let viewTopLine = UIView()
        viewTopLine.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(viewTopLine)
        viewTopLine.backgroundColor = #colorLiteral(red: 0.8431372549, green: 0.8431372549, blue: 0.8431372549, alpha: 1)
        NSLayoutConstraint.activate([
            viewTopLine.topAnchor.constraint(equalTo: headerView.topAnchor),
            viewTopLine.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            viewTopLine.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            viewTopLine.heightAnchor.constraint(equalToConstant: 1),
        ])
        
        let viewBottomLine = UIView()
        viewBottomLine.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(viewBottomLine)
        viewBottomLine.backgroundColor = #colorLiteral(red: 0.8431372549, green: 0.8431372549, blue: 0.8431372549, alpha: 1)
        NSLayoutConstraint.activate([
            viewBottomLine.bottomAnchor.constraint(equalTo: headerView.bottomAnchor, constant: 0),
            viewBottomLine.leadingAnchor.constraint(equalTo: headerView.leadingAnchor),
            viewBottomLine.trailingAnchor.constraint(equalTo: headerView.trailingAnchor),
            viewBottomLine.heightAnchor.constraint(equalToConstant: 1),
        ])
        
        let headerText = UILabel()
        headerText.translatesAutoresizingMaskIntoConstraints = false
        headerView.addSubview(headerText)
        NSLayoutConstraint.activate([
            headerText.topAnchor.constraint(greaterThanOrEqualTo: viewTopLine.bottomAnchor, constant: 5),
            headerText.bottomAnchor.constraint(equalTo: viewBottomLine.topAnchor, constant: -5),
            headerText.leadingAnchor.constraint(equalTo: headerView.leadingAnchor, constant: 10),
            headerText.trailingAnchor.constraint(equalTo: headerView.trailingAnchor, constant: -10),
        ])
        
        
        headerText.text = tableViewTitle(forHeaderIn: section)
        headerText.font = UIFont.systemFont(ofSize: 14, weight: .regular)
        headerText.textColor = .darkGray
        headerView.backgroundColor = #colorLiteral(red: 0.9499530196, green: 0.9499530196, blue: 0.9499530196, alpha: 1)
        return headerView
    }
    
    func tableViewTitle(forHeaderIn section: Int) -> String{
        if viewModel.isSearchingMode{
            return AppConstants.searchResultHeader.uppercased()
        }else{
            if arrayMovies.count > 0{
                if section == 0{
                    return AppConstants.recentlyVisitedHeader.uppercased()
                }else if section == 1{
                    return AppConstants.popularTopRatedMoviesHeader.uppercased()
                }else{
                    return AppConstants.genreHeader.uppercased()
                }
            }else{
                if section == 0{
                    return AppConstants.popularTopRatedMoviesHeader.uppercased()
                }else{
                    return AppConstants.genreHeader.uppercased()
                }
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
