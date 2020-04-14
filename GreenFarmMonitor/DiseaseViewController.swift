//
//  DiseaseViewController.swift
//  GreenFarmMonitor
//
//  Created by Hanlin Shen on 13/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

class DiseaseViewController: UIViewController,UITableViewDataSource, UITableViewDelegate {
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == Section_Crops
        {
            return myCrops.count
            
        }else{
            return Disease.count
            
        }
    }

    func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        if section == Section_Crops
        {
            return "My Crops"
            
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
        let crops = myCrops[indexPath.row]
            cropsCell.CropsName.text = crops
            return cropsCell
        }
        let diseaseCell = tableView.dequeueReusableCell(withIdentifier: "DiseaseCell", for: indexPath) as! DiseaseTableViewCell
        let disease = Disease[indexPath.row]
        
        diseaseCell.DiseaseName.text = disease.name
        diseaseCell.DiseaseImage.image = UIImage(named:disease.image)
        return diseaseCell
    }
    
    
    
    func numberOfSections(in tableView: UITableView) -> Int {
            return 2
        }
    
     
    

    let Section_Crops = 0
    let Section_disease = 1

    var myCrops:[String] = []
    var Disease:[DiseaseOfCrops] = []
    
    
    
    
    @IBOutlet weak var DiseaseTable: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        createCrops()
        createDisease()
   self.DiseaseTable.dataSource = self
    self.DiseaseTable.delegate = self
        
   
        

        // Do any additional setup after loading the view.
    }
    
    
    func createCrops()
    {
        myCrops.append("Tomato")
        myCrops.append("Wheat")
        
        
    }
    func createDisease()
    {
        Disease.append(DiseaseOfCrops(name: "Septoria Leaf Spot", image: "Septoria.jpg"))
        Disease.append(DiseaseOfCrops(name: "Anthracnose", image:"Anthracnose.jpg"))
         Disease.append(DiseaseOfCrops(name: "Fusarium Wilt", image:"FusariumWilt.jpg"))
        Disease.append(DiseaseOfCrops(name: "Blossom Drop", image:"BlossomDrop.jpg"))
    }
    
    
    @IBAction func AddDiseaseBtn(_ sender: Any) {
        
    }
    
    

    var selectDisease:String = ""
    var diseaseImage:String = ""
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
     
        if segue.identifier == "SelectDiseaseSegue"
        { let indexPath = self.DiseaseTable.indexPathForSelectedRow
            selectDisease = Disease[indexPath!.row].name
            diseaseImage = Disease[indexPath!.row].image
          let destination = segue.destination as! DetailOfDiseaseViewController
          destination.name = selectDisease
          destination.image = diseaseImage
     
        }
        
        
    }
    
    

}
