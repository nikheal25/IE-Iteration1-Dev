//
//  SortByViewController.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 8/5/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

protocol sortSelectionDelgate {
    func selectedSort(id: Int)
}

class SortByViewController: UIViewController {
    
    var sortingSchema: Int!
    var sortSeletionDelegate:sortSelectionDelgate!
    @IBOutlet weak var recommendedButton: UIButton!
    @IBOutlet weak var alphabeticalButton: UIButton!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var recomendLabel: UILabel!
    @IBOutlet weak var alphabetLabel: UILabel!
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
    
    
    @IBAction func recommendedClicked(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
            alphabeticalButton.isSelected = false
        }
    }
    
    @IBAction func alphabeticalClicked(_ sender: UIButton) {
        if sender.isSelected {
            sender.isSelected = false
        } else {
            sender.isSelected = true
            recommendedButton.isSelected = false
        }
    }
    
    @IBAction func doneButtonClicked(_ sender: Any) {
        var val = 0
        if recommendedButton.isSelected == true {
            val = 1
        }
        if alphabeticalButton.isSelected == true {
            val = 2
        }
        sortSeletionDelegate.selectedSort(id: val)
        dismiss(animated: true, completion: nil)
    }
    
    @objc func recommendedLabelClicked(sender:UITapGestureRecognizer) {
        if recommendedButton.isSelected == true {
            recommendedButton.isSelected = false
        }else{
            alphabeticalButton.isSelected = false
            recommendedButton.isSelected = true
        }
    }
    @objc func alphabeticalLabelClicked(sender:UITapGestureRecognizer) {
        if alphabeticalButton.isSelected == true {
            alphabeticalButton.isSelected = false
        }else{
            recommendedButton.isSelected = false
            alphabeticalButton.isSelected = true
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
