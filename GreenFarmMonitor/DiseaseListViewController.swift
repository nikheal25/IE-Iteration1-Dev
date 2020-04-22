//
//  DiseaseListViewController.swift
//  GreenFarmMonitor
//
//  Created by Hanlin Shen on 22/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

class DiseaseListViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,DatabaseListener {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return shownDiseases.count
        
    }
  
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let diseaseCell = tableView.dequeueReusableCell(withIdentifier: "disease",for: indexPath)as!
        DiseaseTableViewCell
        let disease = shownDiseases[indexPath.row]
        diseaseCell.diseaseImage.image = UIImage(named: disease.name)
        diseaseCell.diseaseNameLabel.text = disease.name
        return diseaseCell
    }
    
    var listenerType = ListenerType.all
    override func viewWillAppear(_ animated: Bool) {
         super.viewWillAppear(animated)
         databaseController?.addListener(listener:self)
     }
     override func viewWillDisappear(_ animated: Bool) {
         super.viewWillDisappear(animated)
        databaseController?.removeListener(listener:self)
     }
    func onDiseaseOfCropsChange(change: DatabaseChange, diseaseOfCrops: [DiseaseOfCrops]) {
        for disease in diseaseOfCrops
        {
            if disease.crop.uppercased() == "Bean"

            {
                shownDiseases.append(disease)
            }
        }
//        shownDiseases = diseaseOfCrops
        diseaseTable.reloadData()
    }
    
    func onCropsChange(change: DatabaseChange, crops: [Crop]) {
        
    }
    
    func onUserCropRelationChange(change: DatabaseChange, userCropRelation: [UserCropRelation]) {
        
    }
    
    func onUserChange(change: DatabaseChange, users: [User]) {
       
    }
    

    var crop:String = ""
    var shownDiseases:[DiseaseOfCrops] = []
     weak var databaseController: DatabaseProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
       
        self.diseaseTable.delegate = self
        self.diseaseTable.dataSource = self
        navigationItem.title = crop
    }
    
    @IBOutlet weak var diseaseTable: UITableView!
    var selectDisease:String = ""
    var diseaseName:String = ""
    var diseaseDescription:String = ""
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if segue.identifier == "SelectDiseaseSegue"
        { let indexPath = self.diseaseTable.indexPathForSelectedRow
            selectDisease = shownDiseases[indexPath!.row].name
            diseaseDescription = shownDiseases[indexPath!.row].descriptionOfSymptom
            
            let destination = segue.destination as! DetailOfDiseaseViewController
            destination.name = selectDisease
            destination.image = selectDisease
            destination.detail = diseaseDescription
            
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
