//
//  UpcommingMovieGridCell.swift
//  MovieListDemo
//
//  Created by PCQ229 on 06/06/22.
//

import UIKit

class UpcommingMovieGridCell: UICollectionViewCell {

    @IBOutlet private weak var posterImage: UIImageView!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    func setupData(_ url: String?){
        
        let posterPath = Environment.basePosterImageURL() + (url ?? "")
        if #available(iOS 13.0, *) {
            posterImage.setImageUsingUrlSession(posterPath, placeholder: UIImage(systemName: "photo"))
        } else {
            posterImage.setImageUsingUrlSession(posterPath, placeholder: UIImage(named: "photo"))
        }
    }
}
