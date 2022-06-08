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
    
    func scrollViewDidEndDragging(_ scrollView: UIScrollView, willDecelerate decelerate: Bool) {
        if ((scrollView.contentOffset.y + scrollView.frame.size.height) >= scrollView.contentSize.height){
            if !viewModel.isAllMovieFetched{
                viewModel.currentPage += 1
                viewModel.callSimilarMovieApi()
            }
        }
    }
    
}
