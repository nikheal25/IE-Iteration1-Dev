//
//  GrowMyCropTableViewCell.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 22/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

protocol GrowCropDelegate {
    func callSegueFromCell(crop: Crop)
}

class GrowMyCropTableViewCell: UITableViewCell {
    
    var delegate:GrowCropDelegate!
    
    var crop: Crop!
    
    @IBOutlet weak var cellView: UIView!
    @IBOutlet weak var cropTitleLable: UILabel!
    @IBOutlet weak var growCropButton: UIButton!
    func setCell(crop: Crop) {
        self.crop = crop
        //        cropImageView = image
        cropTitleLable.text = crop.cropName
        //// MARK:- color behind cell
        self.contentView.backgroundColor = UIColor(hexString: "#FAEDCA")
        self.cellView.layer.cornerRadius = 5
        self.cellView.layer.shadowOpacity = 0.4
        self.cellView.layer.shadowRadius = 2
        
        self.growCropButton.layer.cornerRadius = 3
        self.growCropButton.layer.borderWidth = 1
        self.growCropButton.layer.borderColor = UIColor.black.cgColor
        
        //        self.cellView.layer.masksToBounds = true
        //        self.cellView.layer.shadowColor = UIColor(named: "Orange")?.cgColor
        //         self.cropImageView.layer.shadowOffset = CGSize(width: 3, height: 3)
    }
    
    @IBAction func growCropButtonClicked(_ sender: Any) {
        if(self.delegate != nil){ //Just to be safe.
                   self.delegate.callSegueFromCell(crop: self.crop)
               }
    }
    override func setSelected(_ selected: Bool, animated: Bool) {
       
    }
    
}
