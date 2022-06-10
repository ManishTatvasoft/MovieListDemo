//
//  DiscoverCell.swift
//  MovieListDemo
//
//  Created by PCQ229 on 09/06/22.
//

import UIKit

class DiscoverCell: UITableViewCell {
    @IBOutlet private weak var movieImage: UIImageView!
    @IBOutlet private weak var titlelabel: UILabel!
    @IBOutlet private weak var ratingsView: CircleProgressView!
    @IBOutlet private weak var dateLabel: UILabel!
    @IBOutlet private weak var genreLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(_ data: Results, _ genre: String? = "Action"){
        let posterPath = Environment.basePosterImageURL() + (data.poster_path ?? "")
        if #available(iOS 13.0, *) {
            movieImage.setImageUsingUrlSession(posterPath, placeholder: UIImage(systemName: "photo"))
        } else {
            movieImage.setImageUsingUrlSession(posterPath, placeholder: UIImage(named: "photo"))
        }
        titlelabel.text = data.title
        ratingsView.progress = (data.vote_average ?? 0.0) / 10
        dateLabel.text = data.release_date
        let param = [AppConstants.apiKey: AppConstants.apiKeyValue]
        DetailsController.shared.getGenreList(parameters: param) { response in
            self.genreLabel.text = AppConstants.getGenreString(data, response)
        } failureCompletion: { failure, errorMessage in
            self.genreLabel.text = ""
        }

    }
    
}
