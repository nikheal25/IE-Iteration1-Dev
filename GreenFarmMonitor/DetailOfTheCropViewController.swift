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
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mainView.backgroundColor = UIColor(hexString: "#24343F")
        
        self.imageView.layer.cornerRadius = 8
        self.imageView.layer.shadowOpacity = 0.4
        self.imageView.layer.shadowRadius = 1
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
