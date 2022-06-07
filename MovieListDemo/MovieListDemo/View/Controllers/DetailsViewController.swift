//
//  DetailsViewController.swift
//  MovieListDemo
//
//  Created by PCQ229 on 07/06/22.
//

import UIKit

class DetailsViewController: UIViewController {
    
    
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var progressView: CircleProgressView!
    @IBOutlet weak var genreLabel: UILabel!
    @IBOutlet weak var releaseDateLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    
    var data: Results?
    
    private lazy var viewModel = DetailsViewModel(self)
    lazy var navigator = DetailsNavigator(self)
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        prepareView()
    }
    
    func prepareView(){
        guard let data = data else {
            self.showValidationMessage(withMessage: "Data could not get.")
            return
        }

        let posterPath = Environment.basePosterImageURL() + (data.poster_path ?? "")
        let coverPath = Environment.baseCoverImageURL() + (data.backdrop_path ?? "")
        coverImage.setImageUsingUrlSession(coverPath, placeholder: UIImage(systemName: "photo"))
        posterImage.setImageUsingUrlSession(posterPath, placeholder: UIImage(systemName: "photo"))
        titleLabel.text = data.title
        viewModel.callGenreListApi()
        DispatchQueue.main.async {
            self.croppedImage()
        }
    }
    
    func croppedImage(){
        let layer = CAShapeLayer()
        let path = UIBezierPath()
        path.move(to: CGPoint(x: 0, y: ((coverImage.bounds.midY + coverImage.bounds.maxY) / 2.3)))
        path.addLine(to: CGPoint(x: 0, y: coverImage.bounds.maxY))
        path.addLine(to: CGPoint(x: coverImage.bounds.maxX, y: coverImage.bounds.maxY))
        path.close()
        layer.path = path.cgPath
        layer.fillColor = UIColor.white.cgColor
        layer.strokeColor = nil
        coverImage.layer.addSublayer(layer)
    }
    
    func successApiResponse(_ genreData: Genre?){
        guard let data = data else {
            self.showValidationMessage(withMessage: "Data could not get.")
            return
        }
        
        guard let genreData = genreData else {
            self.showValidationMessage(withMessage: "Data could not get.")
            return
        }

        genreLabel.text = genreData.genres?.first?.name ?? "Action"
        releaseDateLabel.text = data.release_date
        descriptionLabel.text = data.overview
        progressView.progress = (data.vote_average ?? 0.0) / 10
        
    }
    
    @IBAction func reviewButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func trailersButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func creditsButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func similarButtonAction(_ sender: UIButton) {
    }
    
    @IBAction func moreButtonAction(_ sender: UIBarButtonItem) {
    }
}
