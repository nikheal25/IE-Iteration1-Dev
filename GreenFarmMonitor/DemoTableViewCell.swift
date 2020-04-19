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

    var number: Int = 0 {
        didSet {
   
        }
    }

    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
    }

    override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
}
