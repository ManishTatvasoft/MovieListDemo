//
//  VideoViewController.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import UIKit

class VideoViewController: BaseViewController {
    
    
    @IBOutlet private weak var tableVideo: UITableView!
    
    private lazy var viewModel = VideoViewModel()
    private lazy var navigator = VideoNavigator(self)
    var arrayData = [VideoResults]()
    var name: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        title = name ?? "Videos"
        prepareView()
        // Do any additional setup after loading the view.
    }
    func emptyDataSetSetup(){
        AppConstants.setUpEmptyDataset(tableVideo) { [weak self] in
            self?.prepareView()
        }
    }
    
    func prepareView() {
        tableVideo.register(VideoCell.self)
        self.startLoading()
        viewModel.callVideoListApi { [weak self] videoResult, isSuccess, errorMessage in
            guard let self = self else {
                self?.stopLoading()
                self?.showValidationMessage(withMessage: String.Title.dataNotFound)
                return
            }
            self.stopLoading()
            if isSuccess {
                guard let data = videoResult else {
                    self.showValidationMessage(withMessage: String.Title.dataNotFound)
                    return
                }
                self.arrayData = data
                if self.arrayData.count == 0 {
                    self.showValidationMessage(withMessage: String.Title.noVideoFound, preferredStyle: .alert) {
                        self.navigationController?.popViewController(animated: true)
                    }
                }
                DispatchQueue.main.async {
                    self.tableVideo.reloadData()
                }
            } else {
                self.emptyDataSetSetup()
                DispatchQueue.main.async {
                    self.showValidationMessage(withMessage: errorMessage)
                }
            }
        }
    }
}

extension VideoViewController: UITableViewDelegate, UITableViewDataSource {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return arrayData.count
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let data = arrayData[indexPath.row]
        let cell : VideoCell = tableView.dequeueReusableCell(for: indexPath)
        cell.setupData(data)
        return cell
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        let data = arrayData[indexPath.row]
        navigator.playVideo(from: data)
    }
    
}


@available(iOS 13.0, *)
extension VideoViewController {
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let index = indexPath.row
        let data = arrayData[index]
        let identifier = "\(index)" as NSString
        
        return UIContextMenuConfiguration(
            identifier: identifier,
            previewProvider: nil) { _ in
                let watchAction = UIAction(
                    title: String.Title.watchVideo,
                    image: UIImage(systemName: "eye")) { [weak self] _ in
                        self?.navigator.playVideo(from: data)
                    }
                return UIMenu(title: "", image: nil, children: [watchAction])
            }
    }
}

