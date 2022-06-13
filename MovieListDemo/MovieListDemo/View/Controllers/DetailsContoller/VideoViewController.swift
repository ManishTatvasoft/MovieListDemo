//
//  VideoViewController.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import UIKit

class VideoViewController: BaseViewController {
    
    
    @IBOutlet private weak var tableVideo: UITableView!
    private lazy var viewModel = VideoViewModel(self)
    private lazy var navigator = VideoNavigator(self)
    var arrayData = [VideoResults]()
    
    var name: String?

    override func viewDidLoad() {
        super.viewDidLoad()
        self.title = name ?? "Videos"
        prepareView()
        // Do any additional setup after loading the view.
    }
    
    func prepareView(){
        tableVideo.register(VideoCell.self)
        viewModel.callVideoListApi()
    }
    
    func successApiResponse(_ data: [VideoResults]?){
        guard let data = data else {
            self.showValidationMessage(withMessage: String.Title.dataNotFound)
            return
        }
        self.arrayData = data
        
        DispatchQueue.main.async { [weak self] in
            self?.tableVideo.reloadData()
        }
    }

}

extension VideoViewController: UITableViewDelegate, UITableViewDataSource{
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
extension VideoViewController{
    func tableView(_ tableView: UITableView, contextMenuConfigurationForRowAt indexPath: IndexPath, point: CGPoint) -> UIContextMenuConfiguration? {
        let index = indexPath.row
        let data = arrayData[index]
        
        // 2
        let identifier = "\(index)" as NSString
        
        return UIContextMenuConfiguration(
            identifier: identifier,
            previewProvider: nil) { _ in
                let watchAction = UIAction(
                    title: "Watch Video",
                    image: UIImage(systemName: "eye")) { _ in
                        self.navigator.playVideo(from: data)
                    }
                
                // 5
                return UIMenu(title: "", image: nil, children: [watchAction])
            }
    }
}

