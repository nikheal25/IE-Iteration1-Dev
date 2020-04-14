//
//  MyCropsTableViewCell.swift
//  GreenFarmMonitor
//
//  Created by Hanlin Shen on 13/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

class MyCropsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    @IBOutlet weak var CropsName: UILabel!
    
}
