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
        
        
        self.contentView.backgroundColor = UIColor(hexString: "#E3E3E3")
//        self.layer.cornerRadius = 10
//        self.layer.shadowOpacity = 5
//        self.layer.shadowRadius = 10
//        imageTitle.layer.cornerRadius = 10
//        cropTitleLable.textColor = .black
//
//              //// MARK:- color behind cell
////                self.contentView.backgroundColor = UIColor(hexString: "#B5D4BE")
//                self.layer.cornerRadius = 20
//                self.layer.shadowOpacity = 4
//                self.layer.shadowRadius = 2
        //        self.cellView.layer.masksToBounds = true
        //        self.cellView.layer.shadowColor = UIColor(named: "Orange")?.cgColor
        //         self.cropImageView.layer.shadowOffset = CGSize(width: 3, height: 3)
        
        self.imageTitle.image = UIImage(named: crop.cropImage)
        
         self.contentView.backgroundColor = UIColor(hexString: "#B5D4BE")
                self.cellView.layer.cornerRadius = 8
                self.cellView.layer.shadowOpacity = 0.4
                self.cellView.layer.shadowRadius = 2
        //        self.cellView.layer.masksToBounds = true
        //        self.cellView.layer.shadowColor = UIColor(named: "Orange")?.cgColor
        //         self.cropImageView.layer.shadowOffset = CGSize(width: 3, height: 3)
                self.imageTitle.layer.cornerRadius = 6
        
        //TODO
//        self.cropTitleLable.layer.cornerRadius = 10
        }
}
