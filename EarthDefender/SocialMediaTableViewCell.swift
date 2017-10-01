//
//  SocialMediaTableViewCell.swift
//  EarthDefender
//
//  Created by Dean on 2017-09-30.
//  Copyright © 2017 Sam. All rights reserved.
//

import UIKit

class SocialMediaTableViewCell: UITableViewCell {
    @IBOutlet weak var InformationLabel: UILabel!

    @IBOutlet weak var LeftImageView: UIImageView!
    @IBOutlet weak var CentreImageView: UIImageView!
    @IBOutlet weak var RightImageView: UIImageView!
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
