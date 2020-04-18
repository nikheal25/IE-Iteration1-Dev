//
//  DetailOfTheCropViewController.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 16/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

class DetailOfTheCropViewController: UIViewController {
    
    var specificCrop: Crop?
    weak var databaseController: DatabaseProtocol?
    @IBOutlet weak var addNewButton: UIButton!
    weak var userDefaultController: UserdefaultsProtocol?
    var newCrop: Bool?
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoViewONE: UIView!
    @IBOutlet weak var infoViewTWO: UIView!
    
    
    @IBOutlet weak var temperatureBarView: UIView!
    @IBOutlet weak var cropNameLabel: UILabel!
    @IBOutlet weak var phBarView: UIView!
    @IBOutlet weak var descriptionLanel: UILabel!
    
    @IBOutlet weak var scintificNameLabel: UILabel!
    @IBOutlet weak var pHlabel: UILabel!
    @IBOutlet weak var tempLabel: UILabel!
    @IBOutlet weak var minMoisstureRange: UILabel!
    @IBOutlet weak var maxMoistureRange: UILabel!
    @IBOutlet weak var temperatureVal: UILabel!
    @IBOutlet weak var phVal: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillLabels()
        
        mainView.backgroundColor = UIColor(hexString: "#020122") //UIColor(hexString: "#358600")
        
        
        setImageView()
        setInfoView()
        
        animationCircle(center: tempLabel.center, endAngle: calculateTheAngleTemp(num: specificCrop!.optimmumSoilTemp), fillColor: UIColor.white.cgColor, strokeColor: UIColor.red.cgColor, theView: temperatureBarView)
        
        animationCircle(center: tempLabel.center, endAngle:  calculateTheAnglePH(num: (specificCrop!.maxSoilpH)), fillColor: UIColor.white.cgColor, strokeColor: UIColor.red.cgColor, theView: phBarView)
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        userDefaultController = appDelegate.userDefaultController
        databaseController = appDelegate.databaseController
        
        if let new = newCrop {
            if new == true {
                addNewButton.isHidden = false
            } else {
                addNewButton.isHidden = true
            }
        }
    }
    
    func fillLabels() {
        cropNameLabel.text = specificCrop?.cropName
        cropNameLabel.textColor = UIColor(hexString: "D63AF9")
        scintificNameLabel.text = ""
        descriptionLanel.text = "Following conditions are the ideal for the growth of the crop"
        minMoisstureRange.text = ""
        temperatureVal.text = specificCrop?.optimmumSoilTemp
        let str1 = (specificCrop?.minSoilpH)!
        let str2 = (specificCrop?.maxSoilpH)!
        phVal.text = "\(str1) - \(str2)"
    }
    
    func getPointForView(_ view : UIView) -> (x:CGFloat,y:CGFloat)
    {
        let x = view.frame.origin.x
        let y = view.frame.origin.y
        return (x,y)
    }
    
    func calculateTheAngleTemp(num: String) -> CGFloat {
        let val = (num as NSString).floatValue
       
        
        let perc = ((val/50))
        let a = CGFloat(perc) / CGFloat.pi
        return a + CGFloat.pi
    }
    
    func calculateTheAnglePH(num: String) -> CGFloat {
        let val = (num as NSString).floatValue
    
        let perc = ((val/10))
        let a = CGFloat(perc) / CGFloat.pi * 2
        return a + CGFloat.pi
    }
    
    func animationCircle(center: CGPoint, endAngle: CGFloat, fillColor: CGColor, strokeColor: CGColor, theView: UIView)  {
        let shapeLayer = CAShapeLayer()
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 40, startAngle: -CGFloat.pi / 2, endAngle: endAngle, clockwise: true)
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = strokeColor//
        shapeLayer.fillColor = fillColor//
        shapeLayer.lineWidth = 6
        
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        
        shapeLayer.strokeEnd = 0
        
        theView.layer.addSublayer(shapeLayer)
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 2
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
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
    
    /*
     // MARK: - Navigation
     
     // In a storyboard-based application, you will often want to do a little preparation before navigation
     override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     // Get the new view controller using segue.destination.
     // Pass the selected object to the new view controller.
     }
     */
    @IBAction func confirmButtonPushed(_ sender: Any) {
        if let new = newCrop {
            if new == true {
                databaseController?.updateMyCropList(new: new, userId: (userDefaultController?.retrieveUserId())!, cropId: specificCrop!.cropId)
                _ = navigationController?.popToRootViewController(animated: true)
            } else {
               
            }
        }
    }
    
}
