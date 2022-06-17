//
//  UpcomingViewController.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//

import UIKit
import EmptyDataSet_Swift

class UpcomingViewController: BaseViewController {


    @IBOutlet private weak var collectionMovies: UICollectionView!
    
    private lazy var viewModel = UpcommingMovieViewModel()
    private lazy var navigator = UpcomingMovieNavigator(self)
    var arrData = [Results]()
    var gridListBarButton: UIBarButtonItem!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        gridListBarButton = UIBarButtonItem(title: "", style: .plain, target: self, action: #selector(gridListToggleAction(_:)))
        gridListBarButton.setBackgroundImage(UIImage.universalImage(viewModel.isListView ? "list.bullet" : "rectangle.grid.3x2"), for: .normal, barMetrics: .default)
        prepareView()
        navigationItem.leftBarButtonItem = gridListBarButton
        // Do any additional setup after loading the view.
    }
    
    func emptyDataSetSetup(){
        AppConstants.setUpEmptyDataset(collectionMovies) { [weak self] in
            self?.prepareView()
        }
    }
    
    @objc func gridListToggleAction(_ sender: UIBarButtonItem) {
        viewModel.isListView.toggle()
        sender.setBackgroundImage(UIImage.universalImage(viewModel.isListView ? "list.bullet" : "rectangle.grid.3x2"), for: .normal, barMetrics: .default)
        if arrData.count > 0{
            collectionMovies.setContentOffset(.zero, animated: false)
        }else{
            prepareView()
        }
        DispatchQueue.main.async { [weak self] in
            self?.collectionMovies.reloadData()
        }
    }

    func prepareView() {
        startLoading()
        apiResponse { [weak self] in
            self?.stopLoading()
        }
        collectionMovies.register(UpcommingMovieGridCell.self)
        collectionMovies.register(UpcommingMovieListCell.self)
    }
    
    func apiResponse(completion: (() -> Void)?){
        viewModel.callUpcomingMovieApi { [weak self] data,isSuccess,errorMessage in
            guard let self = self else{
                completion?()
                return
            }
            if isSuccess {
                guard let data = data else {
                    self.showValidationMessage(withMessage: String.Title.dataNotFound)
                    return
                }
                self.arrData.append(contentsOf: data)
                
                DispatchQueue.main.async {
                    self.collectionMovies.reloadData()
                }
            } else {
                self.emptyDataSetSetup()
                DispatchQueue.main.async {
                    self.showValidationMessage(withMessage: errorMessage)
                }
            }
            completion?()
        }
    }
}

extension UpcomingViewController: UICollectionViewDelegate, UICollectionViewDataSource, UICollectionViewDelegateFlowLayout {
    func collectionView(_ collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        arrData.count
    }
    
    func collectionView(_ collectionView: UICollectionView, cellForItemAt indexPath: IndexPath) -> UICollectionViewCell {
        let data = arrData[indexPath.item]
        if viewModel.isListView {
            let cell: UpcommingMovieListCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setupData(with: data)
            return cell
        } else {
            let cell: UpcommingMovieGridCell = collectionView.dequeueReusableCell(for: indexPath)
            cell.setupData(data.poster_path)
            return cell
        }
    }
    
    func collectionView(_ collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAt indexPath: IndexPath) -> CGSize {
        let cellValue: CGFloat = viewModel.isListView ? 1 : 3
        let collectioViewWidth = collectionView.bounds.width
        let specing = ( cellValue * ((collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.minimumInteritemSpacing ?? 0.0))
        let leftSectionInset = (((collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset.left ?? 0.0))
        let rightSectionInset = (((collectionView.collectionViewLayout as? UICollectionViewFlowLayout)?.sectionInset.right ?? 0.0))
        if !viewModel.isListView {
            let width = (collectioViewWidth - specing - leftSectionInset) / cellValue
            let height = width * 1.6
            return CGSize(width: width, height: height)
        } else {
            let width = (collectioViewWidth - leftSectionInset - rightSectionInset)
            let height = width * 0.55
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
            if !viewModel.isAllMovieFetched {
                apiResponse(completion: nil)
            }
        }
    }
}
