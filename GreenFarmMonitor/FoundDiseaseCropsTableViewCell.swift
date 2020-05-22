//
//  FoundDiseaseCropsTableViewCell.swift
//  GreenFarmMonitor
//
//  Created by Hanlin Shen on 22/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

class FoundDiseaseCropsTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
       
    }
    @IBOutlet weak var cellView: UIView!
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
      self.contentView.backgroundColor = UIColor(hexString: "#3A4F41")
       self.cropNameLabel.adjustsFontSizeToFitWidth = true
        self.cellView.layer.cornerRadius = 8
        self.cellView.layer.shadowOpacity = 0.4
        self.cellView.layer.shadowRadius = 2
         self.cropImage.layer.cornerRadius = 6
       
    }

    @IBOutlet weak var cropImage: UIImageView!
    
    @IBOutlet weak var cropNameLabel: UILabel!
}
