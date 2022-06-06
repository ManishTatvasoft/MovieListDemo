//
//  UpcommingMovieListCell.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//

import UIKit

class UpcommingMovieListCell: UICollectionViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    @IBOutlet weak var coverImage: UIImageView!
    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupData(with data: Results){
        let posterPath = Environment.basePosterImageURL() + (data.poster_path ?? "")
        let coverPath = Environment.baseCoverImageURL() + (data.backdrop_path ?? "")
        posterImage.setImageUsingUrlSession(posterPath, placeholder: UIImage(systemName: "photo"))
        coverImage.setImageUsingUrlSession(coverPath, placeholder: UIImage(systemName: "photo"))
        titleLabel.text = data.title
        dateLabel.text = data.release_date
    }
}
