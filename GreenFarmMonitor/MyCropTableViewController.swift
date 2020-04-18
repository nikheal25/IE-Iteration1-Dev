//
//  MyCropTableViewController.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 13/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

class MyCropTableViewController: UITableViewController, DatabaseListener {
    func onUserChange(change: DatabaseChange, users: [User]) {
        
    }
    
    
    var listenerType: ListenerType = ListenerType.all // listener
    weak var databaseController: DatabaseProtocol?
    weak var userDefaultController: UserdefaultsProtocol?
    var deviceIDs: [String] = []
    
    func onDiseaseOfCropsChange(change: DatabaseChange, diseaseOfCrops: [DiseaseOfCrops]) {
        
    }
    
    func onCropsChange(change: DatabaseChange, crops: [Crop]) {
        
    }
    
    @IBAction func addNewCrop(_ sender: Any) {
        self.performSegue(withIdentifier: "addNewCropSegue", sender: self)
    }
    func onUserCropRelationChange(change: DatabaseChange, userCropRelation: [UserCropRelation]) {
        let currentUserId = userDefaultController?.retrieveUserId()
        
        //GET ALL THE CROPS
        let allCropList = databaseController?.cropsList
        
        myCropList = []
        deviceIDs = []
        for item in userCropRelation{
            if item.userId == currentUserId {
                var crop = findCropById(cropId: item.cropId)
                if crop == nil{
//                    device = IoTDevice()
//                    device!.iotId = "00000"
//                    device!.deviceName = "Unregistered Device"
                } else{
                    //Separate list for storing the ids - start
                    self.deviceIDs.append(crop!.cropId)
                    //End
                    self.myCropList.append(crop!)
                }
                
                tableView.reloadData()
            }
        }
    }
    

    let SECTION_ACTIVITY = 0;
     let SECTION_COUNT = 1;
     let CELL_COUNT = "CellCounter"
     let CELL_ACTIVITY = "myCropCell"
     var myCropList: [Crop] = []
     var selectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        myCropList = [Crop]()
        deviceIDs = [String]()
        
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        userDefaultController = appDelegate.userDefaultController
        databaseController = appDelegate.databaseController
        
        // Uncomment the following line to preserve selection between presentations
        // self.clearsSelectionOnViewWillAppear = false

        // Uncomment the following line to display an Edit button in the navigation bar for this view controller.
        // self.navigationItem.rightBarButtonItem = self.editButtonItem
    }

        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
        
//            self.navigationController!.navigationBar.barStyle = .black
            self.navigationController!.navigationBar.isTranslucent = true
//            self.navigationController!.navigationBar.titleTextAttributes = [.foregroundColor: UIColor.white]
//            self.navigationController!.navigationBar.tintColor = #colorLiteral(red: 1, green: 0.99997437, blue: 0.9999912977, alpha: 1)
            myCropList = []
           // self.onTemperatureChange(change: .update, temperatures: databaseController!.tempList)
//            self.onUserCropRelationChange(change: .update, userCropRelation: databaseController!.userCropRelation)
           //self.onRuleChange(change: .update, rule: databaseController!.ruleList)
            databaseController?.addListener(listener: self)
        }
        
        override func viewWillDisappear(_ animated: Bool) {
            super.viewWillDisappear(animated)
            databaseController?.removeListener(listener: self)
        }
        
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        return 2
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if section == SECTION_ACTIVITY {
            return (myCropList.count)
        }
        return 1;
    }

   override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        if indexPath.section == SECTION_ACTIVITY {
            let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ACTIVITY, for: indexPath) as! MyCropMainTableViewCell
            //cell.textLabel?.text = cropList[indexPath.row].cropName
            cell.setCell(crop: myCropList[indexPath.row])
            return cell
        }
        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_COUNT, for: indexPath)
        cell.textLabel?.text = "\(myCropList.count) alerts in the list"
        cell.selectionStyle = .none
        return cell
    }
    
    override func tableView(_ tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
       if section == SECTION_ACTIVITY {
        
        if myCropList.count == 0 {
            return "Your list of crops is empty. Please add  the crops by clicking on Plus button"
        }
            return "Existing crops in my list"
        }
        return "Add new Crops"

    }
    
//    func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        if myCropList.count == 0 {
////        let headerView = UIView(frame: CGRect(x: 0, y: 0, width: tableView.bounds.size.width, height: 30))
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor.red
//        return headerView
//        }
//        let headerView = UIView()
//        return headerView
//    }
//
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 25
    }
//    override func tableView(_ tableView: UITableView, viewForFooterInSection section: Int) -> UIView? {
//         let headerView = UIView()
//        // MARK: - change the color
////               headerView.backgroundColor = UIColor.red
//               return headerView
//    }
//
//    override func tableView(_ tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
//        let headerView = UIView()
//        headerView.backgroundColor = UIColor(hexString: "#588B8B")
//        headerView.text
//        let lbl = UILabel()
//        lbl.text = "yourString"
//
//        // Enum type, two variations:
//        lbl.textAlignment = NSTextAlignment.right
//        lbl.textAlignment = .right
//
//        lbl.textColor = UIColor.red
//        lbl.shadowColor = UIColor(hexString: "#588B8B")
//        lbl.font = UIFont(name: "HelveticaNeue", size: CGFloat(22))
//        headerView.addSubview(lbl)
//        return headerView
//    }
    override func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        if section == SECTION_ACTIVITY {
            return 40
        }
        return 20
    }

    /*
    // Override to support conditional editing of the table view.
    override func tableView(_ tableView: UITableView, canEditRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the specified item to be editable.
        return true
    }
    */


    
    override func tableView(_ tableView: UITableView, commit editingStyle: UITableViewCell.EditingStyle, forRowAt indexPath: IndexPath) {
        if editingStyle == .delete {
//             Delete the row from the data source
            tableView.deleteRows(at: [indexPath], with: .fade)
        } else if editingStyle == .insert {
//             Create a new instance of the appropriate class, insert it into the array, and add a new row to the table view
        }    
    }


    /*
    // Override to support rearranging the table view.
    override func tableView(_ tableView: UITableView, moveRowAt fromIndexPath: IndexPath, to: IndexPath) {

    }
    */

    /*
    // Override to support conditional rearranging of the table view.
    override func tableView(_ tableView: UITableView, canMoveRowAt indexPath: IndexPath) -> Bool {
        // Return false if you do not want the item to be re-orderable.
        return true
    }
    */

    //This method gets called when any cell is selected by the user
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
          if indexPath.section == SECTION_ACTIVITY{
              selectedRow = indexPath.row
              tableView.deselectRow(at: indexPath, animated: true)
              self.performSegue(withIdentifier: "foldingSegue", sender: self)
          }
      }
  
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "addNewCropSegue" {
            let destination = segue.destination as! AddNewCropViewController
            destination.registeredCrop = deviceIDs
        }
        if segue.identifier == "newSpecificCrop" {
                   let destination = segue.destination as! DetailOfTheCropViewController
            destination.specificCrop = myCropList[selectedRow]
            destination.newCrop = false
               }
        
        if segue.identifier == "foldingSegue" {
                          let destination = segue.destination as! FoldingTableViewController
                  
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
}
