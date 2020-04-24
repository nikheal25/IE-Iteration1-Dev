//
//  DemoTableViewCell.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 19/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import FoldingCell
import UIKit

class DemoTableViewCell: FoldingCell {

    @IBOutlet weak var cropImage: UIImageView!
    @IBOutlet weak var cropLabel: UILabel!
    var number: Int = 0 {
        didSet {
   
        }
    }

    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
    }
    
    func setUp(crop: Crop) {
        self.cropLabel.text = crop.cropName
        self.cropImage.image = UIImage(named: crop.cropImage)
        
        self.contentView.backgroundColor = UIColor(hexString: "#3A4F41")
//        self.layer.cornerRadius = 8
//        self.layer.shadowOpacity = 0.4
//        self.layer.shadowRadius = 2

        self.cropImage.layer.cornerRadius = 6
    }

    override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
}
