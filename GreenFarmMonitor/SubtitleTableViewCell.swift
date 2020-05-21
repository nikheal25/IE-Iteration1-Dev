//
//  SubtitleTableViewCell.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 21/5/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

class SubtitleTableViewCell: UITableViewCell {

    @IBOutlet weak var infoSubtileLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
    
    }
    
    func setSubtule(isHidden: Bool) {
        infoSubtileLabel.isHidden = isHidden
    }

//    override func setSelected(_ selected: Bool, animated: Bool) {
//        super.setSelected(selected, animated: animated)
//    }

}
