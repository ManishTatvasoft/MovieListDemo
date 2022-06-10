//
//  CastCell.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import UIKit

class CastCell: UICollectionViewCell {
    @IBOutlet private weak var castImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var charecterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupData(_ data: Cast?){
        nameLabel.text = data?.name
        charecterLabel.text = data?.character
        if let data = data {
            castImage.setImageUsingUrlSession(Environment.basePosterImageURL() + (data.profile_path ?? ""), placeholder: UIImage.universalImage("person.fill"))
        }else{
            castImage.image = UIImage.universalImage("person.fill")
        }
    }
}
