//
//  PopOverViewController.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 8/5/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

protocol filterDelgate {
    func filterOption(plantType: String, soilType: String)
}

class PopOverViewController: UIViewController {

    @IBOutlet weak var firstView: UIView!
    @IBOutlet weak var secondView: UIView!
    var filterSelectedDelegate: filterDelgate!
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }
    
    @IBAction func swichView(_ sender: UISegmentedControl) {
        if sender.selectedSegmentIndex == 0 {
            firstView.alpha = 1
            secondView.alpha = 0
        }else{
            firstView.alpha = 0
            secondView.alpha = 1
        }
    }
    

    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "filterSegue" {
            let destination = segue.destination as! FilterViewController
            destination.filterDelegate = self
        }
    }


}

extension PopOverViewController: filterSelectionDelgate {
    func selectedChoiced(plantType: String, soilType: String){
        print(plantType)
        print(soilType)
        filterSelectedDelegate.filterOption(plantType: plantType, soilType: soilType)
    }
}
