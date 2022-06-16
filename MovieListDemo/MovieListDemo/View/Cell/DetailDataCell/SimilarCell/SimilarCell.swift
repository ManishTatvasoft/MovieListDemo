//
//  SimilarCell.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import UIKit
import Alamofire
import MTCircularSlider

class SimilarCell: UITableViewCell {

    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var titlelabel: UILabel!
    @IBOutlet private weak var ratingsView: MTCircularSlider!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    @IBOutlet private weak var progressValue: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(_ data: Results){
        let posterPath = Environment.basePosterImageURL() + (data.poster_path ?? "")
        movieImage.setImageUsingUrl(posterPath, placeholder: UIImage.universalImage("photo"))
        titlelabel.text = data.title
        ratingsView.value = CGFloat(data.vote_average ?? 0.0)
        progressValue.text = "\((round(10 * (data.vote_average ?? 0.0)) / 10))"
        dateLabel.text = data.release_date
        self.genreLabel.text = AppConstants.getGenreString(data)
    }
}
