//
//  SimilarCell.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import UIKit
import Alamofire

class SimilarCell: UITableViewCell {

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
    
    func setupData(_ data: Results){
        let posterPath = Environment.basePosterImageURL() + (data.poster_path ?? "")
        movieImage.setImageUsingUrlSession(posterPath, placeholder: UIImage.universalImage("photo"))
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
