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
    
    @IBOutlet var mainView: UIView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var cropImageView: UIImageView!
    @IBOutlet weak var fertiliserLabel: UILabel!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        fertiliserLabel.font = FontHandler.getRegularFont()
        setInfoView()
        mainView.backgroundColor = UIColor(hexString: "#3F6845")
        self.cropImageView.image = UIImage(named: specificCrop!.cropImage)
        self.fertiliserLabel.text = specificCrop?.Fertilizer_recommendation
    }
    
    func setInfoView()  {
        self.infoView.layer.cornerRadius = 15
        self.infoView.layer.shadowOpacity = 0.4
        self.infoView.layer.shadowRadius = 1
        self.infoView.backgroundColor = .white
        //        self.infoView.backgroundColor = UIColor(hexString: "#FCFCFC")
    }
}
