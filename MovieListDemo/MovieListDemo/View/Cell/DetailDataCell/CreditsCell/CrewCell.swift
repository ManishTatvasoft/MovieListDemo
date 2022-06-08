//
//  CrewCell.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import UIKit

class CrewCell: UICollectionViewCell {

    @IBOutlet weak var crewPersonImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupData(_ data: Crew?){
        nameLabel.text = data?.name
        if let data = data {
            crewPersonImage.setImageUsingUrlSession(Environment.basePosterImageURL() + (data.profile_path ?? ""), placeholder: UIImage(systemName: "person.fill"))
        }else{
            crewPersonImage.image = UIImage(systemName: "person.fill")
        }
    }

}
