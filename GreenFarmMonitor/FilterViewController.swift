//
//  FilterViewController.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 8/5/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

class FilterViewController: UIViewController {
    
    private var dataSource = ["Perennial","Herb", "Annual", "Fruit"]
    private let plantType = ["Perennial","Herb", "Annual", "Fruit"]
    private let soilType = ["Loam","Sand", "Clay"]
    
    private var flag = 1
    
    @IBOutlet weak var soilTypeLabel: UILabel!
    @IBOutlet weak var platTypeLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var doneButton: UIButton!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.soilTypeLabel.adjustsFontSizeToFitWidth = true
        self.soilTypeLabel.minimumScaleFactor = 0.5
        self.platTypeLabel.adjustsFontSizeToFitWidth = true
        self.platTypeLabel.minimumScaleFactor = 0.5
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.isHidden = true
        doneButton.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    @IBAction func doneClicked(_ sender: Any) {
        pickerView.isHidden = true
        doneButton.isHidden = true
    }
    @IBAction func soilTypeClicked(_ sender: Any) {
        pickerView.isHidden = false
        doneButton.isHidden = false
        dataSource = soilType
        flag = 2
        pickerView.reloadComponent(0)
    }
    @IBAction func platTypeClicked(_ sender: Any) {
        pickerView.isHidden = false
        doneButton.isHidden = false
        dataSource = plantType
        flag = 1
        pickerView.reloadComponent(0)
    }
}

extension FilterViewController: UIPickerViewDelegate, UIPickerViewDataSource{
    func pickerView(_ pickerView: UIPickerView, numberOfRowsInComponent component: Int) -> Int {
        return dataSource.count
    }
    
    func numberOfComponents(in pickerView: UIPickerView) -> Int {
        return 1
    }
    
    func pickerView(_ pickerView: UIPickerView, titleForRow row: Int, forComponent component: Int) -> String? {
        return dataSource[row]
    }
    
    func pickerView(_ pickerView: UIPickerView, didSelectRow row: Int, inComponent component: Int) {
        if flag == 1 {
            platTypeLabel.text = dataSource[row]
        }
        if flag == 2 {
            soilTypeLabel.text = dataSource[row]
        }
        
        
    }
}
