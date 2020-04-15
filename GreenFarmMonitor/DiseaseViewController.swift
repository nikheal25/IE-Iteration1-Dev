//
//  DiseaseViewController.swift
//  GreenFarmMonitor
//
//  Created by Hanlin Shen on 13/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

class DiseaseViewController: UIViewController,UITableViewDataSource, UITableViewDelegate,DatabaseListener{
 
    
    
    var currentCrops: [Crop] = []
    var currentDiseases: [DiseaseOfCrops] = []
    weak var databaseController: DatabaseProtocol?
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == Section_Crops
        {
            return currentCrops.count
            
        }else{
            return shownDisease.count
            
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == Section_Crops
        {
            return "Select the crop list"
            
        }else{
            return "Diseases"
            
        }
    }
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == Section_Crops
        {
        let cropsCell = tableView.dequeueReusableCell(withIdentifier: "CropCell", for: indexPath) as! MyCropsTableViewCell
            let crops = currentCrops[indexPath.row]
            cropsCell.CropsName.text = crops.cropName
            return cropsCell
        }
        
       let diseaseCell = tableView.dequeueReusableCell(withIdentifier: "DiseaseCell", for: indexPath) as! DiseaseTableViewCell


        let disease = shownDisease[indexPath.row]

        diseaseCell.DiseaseName.text = disease.name

        diseaseCell.DiseaseImage.image = UIImage(named:disease.image)
        return diseaseCell
    }
    var shownDisease: [DiseaseOfCrops] = []
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        if indexPath.section == 0
        {
            shownDisease = [DiseaseOfCrops]()
        for disease in currentDiseases{
                if disease.crop == currentCrops[indexPath.row].cropName
                {
                    shownDisease.append(disease)
                    print(disease)
                }
            }
            }
        DiseaseTable.reloadData()
    }
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 2
        }
    
     
    

    let Section_Crops = 0
    let Section_disease = 1

   
   
    
    
    
    
    @IBOutlet weak var DiseaseTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
     
//        createCrops()
//        createDisease()
       self.DiseaseTable.dataSource = self
       self.DiseaseTable.delegate = self
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        databaseController = appDelegate.databaseController
   
        

        // Do any additional setup after loading the view.
    }
   
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        databaseController?.addListener(listener:self)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
       databaseController?.removeListener(listener:self)
    }
    var  listenerType = ListenerType.all
   
    func onDiseaseOfCropsChange(change: DatabaseChange, diseaseOfCrops:[DiseaseOfCrops])
    {
        currentDiseases = diseaseOfCrops
        DiseaseTable.reloadData()
       
    }
    
    func onUserCropRelationChange(change: DatabaseChange, userCropRelation: [UserCropRelation]) {
        
    }
    
    
    
    func onCropsChange(change: DatabaseChange, crops: [Crop])
    {
        currentCrops = crops
        
        DiseaseTable.reloadData()
        
    }

    
//    func createCrops()
//    {
//        myCrops.append("Tomato")
//        myCrops.append("Wheat")
//
//
//    }
//    func createDisease()
//    {
//        Disease.append(DiseaseOfCrops(name: "Septoria Leaf Spot", image: "Septoria.jpg"))
//        Disease.append(DiseaseOfCrops(name: "Anthracnose", image:"Anthracnose.jpg"))
//         Disease.append(DiseaseOfCrops(name: "Fusarium Wilt", image:"FusariumWilt.jpg"))
//        Disease.append(DiseaseOfCrops(name: "Blossom Drop", image:"BlossomDrop.jpg"))
//    }
    
    
    @IBAction func AddDiseaseBtn(_ sender: Any) {
        
    }
    
    

    var selectDisease:String = ""
    var diseaseImage:String = ""
    var diseaseDescription:String = ""
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if segue.identifier == "SelectDiseaseSegue"
        { let indexPath = self.DiseaseTable.indexPathForSelectedRow
            selectDisease = shownDisease[indexPath!.row].name
            diseaseDescription = shownDisease[indexPath!.row].descriptionOfSymptom
            diseaseImage = shownDisease[indexPath!.row].image
            let destination = segue.destination as! DetailOfDiseaseViewController
            destination.name = selectDisease
            destination.image = diseaseImage
            destination.detail = diseaseDescription
            
        }
        
        
    }
    
    

}
