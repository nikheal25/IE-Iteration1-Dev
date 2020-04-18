//
//  MyCropMainTableViewCell.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 13/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

class MyCropMainTableViewCell: UITableViewCell {

    @IBOutlet weak var cropTitleLable: UILabel!
    @IBOutlet weak var imageTitle: UIImageView!
    
    func setCell(crop: Crop) {
    //        cropImageView = image
            cropTitleLable.text = crop.cropName
        
        self.contentView.backgroundColor = UIColor(hexString: "#020122")
        self.layer.cornerRadius = 10
        self.layer.shadowOpacity = 5
        self.layer.shadowRadius = 10
        self.imageTitle.image = UIImage(named: crop.cropImage)
        
        //TODO
//        self.cropTitleLable.layer.cornerRadius = 10
        }
}
