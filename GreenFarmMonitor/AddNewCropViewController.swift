//
//  AddNewCropViewController.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 13/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

class AddNewCropViewController: UIViewController{
   
    var allCropsName: [Crop] = []
    
    func createFakeData() -> [Crop] {
        let aCrops = ["Afghanistan", "Albania", "Algeria", "American Samoa", "Andorra", "Angola", "Anguilla", "Antarctica", "Antigua and Barbuda", "Argentina", "Armenia", "Aruba", "Australia", "Austria", "Azerbaijan", "Bahamas", "Bahrain", "Bangladesh", "Barbados", "Belarus", "Belgium", "Belize", "Benin", "Bermuda", "Bhutan", "Bolivia", "Bosnia and Herzegowina", "Botswana", "Bouvet Island", "Brazil", "British Indian Ocean Territory", "Brunei Darussalam", "Bulgaria", "Burkina Faso", "Burundi", "Cambodia", "Cameroon", "Canada", "Cape Verde", "Cayman Islands", "Central African Republic", "Chad", "Chile", "China", "Christmas Island", "Cocos (Keeling) Islands", "Colombia", "Comoros", "Congo"]
        var i = 0
        var tempArray: [Crop] = []
        
        for crop in aCrops {
            tempArray.append(Crop(cropId: "\(i)", cropName: crop, cropImage: crop))
            i = i+1
        }
        
        return tempArray
    }
    
    var searchedCrop = [Crop]()
    var searching = false
    
    @IBOutlet weak var searchBar: UISearchBar!
    @IBOutlet weak var tableView: UITableView!
    
    let SECTION_ACTIVITY = 0;
    let SECTION_COUNT = 1;
    let CELL_COUNT = "CellCounter"
    let CELL_ACTIVITY = "Crop"
    var selectedRow = 0
    
    override func viewDidLoad() {
        super.viewDidLoad()
        allCropsName = createFakeData()
        searchBar.delegate = self
        // Do any additional setup after loading the view.
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
           return 2
       }


    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "specificCropSegue" {
            let destination = segue.destination as! DetailNewCropViewController
            destination.specificCrop = nil   //// TODO - send the variable
        }
    }

}

extension AddNewCropViewController: UITableViewDelegate, UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if searching {
            if section == SECTION_ACTIVITY {
                return (searchedCrop.count)
            }
            return 1;
        } else {
            if section == SECTION_ACTIVITY {
                return (allCropsName.count)
            }
            return 1;
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "cell")
        if searching {
            if indexPath.section == SECTION_ACTIVITY {
                                            let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ACTIVITY, for: indexPath) as! MyCropCellTableViewCell
//                                            cell.textLabel?.text = searchedCountry[indexPath.row]
                cell.setCell(crop: searchedCrop[indexPath.row])
                                            return cell
                                        }
                                        let cell = tableView.dequeueReusableCell(withIdentifier: CELL_COUNT, for: indexPath)
//            cell.textLabel?.text = "\(searchedCountry.count) alerts in the list"
                                        cell.selectionStyle = .none
                                        return cell
        } else {
             if indexPath.section == SECTION_ACTIVITY {
                                 let cell = tableView.dequeueReusableCell(withIdentifier: CELL_ACTIVITY, for: indexPath) as! MyCropCellTableViewCell
//                cell.textLabel?.text = allCropsName[indexPath.row].cropName
                cell.setCell(crop: allCropsName[indexPath.row])
                                 return cell
                             }
                             let cell = tableView.dequeueReusableCell(withIdentifier: CELL_COUNT, for: indexPath)
//            cell.textLabel?.text = "\(allCropsName.count) crops in the list"
                             cell.selectionStyle = .none
                             return cell
        }
        return cell!
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

extension AddNewCropViewController: UISearchBarDelegate {
    
    func filterCells(term: String) -> [Crop] {
        var tempCrops: [Crop] = []
        
        for crop in allCropsName {
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
        tableView.reloadData()
    }
    
    func searchBarCancelButtonClicked(_ searchBar: UISearchBar) {
        searching = false
        searchBar.text = ""
        tableView.reloadData()
    }
    
}
