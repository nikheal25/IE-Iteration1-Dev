//
//  DetailNewCropViewController.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 13/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

class DetailNewCropViewController: UIViewController {

    var specificCrop: Crop?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    

    @IBAction func addCropButtonPressed(_ sender: Any) {
        showMessage(tittle: "Invalid fields", message: "Please complete all the fields")
    }
    
    //This method shows a pop up informing changes in the information
    func showMessage(tittle: String, message: String) {
        let alert = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alert.addAction(UIAlertAction(title: "OK", style: UIAlertAction.Style.default, handler: { (action: UIAlertAction!) in
        print("Handle Add Logic here")
        }))
        alert.addAction(UIAlertAction(title: "Cancel", style: .cancel, handler: { (action: UIAlertAction!) in
        print("Handle Cancel Logic here")
        }))
        self.present(alert, animated: true, completion: nil)
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
