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
    
    
    
    func content()
    {
        if name.isEmpty == false && image.isEmpty == false
        {
            NameLabel.text = name
            DiseaseImage.image = UIImage(named: image)
            DescriptionLabel.text = detail
            DescriptionLabel.sizeToFit()
          
           
        }
        
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
