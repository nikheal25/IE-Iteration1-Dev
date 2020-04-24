//
//  DiseaseTableViewCell.swift
//  GreenFarmMonitor
//
//  Created by Hanlin Shen on 13/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

class DiseaseTableViewCell: UITableViewCell {

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        self.contentView.backgroundColor = UIColor(hexString: "#3A4F41")
        
            self.cellView.layer.cornerRadius = 8
            self.cellView.layer.shadowOpacity = 0.4
            self.cellView.layer.shadowRadius = 2
             self.diseaseImage.layer.cornerRadius = 6
        // Configure the view for the selected state
    }
   
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var diseaseImage: UIImageView!
    

    @IBOutlet weak var diseaseNameLabel: UILabel!
    
}
