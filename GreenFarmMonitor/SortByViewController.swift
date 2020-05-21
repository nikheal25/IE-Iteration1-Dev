//
//  SortByViewController.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 8/5/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit


/// protocol
protocol sortSelectionDelgate {
    func selectedSort(id: Int)
}


/// Controller
class SortByViewController: UIViewController {
    
    //variables
    var sortingSchema: Int!
    var sortSeletionDelegate:sortSelectionDelgate!
    
    //labels
    @IBOutlet weak var recommendedButton: UIButton!
    @IBOutlet weak var alphabeticalButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var recomendLabel: UILabel!
    @IBOutlet weak var alphabetLabel: UILabel!
    
    /// 
    override func viewDidLoad() {
        super.viewDidLoad()
        doneButton.layer.cornerRadius = 10
        
        if sortingSchema == 1 {
            recommendedButton.isSelected = true
        }
        if sortingSchema == 2 {
            alphabeticalButton.isSelected = true
        }
        recomendLabel.isUserInteractionEnabled = true
        alphabetLabel.isUserInteractionEnabled = true
        
        let recomend = UITapGestureRecognizer(target: self, action: #selector(SortByViewController.recommendedLabelClicked))
        recomendLabel.addGestureRecognizer(recomend)
        let alphabet = UITapGestureRecognizer(target: self, action: #selector(SortByViewController.alphabeticalLabelClicked))
        alphabetLabel.addGestureRecognizer(alphabet)
    }
    
    /// The action will set once user click on recommended option
    /// - Parameter sender:UIButton
    @IBAction func recommendedClicked(_ sender: UIButton) {
        if sender.isSelected {
            //            sender.isSelected = false
        } else {
            sender.isSelected = true
            alphabeticalButton.isSelected = false
        }
    }
    
    /// The action will set once user click on alphabetical option
    /// - Parameter sender:UIButton
    @IBAction func alphabeticalClicked(_ sender: UIButton) {
        if sender.isSelected {
            //            sender.isSelected = false
        } else {
            sender.isSelected = true
            recommendedButton.isSelected = false
        }
    }
    
    
    /// This action will get invoked once the use clicks on Done button
    /// - Parameter sender: Any
    @IBAction func doneButtonClicked(_ sender: Any) {
        var val = 0
        if recommendedButton.isSelected == true {
            val = 1
        }
        if alphabeticalButton.isSelected == true {
            val = 2
        }
        //Calls the delegate method which is responsible for sorting or recommending
        sortSeletionDelegate.selectedSort(id: val)
        dismiss(animated: true, completion: nil)
    }
    
    //This action will set the icon of Recommended option to ON/OFF
    @objc func recommendedLabelClicked(sender:UITapGestureRecognizer) {
        if recommendedButton.isSelected == true {
            recommendedButton.isSelected = false
        }else{
            alphabeticalButton.isSelected = false
            recommendedButton.isSelected = true
        }
    }
    //MARK:-based on your location [ALL CAPS]
    //MARK;-  A - Z
    //This action will set the icon of Alphabetical option to ON/OFF
    @objc func alphabeticalLabelClicked(sender:UITapGestureRecognizer) {
        if alphabeticalButton.isSelected == true {
            alphabeticalButton.isSelected = false
        }else{
            recommendedButton.isSelected = false
            alphabeticalButton.isSelected = true
        }
    }
    
}
