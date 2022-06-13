//
//  UpcomingViewController.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//

import UIKit

class UpcomingViewController: BaseViewController {


    @IBOutlet private weak var collectionMovies: UICollectionView!
    private lazy var viewModel = UpcommingMovieViewModel(self)
    private lazy var navigator = UpcomingMovieNavigator(self)
    var arrData = [Results]()
    var gridListBarButton : UIBarButtonItem!
    override func viewDidLoad() {
        super.viewDidLoad()
        gridListBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(gridListToggleAction(_:)))
        gridListBarButton.setBackgroundImage(UIImage.universalImage(viewModel.isListView ? "list.bullet" : "rectangle.grid.3x2"), for: .normal, barMetrics: .default)
        prepareView()
        self.navigationItem.leftBarButtonItem = gridListBarButton
        // Do any additional setup after loading the view.
    }
    

    @objc func gridListToggleAction(_ sender: UIBarButtonItem) {
        viewModel.isListView.toggle()
        sender.setBackgroundImage(UIImage.universalImage(viewModel.isListView ? "list.bullet" : "rectangle.grid.3x2"), for: .normal, barMetrics: .default)
        self.collectionMovies?.scrollToItem(at: IndexPath(row: 0, section: 0),at: .top,animated: false)
        DispatchQueue.main.async { [weak self] in
            self?.collectionMovies.reloadData()
        }
    }

    func prepareView(){
        viewModel.callUpcomingMovieApi()
        collectionMovies.register(UpcommingMovieGridCell.self)
        collectionMovies.register(UpcommingMovieListCell.self)
    }
    
    func successApiResponse(_ data: [Results]?){
        
        guard let data = data else {
            self.showValidationMessage(withMessage: String.Title.dataNotFound)
            return
        }
        self.arrData.append(contentsOf: data)
        
        DispatchQueue.main.async { [weak self] in
            self?.collectionMovies.reloadData()
        }
    }
}

extension UpcomingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout{
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = arrData[indexPath.item]
        if viewModel.isListView{
            let cell: UpcommingMovieListCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setupData(with: data)
            return cell
        }else{
            let cell: UpcommingMovieGridCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setupData(data.poster_path)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        if !viewModel.isListView{
            let width = (collectionView.bounds.width / 3) - (((collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset.right ?? 0.0) / 1.5)
            let height = width * 1.5
            return CGSize(width: width, height: height)
        }else{
            let width = collectionView.bounds.width * 0.95
            let height = width * 0.58
            return CGSize(width: width, height: height)
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, didSelectItemAt indexPath: IndexPath) {
        let result = arrData[indexPath.item]
        AppConstants.addDataToDb(result)
        navigator.moveToCharecterListScreen(with: result)
    }
    
    func collectionView(_ collectionView: UICollectionView, willDisplay cell: UICollectionViewCell, forItemAt indexPath: IndexPath) {
        let lastSectionIndex = collectionView.numberOfSections - 1
        let lastRowIndex = collectionView.numberOfItems(inSection: lastSectionIndex) - 1
        if indexPath.section ==  lastSectionIndex && indexPath.row == lastRowIndex {
            let bottomRefreshController = UIRefreshControl()
            self.collectionMovies.refreshControl = bottomRefreshController
            
            if !viewModel.isAllMovieFetched{
                viewModel.currentPage += 1
                viewModel.callUpcomingMovieApi()
            }
            self.collectionMovies.refreshControl?.isHidden = viewModel.isAllMovieFetched
        }
    }
}
