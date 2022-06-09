//
//  CastCell.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import UIKit

class CastCell: UICollectionViewCell {
    @IBOutlet weak var castImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var charecterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupData(_ data: Cast?){
        nameLabel.text = data?.name
        charecterLabel.text = data?.character
        if let data = data {
            castImage.setImageUsingUrlSession(Environment.basePosterImageURL() + (data.profile_path ?? ""), placeholder: UIImage(systemName: "person.fill"))
        }else{
            castImage.image = UIImage(systemName: "person.fill")
        }
    }
}
