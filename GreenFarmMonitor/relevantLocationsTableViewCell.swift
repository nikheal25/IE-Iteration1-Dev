//
//  relevantLocationsTableViewCell.swift
//  GreenFarmMonitor
//
//  Created by Hanlin Shen on 19/5/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

class relevantLocationsTableViewCell: UITableViewCell {
    ///Label for search relevant location cell
    @IBOutlet weak var searchResult: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
}
