//
//  VideoCell.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import UIKit

class VideoCell: UITableViewCell {
    
    @IBOutlet private weak var videoThumbImage: UIImageView!
    @IBOutlet private weak var videoTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(_ data: VideoResults){
        videoTitleLabel.text = data.name
        videoThumbImage.setImageUsingUrlSession(AppConstants.videoUrl((data.key ?? "")), placeholder: UIImage.universalImage("photo"))
    }
}
