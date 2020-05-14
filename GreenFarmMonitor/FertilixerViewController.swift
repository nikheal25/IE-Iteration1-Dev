//
//  FertilixerViewController.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 14/5/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

class FertilixerViewController: UIViewController {

    var specificCrop: Crop?
    
    @IBOutlet weak var cropImageView: UIImageView!
    @IBOutlet weak var fertiliserLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.cropImageView.image = UIImage(named: specificCrop!.cropImage)
        self.fertiliserLabel.text = specificCrop?.Fertilizer_recommendation
    }
    

}
