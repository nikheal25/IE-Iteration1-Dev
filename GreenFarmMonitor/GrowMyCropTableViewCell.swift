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
    @IBOutlet weak var cropImageView: UIImageView!
    @IBOutlet weak var arrowImage: UIImageView!
    
    func setCell(crop: Crop) {
        self.crop = crop
        //        cropImageView = image
        cropTitleLable.text = crop.cropName
        self.cropTitleLable.adjustsFontSizeToFitWidth = true
        self.cropTitleLable.minimumScaleFactor = 0.5
        
        cropImageView.image = UIImage(named: crop.cropImage)
        
        //        self.growCropButton.layer.cornerRadius = 3
        //        self.growCropButton.layer.borderWidth = 1
        //        self.growCropButton.layer.borderColor = UIColor.black.cgColor
        
        self.contentView.backgroundColor = UIColor(hexString: "#3A4F41")
        self.cellView.layer.cornerRadius = 8
        self.cellView.layer.shadowOpacity = 0.4
        self.cellView.layer.shadowRadius = 2
        
        self.cropImageView.layer.cornerRadius = 6
        
        
        //MARK:- make image clickable
        let tapGesture = UITapGestureRecognizer(target: self, action: #selector(GrowMyCropTableViewCell.imageTapped(gesture:)))
        
        // add it to the image view;
        arrowImage.addGestureRecognizer(tapGesture)
        // make sure imageView can be interacted with by user
        arrowImage.isUserInteractionEnabled = true
        
    }
    
    @objc func imageTapped(gesture: UIGestureRecognizer) {
        // if the tapped view is a UIImageView then set it to imageview
        if(self.delegate != nil){ //Just to be safe.
            self.delegate.callSegueFromCell(crop: self.crop)
        }
    }
    
    override func setSelected(_ selected: Bool, animated: Bool) {
        
    }
    
}
