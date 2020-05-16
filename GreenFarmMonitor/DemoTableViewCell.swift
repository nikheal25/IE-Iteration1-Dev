//
//  DemoTableViewCell.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 19/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import FoldingCell
import UIKit

protocol SelectionDelegate {
    func didAddCrop()
}

class DemoTableViewCell: FoldingCell {
    
    
    var selectionDelegate: SelectionDelegate!
    
    weak var userDefaultController: UserdefaultsProtocol?
    weak var databaseController: DatabaseProtocol?
    
    var specificCrop: Crop?
    var companionCrop: Crop?
    
    @IBOutlet weak var barView: UIView!
    @IBOutlet weak var compatibleButton: UIButton!
    
    @IBOutlet weak var cropImage: UIImageView!
    @IBOutlet weak var cropLabel: UILabel!
    @IBOutlet weak var fullCropImage: UIImageView!
    @IBOutlet weak var topBarLabel: UILabel!
    @IBOutlet weak var descriptionLabel: UILabel!
    @IBOutlet weak var addToButton: UIButton!
    @IBOutlet weak var compatibleCropLabel: UILabel!
    var number: Int = 0 {
        didSet {
            
        }
    }
    
    override func awakeFromNib() {
        foregroundView.layer.cornerRadius = 10
        foregroundView.layer.masksToBounds = true
        super.awakeFromNib()
    }
    
    func setUp(crop: Crop, companionCrop: Crop) {
        
        // Change the color of Top bar - START
        self.barView.backgroundColor = UIColor(hexString: "#243119")
        self.barView.superview?.backgroundColor = UIColor(hexString: "#243119")
        // END
        
        // Change the color of buttons - START
        self.addToButton.backgroundColor = UIColor(hexString: "#616163")
        self.compatibleButton.backgroundColor = UIColor(hexString: "#616163")
        // END
        
        
        self.cropLabel.adjustsFontSizeToFitWidth = true
        self.cropLabel.minimumScaleFactor = 0.5
        self.cropLabel.text = crop.cropName
        self.topBarLabel.text = crop.cropName
        self.descriptionLabel.adjustsFontSizeToFitWidth = true
        self.descriptionLabel.minimumScaleFactor = 0.5
        self.descriptionLabel.sizeToFit()
        self.descriptionLabel.text = crop.Description
        
       
        self.cropImage.image = UIImage(named: crop.cropImage)
        self.cropImage.layer.cornerRadius = 6
        self.fullCropImage.image = UIImage(named: crop.cropImage)
        
        self.contentView.backgroundColor = UIColor(hexString: "#3A4F41")

        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        userDefaultController = appDelegate.userDefaultController
        databaseController = appDelegate.databaseController
        
        self.specificCrop = crop
        self.companionCrop = companionCrop
        self.compatibleButton.setTitle("Add \(companionCrop.cropName) with this plant", for: .normal)

        if self.specificCrop?.cropName == companionCrop.cropName  {
            self.compatibleButton.isHidden = true
        }
        self.compatibleButton.titleLabel?.minimumScaleFactor = 0.01
        self.compatibleButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.compatibleCropLabel.text = "This crop grows best with \(companionCrop.All_Compatible_plants)"
        self.compatibleCropLabel.adjustsFontSizeToFitWidth = true
        self.compatibleCropLabel.minimumScaleFactor = 0.5
    }
    
    @IBAction func clickAddCropButton(_ sender: Any) {
        databaseController?.updateMyCropList(new: true, userId: (userDefaultController?.retrieveUserId())!, cropId: specificCrop!.cropId)
        selectionDelegate.didAddCrop()
        //self.navigationController?.popToRootViewController(animated: true)
    }
    
    @IBAction func compatibleButton(_ sender: Any) {
        databaseController?.updateMyCropList(new: true, userId: (userDefaultController?.retrieveUserId())!, cropId: specificCrop!.cropId)
        databaseController?.updateMyCropList(new: true, userId: (userDefaultController?.retrieveUserId())!, cropId: companionCrop!.cropId)
        selectionDelegate.didAddCrop()
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
}
