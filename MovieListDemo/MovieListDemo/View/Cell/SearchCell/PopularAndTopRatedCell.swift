//
//  PopularAndTopRatedCell.swift
//  MovieListDemo
//
//  Created by PCQ229 on 09/06/22.
//

import UIKit

class PopularAndTopRatedCell: UITableViewCell {

    @IBOutlet private weak var titleLabel: UILabel!
    @IBOutlet private weak var subTitleLabel: UILabel!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func setupData(_ data: TopRatedAndPopular) {
        titleLabel.text = data.title
        subTitleLabel.text = data.subTitle
    }
    
}
