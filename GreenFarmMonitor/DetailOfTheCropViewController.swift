//
//  DetailOfTheCropViewController.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 16/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

class DetailOfTheCropViewController: UIViewController {
    
    @IBOutlet weak var mainView: UIView!
    @IBOutlet weak var imageView: UIView!
    @IBOutlet weak var infoView: UIView!
    @IBOutlet weak var infoViewONE: UIView!
    @IBOutlet weak var infoViewTWO: UIView!
    
    
    @IBOutlet weak var temperatureBarView: UIView!
    @IBOutlet weak var cropNameLabel: UILabel!
    
    @IBOutlet weak var tempLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = UIColor(hexString: "#24343F")
        
        self.imageView.layer.cornerRadius = 8
        self.imageView.layer.shadowOpacity = 0.4
        self.imageView.layer.shadowRadius = 1
        
        setInfoView()
        
        let shapeLayer = CAShapeLayer()
       
        let center = tempLabel.center
        
        let circularPath = UIBezierPath(arcCenter: center, radius: 40, startAngle: -CGFloat.pi / 2, endAngle: 2 * CGFloat.pi, clockwise: true)
        
        shapeLayer.path = circularPath.cgPath
        shapeLayer.strokeColor = UIColor.red.cgColor
        shapeLayer.fillColor = UIColor.white.cgColor
        shapeLayer.lineWidth = 6
        
        shapeLayer.lineCap = CAShapeLayerLineCap.round
        
        shapeLayer.strokeEnd = 0
        
        temperatureBarView.layer.addSublayer(shapeLayer)
        
        let basicAnimation = CABasicAnimation(keyPath: "strokeEnd")
        basicAnimation.toValue = 1
        basicAnimation.duration = 3
        basicAnimation.fillMode = CAMediaTimingFillMode.forwards
        basicAnimation.isRemovedOnCompletion = false
        
        shapeLayer.add(basicAnimation, forKey: "urSoBasic")
        
    }
    
    func getPointForView(_ view : UIView) -> (x:CGFloat,y:CGFloat)
    {
        let x = view.frame.origin.x
        let y = view.frame.origin.y
        return (x,y)
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
    
}
