//
//  CrewCell.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import UIKit

class CrewCell: UICollectionViewCell {

    @IBOutlet private weak var crewPersonImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupData(_ data: Crew?){
        nameLabel.text = data?.name
        if let data = data {
            crewPersonImage.setImageUsingUrlSession(Environment.basePosterImageURL() + (data.profile_path ?? ""), placeholder:UIImage.universalImage("person.fill"))
        }else{
            crewPersonImage.image = UIImage.universalImage("person.fill")
        }
    }
}
