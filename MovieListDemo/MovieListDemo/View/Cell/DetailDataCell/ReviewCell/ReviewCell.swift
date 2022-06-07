//
//  ReviewCell.swift
//  MovieListDemo
//
//  Created by PCQ229 on 07/06/22.
//

import UIKit

class ReviewCell: UITableViewCell {

    @IBOutlet weak var profileImage: UIImageView!
    @IBOutlet weak var nameLabel: UILabel!
    @IBOutlet weak var reviewLabel: UILabel!
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
                    var str = authorDetails.avatar_path
                    str = str?.dropFirst()
                    profileImage.setImageUsingUrlSession(str, placeholder: UIImage(systemName: "person.circle"))
                }else{
                    profileImage.setImageUsingUrlSession(Environment.basePosterImageURL() + (authorDetails.avatar_path ?? ""), placeholder: UIImage(systemName: "person.circle"))
                }
            }else{
                profileImage.setImageUsingUrlSession(Environment.basePosterImageURL() + (authorDetails.avatar_path ?? ""), placeholder: UIImage(systemName: "person.circle"))
            }
        }else{
            profileImage.setImageUsingUrlSession(Environment.basePosterImageURL() + (data.author_details?.avatar_path ?? ""), placeholder: UIImage(systemName: "person.circle"))
        }
        
        nameLabel.text = data.author
        reviewLabel.text = data.content
    }
}
