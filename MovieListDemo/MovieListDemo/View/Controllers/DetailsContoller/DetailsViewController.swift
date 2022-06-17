//
//  DetailsViewController.swift
//  MovieListDemo
//
//  Created by PCQ229 on 07/06/22.
//

import UIKit
import MTCircularSlider

class DetailsViewController: BaseViewController {
    
    @IBOutlet private weak var coverImage: UIImageView!
    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var progressView: MTCircularSlider!
    @IBOutlet private weak var progressValue: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var releaseDateLabel: UILabel!
    @IBOutlet private weak var descriptionLabel: UILabel!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var scrollView: UIScrollView!
    
    var data: Results?
    var isDBData = false
    var genre = ""
    
    private lazy var viewModel = DetailsViewModel()
    private lazy var navigator = DetailsNavigator(self)
    
    override func viewDidLoad() {
        super.viewDidLoad()
        emptyDataSetSetup()
    }
    
    override func viewWillAppear(_ animated: Bool) {
        prepareView()
    }
    
    override func viewDidLayoutSubviews() {
        croppedImage()
    }
    
    override func viewDidAppear(_ animated: Bool) {
        croppedImage()
    }
    
    func emptyDataSetSetup(){
        AppConstants.setUpEmptyDataset(scrollView) { [weak self] in
            self?.prepareView()
        }
    }
    
    func prepareView() {
        guard let data = data else {
            showValidationMessage(withMessage: String.Title.dataNotFound)
            coverImage.image = nil
            posterImage.image = nil
            titleLabel.text = nil
            releaseDateLabel.text = nil
            descriptionLabel.text = nil
            progressView.value = 0.0
            progressValue.text = nil
            genreLabel.text = nil
            return
        }
        let posterPath = Environment.basePosterImageURL() + (data.poster_path ?? "")
        let coverPath = Environment.baseCoverImageURL() + (data.backdrop_path ?? "")
        coverImage.setImageUsingUrl(coverPath, placeholder: UIImage.universalImage("photo"))
        posterImage.setImageUsingUrl(posterPath, placeholder: UIImage.universalImage("photo"))
        titleLabel.text = data.title
        AppConstants.movieID = "\(data.id ?? 0)"
        releaseDateLabel.text = data.release_date
        descriptionLabel.text = data.overview
        progressView.value = CGFloat(data.vote_average ?? 0.0)
        progressValue.text = "\((round(10 * (data.vote_average ?? 0.0)) / 10))"
        if isDBData {
            genreLabel.text = genre
        } else {
            apiCall(data)
        }
    }
    
    func apiCall(_ data: Results) {
        genreLabel.text = AppConstants.getGenreString(data)
    }
    
    func croppedImage() {
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
    
    @IBAction func reviewButtonAction(_ sender: UIButton) {
        navigator.moveToReview(data?.title)
    }
    
    @IBAction func trailersButtonAction(_ sender: UIButton) {
        navigator.moveToVideo(data?.title)
    }
    
    @IBAction func creditsButtonAction(_ sender: UIButton) {
        navigator.moveToCredits(data?.title)
    }
    
    @IBAction func similarButtonAction(_ sender: UIButton) {
        navigator.moveToSimilar(data?.title)
    }
    
    @IBAction func moreButtonAction(_ sender: UIBarButtonItem) {
        showAlertAndSheet(with: nil, withMessage: data?.title ?? String.Title.movieDefaultTitle, preferredStyle: .actionSheet) { [weak self] in
            AppConstants.share(self?.posterImage.image)
        } failure: {
            print("")
        }
    }
}
