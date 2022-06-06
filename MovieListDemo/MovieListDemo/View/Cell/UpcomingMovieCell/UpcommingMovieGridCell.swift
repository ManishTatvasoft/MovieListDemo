//
//  UpcommingMovieGridCell.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//

import UIKit

class UpcommingMovieGridCell: UICollectionViewCell {

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
