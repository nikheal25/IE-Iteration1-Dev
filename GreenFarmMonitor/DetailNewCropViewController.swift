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
    weak var userDefaultController: UserdefaultsProtocol?
    weak var databaseController: DatabaseProtocol?
    
    @IBOutlet weak var cropImage: UIImageView!
    @IBOutlet weak var detailLabel: UILabel!
    
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.title = specificCrop?.cropName
        cropImage.image = UIImage(named: specificCrop!.cropImage)
        self.detailLabel.text = specificCrop?.Description
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        userDefaultController = appDelegate.userDefaultController
        databaseController = appDelegate.databaseController
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
    
    @IBAction func addCropToListButton(_ sender: Any) {
        databaseController?.updateMyCropList(new: true, userId: (userDefaultController?.retrieveUserId())!, cropId: specificCrop!.cropId)
        _ = navigationController?.popToRootViewController(animated: true)
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
