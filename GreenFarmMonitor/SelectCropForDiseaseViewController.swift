//
//  SelectCropForDiseaseViewController.swift
//  GreenFarmMonitor
//
//  Created by Hanlin Shen on 22/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

class SelectCropForDiseaseViewController: UIViewController , UITableViewDataSource,UISearchBarDelegate, UITableViewDelegate,DatabaseListener{
    func onUserCropRelationChange(change: DatabaseChange, userCropRelation: [UserCropRelation]) {
        
    }
    
 func onUserChange(change: DatabaseChange, users: [User]) {
     
 }
 

 func onDiseaseOfCropsChange(change: DatabaseChange, diseaseOfCrops: [DiseaseOfCrops]) {

     
 }
 
 func onCropsChange(change: DatabaseChange, crops: [Crop]) {
    
   
    currentCrops = crops
    
    cropTable.reloadData()
 }
 

 var listenerType: ListenerType = ListenerType.all // listener
 weak var databaseController: DatabaseProtocol?

 
 var currentCrops: [Crop] = []
 var currentDiseases: [DiseaseOfCrops] = []
 
 var searchedCrop = [Crop]()
 var searching = false

    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
               
        databaseController = appDelegate.databaseController
        
        self.cropTable.dataSource = self
        self.cropTable.delegate = self
        self.searchBar.delegate = self
               
               
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
    @IBOutlet weak var cropTable: UITableView!
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    
        return currentCrops.count
    }
   func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
    //if searching
   //{
    let cropsCell = tableView.dequeueReusableCell(withIdentifier: "Crop",for: indexPath) as! FoundDiseaseCropsTableViewCell
    let crop = currentCrops[indexPath.row]
    cropsCell.cropImage.image = UIImage(named:crop.cropImage)
    cropsCell.cropNameLabel.text = crop.cropName
        return cropsCell
//    }
    
//    else{
//        let searchCell = tableView.dequeueReusableCell(withIdentifier: "Crop",for: indexPath) as! FoundDiseaseCropsTableViewCell
//        let crop = tempCrops[indexPath.row]
//        searchCell.cropImage.image = UIImage(named:crop.cropImage)
//        searchCell.cropNameLabel.text = crop.cropName
//        return searchCell
//    }
    }
    var tempCrops:[Crop] = []
   
    func filterCells(term:String) -> [Crop]
    {
        for crop in currentCrops {
       if crop.cropName.lowercased().prefix(term.count) == term.lowercased() {
                tempCrops.append(crop)
            }
        }
        return tempCrops
    }
      func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
    //        searchedCountry = allCropsName.filter({$0.lowercased().prefix(searchText.count) == searchText.lowercased()})
            searchedCrop = filterCells(term: searchText)
            searching = true
        cropTable.reloadData()
        }
        
        func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
            searching = false
            searchBar.text = ""
           cropTable.reloadData()
        }
    
    // MARK: - Navigation
    var selectCrop: String = ""
    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "SelectCropSegue"
        {
            let destination = segue.destination as! DiseaseListViewController
            let indexPath = self.cropTable.indexPathForSelectedRow
//            if searching{
            
                selectCrop = currentCrops[indexPath!.row].cropName
                destination.crop = selectCrop
                
                
//            }else{
//                selectCrop = tempCrops[indexPath!.row].cropName
//                destination.crop = selectCrop
//                
//            }
        }
    }
    

}