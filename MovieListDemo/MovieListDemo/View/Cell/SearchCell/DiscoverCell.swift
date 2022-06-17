//
//  DiscoverCell.swift
//  MovieListDemo
//
//  Created by PCQ229 on 09/06/22.
//

import UIKit
import MTCircularSlider

class DiscoverCell: UITableViewCell {
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
    
    func setupData(_ data: Results, _ genre: String? = "Action") {
        let posterPath = Environment.basePosterImageURL() + (data.poster_path ?? "")
        if #available(iOS 13.0, *) {
            movieImage.setImageUsingUrl(posterPath, placeholder: UIImage(systemName: "photo"))
        } else {
            movieImage.setImageUsingUrl(posterPath, placeholder: UIImage(named: "photo"))
        }
        titlelabel.text = data.title
        ratingsView.value = CGFloat(data.vote_average ?? 0.0)
        progressValue.text = "\((round(10 * (data.vote_average ?? 0.0)) / 10))"
        dateLabel.text = data.release_date
        genreLabel.text = AppConstants.getGenreString(data)
    }
    
}
