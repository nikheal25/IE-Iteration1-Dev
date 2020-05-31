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
    @IBOutlet weak var bottomMostLabel: UILabel!
    
    @IBOutlet weak var barView: UIView!
    //    @IBOutlet weak var compatibleButton: UIButton!
    @IBOutlet weak var newButton: UIButton!
    
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
        self.contentView.isUserInteractionEnabled = true
        super.awakeFromNib()
    }
    
    func setUp(crop: Crop, companionCrop: Crop) {
        
        //
        cropLabel.font = FontHandler.getRegularFont()
        // Change the color of Top bar - START
        self.barView.backgroundColor = UIColor(hexString: "#243119")
        self.barView.superview?.backgroundColor = UIColor(hexString: "#243119")
        // END
        
        // Change the color of buttons - START
        self.addToButton.backgroundColor = UIColor(hexString: "#616163")
        self.newButton.backgroundColor = UIColor(hexString: "#616163")
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
        //based on your location apparagus grows best with
        
        self.specificCrop = crop
        self.companionCrop = companionCrop
        self.newButton.setTitle("Add \(companionCrop.cropName) with this plant", for: .normal)
        
        self.bottomMostLabel.text = "Based on your location \(specificCrop!.cropName) grows best with \(companionCrop.cropName)."
        if self.specificCrop?.cropName == companionCrop.cropName  {
            self.newButton.isHidden = true
            self.bottomMostLabel.isHidden = true
        }
        self.newButton.titleLabel?.minimumScaleFactor = 0.01
        self.newButton.titleLabel?.adjustsFontSizeToFitWidth = true
        self.newButton.layer.cornerRadius = 10
        self.compatibleCropLabel.text = "This crop grows best with \(crop.Compatible_plant), \(companionCrop.All_Compatible_plants)"
        self.compatibleCropLabel.adjustsFontSizeToFitWidth = true
        self.compatibleCropLabel.minimumScaleFactor = 0.5
        
        //MARK:-DELETE THIS
        newButton.addTarget(self, action: #selector(buttonAction), for: .touchUpInside)
    }
    
    @IBAction func compatibleButton(_ sender: Any) {
        databaseController?.updateMyCropList(new: true, userId: (userDefaultController?.retrieveUserId())!, cropId: specificCrop!.cropId)
        databaseController?.updateMyCropList(new: true, userId: (userDefaultController?.retrieveUserId())!, cropId: companionCrop!.cropId)
        selectionDelegate.didAddCrop()
        print("working \(companionCrop?.cropName)")
    }
    @IBAction func clickAddCropButton(_ sender: Any) {
        databaseController?.updateMyCropList(new: true, userId: (userDefaultController?.retrieveUserId())!, cropId: specificCrop!.cropId)
        selectionDelegate.didAddCrop()
        //self.navigationController?.popToRootViewController(animated: true)
    }
    //
    //    @IBAction func compatibleButtonPressed(_ sender: Any) {
    //        databaseController?.updateMyCropList(new: true, userId: (userDefaultController?.retrieveUserId())!, cropId: specificCrop!.cropId)
    //        databaseController?.updateMyCropList(new: true, userId: (userDefaultController?.retrieveUserId())!, cropId: companionCrop!.cropId)
    //        selectionDelegate.didAddCrop()
    //    }
    //
    
    @objc func buttonAction(sender: UIButton!) {
        print("Button tapped \(companionCrop?.cropName)")
    }
    
    override func animationDuration(_ itemIndex: NSInteger, type _: FoldingCell.AnimationType) -> TimeInterval {
        let durations = [0.26, 0.2, 0.2]
        return durations[itemIndex]
    }
}
