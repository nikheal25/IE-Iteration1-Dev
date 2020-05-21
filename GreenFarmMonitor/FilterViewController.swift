//
//  FilterViewController.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 8/5/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

/// delgate
protocol filterSelectionDelgate {
    func selectedChoiced(plantType: String, soilType: String)
}


/// controller
class FilterViewController: UIViewController {
    
    /// class variables
    var filterDelegate: filterSelectionDelgate!
    var plantFilter: String!
    var soilFilter: String!
    
    
    /// classification type
    private var dataSource = ["Perennial","Herb", "Annual", "Fruit"]
    private let plantType = ["Perennial","Herb", "Annual", "Fruit"]
    private let soilType = ["Loam","Sand", "Clay"]
    
    private var flag = 1
    var soil: String!
    var plant: String!
    
    /// labels
    @IBOutlet weak var soilTypeLabel: UILabel!
    @IBOutlet weak var platTypeLabel: UILabel!
    @IBOutlet weak var pickerView: UIPickerView!
    @IBOutlet weak var doneButton: UIButton!
    @IBOutlet weak var instructionLabel: UILabel!
    override func viewDidLoad() {
        super.viewDidLoad()
        
        platTypeLabel.text = plantFilter
        soilTypeLabel.text = soilFilter
        
        self.soilTypeLabel.adjustsFontSizeToFitWidth = true
        self.soilTypeLabel.minimumScaleFactor = 0.5
        self.platTypeLabel.adjustsFontSizeToFitWidth = true
        self.platTypeLabel.minimumScaleFactor = 0.5
        pickerView.dataSource = self
        pickerView.delegate = self
        pickerView.isHidden = true
        pickerView.backgroundColor = UIColor(hexString: "E4D9FF")
        doneButton.isHidden = true
        instructionLabel.isHidden = true
        // Do any additional setup after loading the view.
    }
    
    /// method gets called when use click on Done button
    /// - Parameter sender: Any
    @IBAction func doneClicked(_ sender: Any) {
        pickerView.isHidden = true
        doneButton.isHidden = true
        filterDelegate.selectedChoiced(plantType: platTypeLabel.text!, soilType: soilTypeLabel.text!)
        instructionLabel.isHidden = true
        dismiss(animated: true, completion: nil)
    }
    
    /// when Soil Type button is clicked, it will get invoked
    /// - Parameter sender: Any
    @IBAction func soilTypeClicked(_ sender: Any) {
        pickerView.isHidden = false
        doneButton.isHidden = false
        instructionLabel.isHidden = false
        instructionLabel.text = "Please choose the Soil Type"
        dataSource = soilType
        flag = 2
        pickerView.reloadComponent(0)
    }
    
    /// when Plant Type button is clicked, it will get invoked
    /// - Parameter sender: Any
    @IBAction func platTypeClicked(_ sender: Any) {
        pickerView.isHidden = false
        doneButton.isHidden = false
        instructionLabel.isHidden = false
        instructionLabel.text = "Please choose the Plant Type"
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
