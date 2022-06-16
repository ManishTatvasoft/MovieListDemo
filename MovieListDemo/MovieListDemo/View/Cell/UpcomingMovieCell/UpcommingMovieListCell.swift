//
//  UpcommingMovieListCell.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//

import UIKit

class UpcommingMovieListCell: UICollectionViewCell {

    @IBOutlet private weak var posterImage: UIImageView!
    @IBOutlet private weak var coverImage: UIImageView!
    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var dateLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupData(with data: Results) {
        let posterPath = Environment.basePosterImageURL() + (data.poster_path ?? "")
        let coverPath = Environment.baseCoverImageURL() + (data.backdrop_path ?? "")
        if #available(iOS 13.0, *) {
            coverImage.setImageUsingUrl(coverPath, placeholder: UIImage(systemName: "photo"))
            posterImage.setImageUsingUrl(posterPath, placeholder: UIImage(systemName: "photo"))
        } else {
            coverImage.setImageUsingUrl(coverPath, placeholder: UIImage(named: "photo"))
            posterImage.setImageUsingUrl(posterPath, placeholder: UIImage(named: "photo"))
        }
        titleLabel.text = data.title
        dateLabel.text = data.release_date
    }
}
