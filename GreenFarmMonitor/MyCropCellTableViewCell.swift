//
//  MyCropCellTableViewCell.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 13/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

class MyCropCellTableViewCell: UITableViewCell {

    @IBOutlet weak var cropImageView: UIImageView!
    @IBOutlet weak var cropTitleLable: UILabel!
    @IBOutlet weak var cellView: UIView!
    
    func setCell(crop: Crop) {
//        cropImageView = image
        cropTitleLable.text = crop.cropName
//        cellView.backgroundColor = UIColor(hexString: "#4ECDC4")
        self.contentView.backgroundColor = UIColor(hexString: "#f4eeff")
        self.cellView.layer.cornerRadius = 8
        self.cellView.layer.shadowOpacity = 0.4
        self.cellView.layer.shadowRadius = 2
//        self.cellView.layer.masksToBounds = true
//        self.cellView.layer.shadowColor = UIColor(named: "Orange")?.cgColor
//         self.cropImageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        self.cropImageView.layer.cornerRadius = 6
    }
}
