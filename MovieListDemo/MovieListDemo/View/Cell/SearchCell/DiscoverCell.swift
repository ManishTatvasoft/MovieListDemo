//
//  DiscoverCell.swift
//  MovieListDemo
//
//  Created by PCQ229 on 09/06/22.
//

import UIKit

class DiscoverCell: UITableViewCell {
    @IBOutlet weak var movieImage: UIImageView!
    @IBOutlet weak var titlelabel: UILabel!
    @IBOutlet weak var ratingsView: CircleProgressView!
    @IBOutlet weak var dateLabel: UILabel!
    @IBOutlet weak var genreLabel: UILabel!
    
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
        movieImage.setImageUsingUrlSession(posterPath, placeholder: UIImage(systemName: "photo"))
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
