//
//  VideoCell.swift
//  MovieListDemo
//
//  Created by PCQ229 on 08/06/22.
//

import UIKit

class VideoCell: UITableViewCell {
    
    @IBOutlet weak var videoThumbImage: UIImageView!
    @IBOutlet weak var videoTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(_ data: VideoResults){
        let strUrl = AppConstants.videoUrl(data.key ?? "")
        videoTitleLabel.text = data.name
        videoThumbImage.setImageUsingUrlSession(AppConstants.videoUrl((data.key ?? "")), placeholder: UIImage(systemName: "photo"))
        
    }
    
}
