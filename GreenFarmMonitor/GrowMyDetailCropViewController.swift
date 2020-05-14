//
//  GrowMyDetailCropViewController.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 22/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

class GrowMyDetailCropViewController: UIViewController {
    
    var specificCrop: Crop?
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var cropImage: UIImageView!
    
    @IBOutlet weak var plantTypeLabel: UILabel!
    @IBOutlet weak var daysToMatLabel: UILabel!
    @IBOutlet weak var spreadRangeLabel: UILabel!
    @IBOutlet weak var heightRangeLabel: UILabel!
    @IBOutlet weak var soilTypeLabel: UILabel!
    @IBOutlet weak var soilpHLabel: UILabel!
    @IBOutlet weak var moistureLabel: UILabel!
    @IBOutlet weak var nutriLabel: UILabel!
    @IBOutlet weak var waterReqLabel: UILabel!
    @IBOutlet weak var lightIntLabel: UILabel!
    @IBOutlet weak var frostLabel: UILabel!
    
    func setLabels() {
        self.title = specificCrop?.cropName
        self.cropImage.image = UIImage(named: specificCrop!.cropImage)
        self.plantTypeLabel.text = specificCrop?.Plant_Type
        self.plantTypeLabel.adjustsFontSizeToFitWidth = true
        self.plantTypeLabel.minimumScaleFactor = 0.5
        self.daysToMatLabel.text = specificCrop?.Days_to_maturity
        self.spreadRangeLabel.text = specificCrop?.Spread_Ranges
        self.heightRangeLabel.text = specificCrop?.Height_Ranges
        self.soilTypeLabel.text = specificCrop?.Soil_Type
        let str1 = (specificCrop?.minSoilpH)!
        let str2 = (specificCrop?.maxSoilpH)!
        self.soilpHLabel.numberOfLines = 0
        self.soilpHLabel.text = "\(str1) - \(str2)"
        self.moistureLabel.text = specificCrop?.AvMoisture_Percent
        self.nutriLabel.text = specificCrop?.N_P_K_Req
        //        self.waterReqLabel.numberOfLines = 0
        self.waterReqLabel.adjustsFontSizeToFitWidth = true
        self.waterReqLabel.minimumScaleFactor = 0.5
        self.waterReqLabel.text = specificCrop?.Water_Needs
        //        self.lightIntLabel.numberOfLines = 0 //.sizeToFit()
        self.lightIntLabel.adjustsFontSizeToFitWidth = true
        self.lightIntLabel.minimumScaleFactor = 0.5
        self.lightIntLabel.text = specificCrop?.Light_Needs
        self.frostLabel.text = specificCrop?.frostTol
    }
    
    func setImageView()  {
        self.imageView.layer.cornerRadius = 15
        self.imageView.layer.shadowOpacity = 0.4
        self.imageView.layer.shadowRadius = 1
    }
    
    func setInfoView()  {
        self.infoView.layer.cornerRadius = 15
        self.infoView.layer.shadowOpacity = 0.4
        self.infoView.layer.shadowRadius = 1
        //        self.infoView.backgroundColor = UIColor(hexString: "#FCFCFC")
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        setLabels()
        setImageView()
        setInfoView()
        
        mainView.backgroundColor = UIColor(hexString: "#3F6845")
        // Do any additional setup after loading the view.
    }
    
    
    
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    var selectCrop:String = ""
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
            if segue.identifier == "diseaseSegue"
            {
                let destination = segue.destination as!DiseaseListViewController
                
                selectCrop = specificCrop!.cropName
                destination.crop = selectCrop
                }
        if segue.identifier == "fertiliserSegue"
        {
            let destination = segue.destination as! FertilixerViewController
            
            destination.specificCrop = specificCrop
            }
        }
    
    
}
