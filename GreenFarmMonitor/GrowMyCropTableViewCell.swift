//
//  GrowMyCropTableViewCell.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 22/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

class GrowMyCropTableViewCell: UITableViewCell {

//    override func awakeFromNib() {
//        super.awakeFromNib()
//        // Initialization code
//    }
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cropTitleLable: UILabel!
    func setCell(crop: Crop) {
    //        cropImageView = image
            cropTitleLable.text = crop.cropName
                //// MARK:- color behind cell
            self.contentView.backgroundColor = UIColor(hexString: "#B5D4BE")
            self.cellView.layer.cornerRadius = 5
            self.cellView.layer.shadowOpacity = 0.4
            self.cellView.layer.shadowRadius = 2
    //        self.cellView.layer.masksToBounds = true
    //        self.cellView.layer.shadowColor = UIColor(named: "Orange")?.cgColor
    //         self.cropImageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
