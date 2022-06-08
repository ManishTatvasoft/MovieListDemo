//
//  SearchViewController.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//

import UIKit

class SearchViewController: UIViewController {

    @IBOutlet weak var tableSearch: UITableView!
    
    private lazy var viewModel = SearchViewModel(self)
    lazy var navigator = SearchViewModel(self)
    
    var arrayData = [Genres]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        prepareView()
        // Do any additional setup after loading the view.
    }
    
    func prepareView(){
        tableSearch.register(GenreCell.self)
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
}

extension SearchViewController: UITableViewDelegate, UITableViewDataSource{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = arrayData[indexPath.row]
        let cell : GenreCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setupData(data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
    }
    
    
}
