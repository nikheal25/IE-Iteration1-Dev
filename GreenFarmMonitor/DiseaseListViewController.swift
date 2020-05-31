//
//  DiseaseListViewController.swift
//  GreenFarmMonitor
//
//  Created by Hanlin Shen on 22/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

class DiseaseListViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    /// Tableview setting
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownDiseases.count
        
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 120
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let diseaseCell = tableView.dequeueReusableCell(withIdentifier: "disease",for: indexPath)as! DiseaseTableViewCell
        let disease = shownDiseases[indexPath.row]
        let image = UIImage(named: disease.name.lowercased())
        if image == nil
        {
            diseaseCell.diseaseImage.image = UIImage(named: "not-found")
        }else{
            diseaseCell.diseaseImage.image = image}
        diseaseCell.diseaseNameLabel.text = disease.name
        return diseaseCell
    }
    
    
    
    ///Virables in the Class
    var crop:String = ""
    var shownDiseases:[DiseaseOfCrops] = []
    weak var databaseController: DatabaseProtocol?
    /// Load the data to the tableview
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        
        databaseController = appDelegate.databaseController
        
        self.diseaseTable.delegate = self
        self.diseaseTable.dataSource = self
        shownDiseases = [DiseaseOfCrops]()
        let DiseasesList = databaseController!.diseaseList
        for disease in DiseasesList
        {
            if disease.crop.uppercased() == crop.uppercased()
                
            {
                shownDiseases.append(disease)
            }
        }
        
        diseaseTable.reloadData()
        
        navigationItem.title = crop + " diseases"
    }
    
    @IBOutlet weak var diseaseTable: UITableView!
    var selectDisease:String = ""
    
    var diseaseDescription:String = ""
    /// Function of navigate to view the detail of disease
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        
        if segue.identifier == "SelectDiseaseSegue"
        { let indexPath = self.diseaseTable.indexPathForSelectedRow
            selectDisease = shownDiseases[indexPath!.row].name
            diseaseDescription = shownDiseases[indexPath!.row].descriptionOfSymptom
            
            let destination = segue.destination as! DetailOfDiseaseViewController
            destination.name = selectDisease
            destination.image = selectDisease.lowercased()
            destination.detail = diseaseDescription
            
        }
        
        
    }
    
    
    
    
    
    
    
}
