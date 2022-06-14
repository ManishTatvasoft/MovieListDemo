//
//  ReviewCell.swift
//  MovieListDemo
//
//  Created by PCQ229 on 07/06/22.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet private weak var profileImage: UIImageView!
    @IBOutlet private weak var nameLabel: UILabel!
    @IBOutlet private weak var reviewLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(_ data: ReviewResults){
        if let authorDetails = data.author_details{
            if let path = authorDetails.avatar_path{
                if path.contains("/https://www.gravatar.com/"){
                    let str = authorDetails.avatar_path?.dropFirst()
                    profileImage.setImageUsingUrl(String(str ?? ""), placeholder: UIImage.universalImage("person.circle"))
                }else{
                    profileImage.setImageUsingUrl(Environment.basePosterImageURL() + (authorDetails.avatar_path ?? ""), placeholder: UIImage.universalImage("person.circle"))
                }
            }else{
                profileImage.setImageUsingUrl(Environment.basePosterImageURL() + (authorDetails.avatar_path ?? ""), placeholder: UIImage.universalImage("person.circle"))
            }
        }else{
            profileImage.setImageUsingUrl(Environment.basePosterImageURL() + (data.author_details?.avatar_path ?? ""), placeholder: UIImage.universalImage("person.circle"))
        }
        nameLabel.text = data.author
        reviewLabel.text = data.content
    }
}
