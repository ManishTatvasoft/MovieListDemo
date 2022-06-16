//
//  CastCell.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import UIKit
import CoreMedia

class CastAndCrewCell: UICollectionViewCell {
    @IBOutlet private weak var castImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var charecterLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    func setupData(_ data: CastCrewManager?, index: Int, isCast: Bool) {
        
        if isCast {
            let cast = data?.cast.castData[index]
            nameLabel.text = cast?.name
            charecterLabel.text = cast?.character
            if let cast = cast {
                castImage.setImageUsingUrl(Environment.basePosterImageURL() + (cast.profile_path ?? ""), placeholder: UIImage.universalImage("person.fill"))
            }else{
                castImage.image = UIImage.universalImage("person.fill")
            }
        } else {
            let crew = data?.crew.crewData[index]
            nameLabel.text = crew?.name
            charecterLabel.text = ""
            if let crew = crew {
                castImage.setImageUsingUrl(Environment.basePosterImageURL() + (crew.profile_path ?? ""), placeholder: UIImage.universalImage("person.fill"))
            } else {
                castImage.image = UIImage.universalImage("person.fill")
            }
        }
        
    }
}
