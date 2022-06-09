//
//  MovieCell.swift
//  MovieListDemo
//
//  Created by PCQ229 on 09/06/22.
//

import UIKit

class MovieCell: UICollectionViewCell {

    @IBOutlet weak var posterImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupData(_ url: String?){
        let posterPath = Environment.basePosterImageURL() + (url ?? "")
        posterImage.setImageUsingUrlSession(posterPath, placeholder: UIImage(systemName: "photo"))
    }

}
