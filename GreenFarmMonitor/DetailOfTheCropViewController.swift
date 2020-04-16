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
    override func viewDidLoad() {
        super.viewDidLoad()
        
        fillLabels()
        
        mainView.backgroundColor = UIColor(hexString: "#24343F")
        
        self.imageView.layer.cornerRadius = 8
        self.imageView.layer.shadowOpacity = 0.4
        self.imageView.layer.shadowRadius = 1
        
        setInfoView()
        
        animationCircle(center: tempLabel.center, endAngle: 2 * CGFloat.pi, fillColor: UIColor.white.cgColor, strokeColor: UIColor.red.cgColor, theView: temperatureBarView)
        
        animationCircle(center: tempLabel.center, endAngle:  CGFloat.pi, fillColor: UIColor.white.cgColor, strokeColor: UIColor.red.cgColor, theView: phBarView)
    }
    
    func fillLabels() {
        cropNameLabel.text = specificCrop?.cropName
        scintificNameLabel.text = ""
        descriptionLanel.text = "Following conditions are the ideal for the growth of the crop"
        minMoisstureRange.text = ""
    }
    
    func getPointForView(_ view : UIView) -> (x:CGFloat,y:CGFloat)
    {
        let x = view.frame.origin.x
        let y = view.frame.origin.y
        return (x,y)
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
    
    
    func setInfoView()  {
        self.infoView.layer.cornerRadius = 8
        self.infoView.layer.shadowOpacity = 0.4
        self.infoView.layer.shadowRadius = 1
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
        
    }
    
}
