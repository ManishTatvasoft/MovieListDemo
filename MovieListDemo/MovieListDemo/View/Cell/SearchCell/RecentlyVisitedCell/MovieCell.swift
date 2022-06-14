//
//  MovieCell.swift
//  MovieListDemo
//
//  Created by PCQ229 on 09/06/22.
//

import UIKit

class MovieCell: UICollectionViewCell {

    @IBOutlet private weak var posterImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupData(_ url: String?){
        let posterPath = Environment.basePosterImageURL() + (url ?? "")
        if #available(iOS 13.0, *) {
            posterImage.setImageUsingUrl(posterPath, placeholder: UIImage(systemName: "photo"))
        } else {
            posterImage.setImageUsingUrl(posterPath, placeholder: UIImage(named: "photo"))
        }
    }

}
