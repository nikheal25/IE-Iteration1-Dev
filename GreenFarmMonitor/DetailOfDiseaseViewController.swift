//
//  DetailOfDiseaseViewController.swift
//  GreenFarmMonitor
//
//  Created by Hanlin Shen on 13/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

class DetailOfDiseaseViewController: UIViewController {
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.imageView.layer.cornerRadius = 15
        self.imageView.layer.shadowOpacity = 0.4
        self.imageView.layer.shadowRadius = 1
        self.infoView.layer.cornerRadius = 15
        self.infoView.layer.shadowOpacity = 0.4
        self.infoView.layer.shadowRadius = 1
        
        
        self.mainView.backgroundColor = UIColor(hexString: "#3F6845")
        content()
        DescriptionLabel.backgroundColor = UIColor.white
        DescriptionLabel.layer.cornerRadius = 8
        NameLabel.layer.cornerRadius = 8
        navigationItem.title = name
        // Do any additional setup after loading the view.
    }
    var name:String = ""
    var image:String = ""
    var detail: String = ""
    @IBOutlet weak var DiseaseImage: UIImageView!
    
    @IBOutlet weak var NameLabel: UILabel!
    
    @IBOutlet weak var DescriptionLabel: UILabel!
    
    @IBOutlet weak var mainView: UIView!
    
    @IBOutlet weak var imageView: UIView!
    
    @IBOutlet weak var infoView: UIView!
    func content()
    {
        if name.isEmpty == false && image.isEmpty == false
        {
            let Image = UIImage(named: image)
            if Image == nil
            {
                DiseaseImage.image = UIImage(named: "not-found")
            }else{
                DiseaseImage.image = Image}
            
            DescriptionLabel.text = detail
            DescriptionLabel.sizeToFit()
            
            
        }
        
    }
    
    
}
