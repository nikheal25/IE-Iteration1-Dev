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
    @IBOutlet weak var cellView: UIView!
    
    func setCell(crop: Crop) {
            cropTitleLable.text = crop.cropName
        
        
 
        self.imageTitle.image = UIImage(named: crop.cropImage)
        
         self.contentView.backgroundColor = UIColor(hexString: "#3A4F41")
                self.cellView.layer.cornerRadius = 8
                self.cellView.layer.shadowOpacity = 0.4
                self.cellView.layer.shadowRadius = 2

                self.imageTitle.layer.cornerRadius = 6
        
        //TODO
//        self.cropTitleLable.layer.cornerRadius = 10
        }
}
