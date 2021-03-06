//
//  PopularAndTopRatedCell.swift
//  MovieListDemo
//
//  Created by PCQ229 on 09/06/22.
//

import UIKit

class PopularAndTopRatedCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var subTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(_ data: [String: Any]){
        titleLabel.text = data["Title"] as? String
        subTitleLabel.text = data["SubTitle"] as? String
    }
    
}
