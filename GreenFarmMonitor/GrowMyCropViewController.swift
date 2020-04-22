//
//  GrowMyCropViewController.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 22/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

class GrowMyCropViewController: UIViewController, DatabaseListener {
    
    @IBOutlet weak var tableView: UITableView!
    
    let SECTION_ACTIVITY = 0;
    let SECTION_COUNT = 1;
    let CELL_COUNT = "CellCounter"
    let CELL_ACTIVITY = "Crop"
    var selectedRow = 0
    
    var myCropList: [Crop] = []
    
    var listenerType: ListenerType = ListenerType.all // listener
    weak var databaseController: DatabaseProtocol?
    weak var userDefaultController: UserdefaultsProtocol?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        userDefaultController = appDelegate.userDefaultController
        databaseController = appDelegate.databaseController
        
        myCropList = [Crop]()
        // Do any additional setup after loading the view.
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        
        myCropList = []
//        onUserCropRelationChange(change: .update, userCropRelation: databaseController!.userCropRelation)
        databaseController?.addListener(listener: self)
    }
    
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseController?.removeListener(listener: self)
    }
    
    func onDiseaseOfCropsChange(change: DatabaseChange, diseaseOfCrops: [DiseaseOfCrops]) {
        
    }
    
    func onCropsChange(change: DatabaseChange, crops: [Crop]) {
        
    }

    
    func onUserCropRelationChange(change: DatabaseChange, userCropRelation: [UserCropRelation]) {
        let currentUserId = userDefaultController?.retrieveUserId()
        
        myCropList = []
        for item in userCropRelation{
            if item.userId == currentUserId {
                let crop = findCropById(cropId: item.cropId)
                if crop == nil{
                    //
                } else{
                    
                    //End
                    self.myCropList.append(crop!)
                }
                
                tableView.reloadData()
            }
        }
    }
    
    //returns the object of crop, for specified ID
    func findCropById(cropId: String) -> Crop? {
        let allOnFirebaseCrops = databaseController!.cropsList
        for crop in allOnFirebaseCrops {
            if(crop.cropId == cropId){
                return crop
            }
        }
        return nil
    }
    func onUserChange(change: DatabaseChange, users: [User]) {
        
    }
    
}

extension GrowMyCropViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == SECTION_ACTIVITY {
            return (myCropList.count)
        }
        return 1
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        
        
        if indexPath.section == SECTION_ACTIVITY {
            let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ACTIVITY, for: indexPath) as! GrowMyCropTableViewCell
            //                cell.textLabel?.text = allCropsName[indexPath.row].cropName
            cell.setCell(crop: myCropList[indexPath.row])
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_COUNT, for: indexPath)
        cell.textLabel?.text = "\(myCropList.count) total crops in the list"
        cell.selectionStyle = .none
        return cell
        
    }
    
    //This method gets called when any cell is selected by the user
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        if indexPath.section == SECTION_ACTIVITY{
            selectedRow = indexPath.row
            tableView.deselectRow(at: indexPath, animated: true)
            self.performSegue(withIdentifier: "specificCropSegue", sender: self)
        }
    }
    
    
}
