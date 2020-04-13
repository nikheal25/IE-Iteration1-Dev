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
    
    func setCell(crop: Crop) {
//        cropImageView = image
        cropTitleLable.text = crop.cropName
    }
}
