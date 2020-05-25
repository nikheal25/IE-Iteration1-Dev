//
//  FoldingTableViewController.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 18/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit
import FoldingCell
import SwiftMessages

class FoldingTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    
    /// class variable
    var specificCrop: Crop?
    // MARK: Sort and Filter
    var sortingSchema: Int?
    var plantFilter: String?
    var soilFilter: String?
    
    var listenerType: ListenerType = ListenerType.all // listener
    weak var databaseController: DatabaseProtocol?
    weak var userDefaultController: UserdefaultsProtocol?
    
    /// List of crops
    var allCropsName: [Crop] = []
    var registeredCrop: [String]?
    
    /// list of searched crops
    var searchedCrop = [Crop]()
    var recomenededCropsName = [Crop]()
    var searching = false
    
    ///
    let SECTION_ACTIVITY = 0;
    let SECTION_COUNT = 1;
    let CELL_COUNT = "CellCounter"
    let CELL_ACTIVITY = "Crop"
    var selectedRow = 0
    @IBOutlet weak var searchBar: UISearchBar!
    
    enum Const {
        static let closeCellHeight: CGFloat = 130
        static let openCellHeight: CGFloat = 488
        static let rowsCount = 10
    }
    
    //MARK: Swiftmessage
    /// This method will show the floating message on the screen
    /// - Parameters:
    ///   - title: <#title description#>
    ///   - message: <#message description#>
    ///   - iconIndex: <#iconIndex description#>
    func showSwiftMessage(title: String, message: String, iconIndex: Int) {
        let view = MessageView.viewFromNib(layout: .cardView)
        
        var config = SwiftMessages.Config()
        
        // Slide up from the bottom.
        //        config.presentationStyle = .bottom
        config.duration = .seconds(seconds: 0.8)
        
        // Theme message elements with the warning style.
        //.success OR .warning OR .info OR .error
        view.configureTheme(.success)
        
        // Add a drop shadow.
        view.configureDropShadow()
        
        // Set message title, body, and icon. Here, we're overriding the default warning
        // image with an emoji character.
        let iconText = ["😄", "🌿", "🔝", "🆎"]
        view.configureContent(title: title, body: message, iconImage: nil, iconText: iconText[iconIndex], buttonImage: nil, buttonTitle: "Great", buttonTapHandler: nil)
        
        // Increase the external margin around the card. In general, the effect of this setting
        // depends on how the given layout is constrained to the layout margins.
        view.layoutMarginAdditions = UIEdgeInsets(top: 20, left: 20, bottom: 20, right: 20)
        
        // Reduce the corner radius (applicable to layouts featuring rounded corners).
        (view.backgroundView as? CornerRoundingView)?.cornerRadius = 10
        
        // Show the message.
        SwiftMessages.show(config: config, view: view)
    }
    
    var cellHeights: [CGFloat] = []
    
    weak var api: APIProtocol?
    var recommendedCrops: [String] = []
    
    //    @objc override func dismissKeyboard() {
    //        //Causes the view (or one of its embedded text fields) to resign the first responder status.
    //        view.endEditing(true)
    //    }
    // MARK: Life Cycle
    override func viewDidLoad() {
        //MARK:- Change sorting schema
        sortingSchema = 2
        plantFilter = "Please select"
        soilFilter = "Please select"
        
        
        
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        userDefaultController = appDelegate.userDefaultController
        databaseController = appDelegate.databaseController
        api = appDelegate.weatherAPI
        
        self.title = "All Plants"
        
        tableView.tableFooterView = UIView()
        allCropsName = getRelevantCrops()
        searchBar.delegate = self
        // Do any additional setup after
        
        setup()
        var latitude = "-37.840"
        var longitude = "144.94"
        if let latitudeOne = userDefaultController?.retriveLat() {
            latitude = latitudeOne
        }
        if let longitudeTwo = userDefaultController?.retriveLong() {
            longitude = longitudeTwo
        }
        recommendedCrops = ((api?.apiRecommendedCrop(lat: latitude, long: longitude))!)
        
        let concurrentQueue = DispatchQueue(label: "com.some.concurrentQueue", attributes: .concurrent)
        
        //Adds delay to the call of API
        concurrentQueue.async {
            do{
                //                print("1")
                do{
                    sleep(3)
                }
                self.recommendedCrops = self.api!.recomendedCrops
                //                print("2")
                //                print(self.recommendedCrops)
            }
        }
        sortCrops()
        self.tableView.reloadData()
    }
    
    /// This method returns the list of crops that are registered by the user
    func getRelevantCrops() -> [Crop] {
        let allCrops = databaseController!.cropsList
        var tempList: [Crop] = []
        
        for crop in allCrops {
            if !((registeredCrop?.contains(crop.cropId))!) {
                tempList.append(crop)
            }
        }
        return tempList
    }
    
    /// gets the list of recommended crops
    func recommendedCrop() -> [Crop] {
        var tempCrops: [Crop] = []
        
        for crop in allCropsName {
            if recommendedCrops.contains(crop.cropName) {
                tempCrops.append(crop)
            }
        }
        return tempCrops
    }
    
    /// Sorts the crop according to the user input
    func sortCrops()  {
        if sortingSchema == 1 {
            searching = true
            searchedCrop = recommendedCrop()
        }
        
        if sortingSchema == 2 {
            searching = false
            allCropsName.sort {
                $0.cropName < $1.cropName
            }
            
            searchedCrop.sort {
                $0.cropName < $1.cropName
            }
        }
    }
    
    /// Takes user to different view controller
    /// - Parameters:
    ///   - segue: <#segue description#>
    ///   - sender: <#sender description#>
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPopOverSegue" {
            let popoverViewController = segue.destination as! PopOverViewController
            popoverViewController.filterSelectedDelegate = self
            popoverViewController.sortingSchema = sortingSchema
            popoverViewController.plantFilter = plantFilter
            popoverViewController.soilFilter = soilFilter
            popoverViewController.popoverPresentationController?.delegate = self
        }
    }
    
    func adaptivePresentationStyle(for controller: UIPresentationController) -> UIModalPresentationStyle {
        return UIModalPresentationStyle.none
    }
    
    @IBAction func showDirectionPopup(_ sender: UIView) {
        
    }
    
    private func showPopup(_ controller: UIViewController, sourceView: UIView) {
        
    }
    // MARK: Helpers
    private func setup() {
        cellHeights = Array(repeating: Const.closeCellHeight, count: allCropsName.count)
        tableView.estimatedRowHeight = Const.closeCellHeight
        tableView.rowHeight = UITableView.automaticDimension
        //            tableView.backgroundColor = UIColor(patternImage: #imageLiteral(resourceName: "background"))
        if #available(iOS 10.0, *) {
            tableView.refreshControl = UIRefreshControl()
            tableView.refreshControl?.addTarget(self, action: #selector(refreshHandler), for: .valueChanged)
        }
    }
    
    func findSpecificCrop(name: String, defaultCrop: Crop) -> Crop {
        for crop in allCropsName {
            if crop.cropName == name {
                return crop
            }
        }
        return defaultCrop
    }
    
    // MARK: Actions
    @objc func refreshHandler() {
        let deadlineTime = DispatchTime.now() + .seconds(1)
        DispatchQueue.main.asyncAfter(deadline: deadlineTime, execute: { [weak self] in
            if #available(iOS 10.0, *) {
                self?.tableView.refreshControl?.endRefreshing()
            }
            self?.tableView.reloadData()
        })
    }
}

// MARK: - TableView

extension FoldingTableViewController {
    
    override func tableView(_: UITableView, numberOfRowsInSection section: Int) -> Int {
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
    
    
    
    override func tableView(_: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
        guard case let cell as DemoTableViewCell = cell else {
            return
        }
        
        cell.backgroundColor = .clear
        
        if cellHeights[indexPath.row] == Const.closeCellHeight {
            cell.unfold(false, animated: false, completion: nil)
        } else {
            cell.unfold(true, animated: false, completion: nil)
        }
        
        cell.number = indexPath.row
    }
    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "FoldingCell", for: indexPath) as! DemoTableViewCell
        let durations: [TimeInterval] = [0.26, 0.2, 0.1]
        //[0.26, 0.2, 0.2]
        
        if searching {
            
            
            cell.durationsForExpandedState = durations
            cell.durationsForCollapsedState = durations
            
            let compatibleCrop = findSpecificCrop(name: searchedCrop[indexPath.row].Compatible_plant, defaultCrop: searchedCrop[indexPath.row])
            cell.setUp(crop: searchedCrop[indexPath.row], companionCrop: compatibleCrop)
            cell.selectionDelegate = self
            
        } else {
            
            cell.durationsForExpandedState = durations
            cell.durationsForCollapsedState = durations
            
            let compatibleCrop = findSpecificCrop(name: allCropsName[indexPath.row].Compatible_plant, defaultCrop: allCropsName[indexPath.row])
            cell.setUp(crop: allCropsName[indexPath.row], companionCrop: compatibleCrop)
            cell.selectionDelegate = self
        }
        return cell
    }
    
    override func tableView(_: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return cellHeights[indexPath.row]
    }
    
    override func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        
        let cell = tableView.cellForRow(at: indexPath) as! FoldingCell
        
        if cell.isAnimating() {
            return
        }
        
        var duration = 0.0
        let cellIsCollapsed = cellHeights[indexPath.row] == Const.closeCellHeight
        if cellIsCollapsed {
            cellHeights[indexPath.row] = Const.openCellHeight
            cell.unfold(true, animated: true, completion: nil)
            duration = 0.5
        } else {
            cellHeights[indexPath.row] = Const.closeCellHeight
            cell.unfold(false, animated: true, completion: nil)
            duration = 0.8
        }
        
        UIView.animate(withDuration: duration, delay: 0, options: .curveEaseOut, animations: { () -> Void in
            tableView.beginUpdates()
            tableView.endUpdates()
            
            if cell.frame.maxY > tableView.frame.maxY {
                tableView.scrollToRow(at: indexPath, at: UITableView.ScrollPosition.bottom, animated: true)
            }
        }, completion: nil)
    }
}

extension FoldingTableViewController: UISearchBarDelegate {
    
    func searchBarSearchButtonClicked(_ searchBar: UISearchBar) {
        searchBar.resignFirstResponder()
    }
    
    /// filters the cell based on the crop
    /// - Parameter term: <#term description#>
    func filterCells(term: String) -> [Crop] {
        var tempCrops: [Crop] = []
        
        for crop in allCropsName {
            
            if crop.cropName.lowercased().prefix(term.count) == term.lowercased() {
                tempCrops.append(crop)
            }else if let range = crop.cropName.range(of: " ") {
                let secondWord = crop.cropName.lowercased()[range.upperBound...]
                print("--\(secondWord)")
                if secondWord.prefix(term.count) == term.lowercased() {
                    tempCrops.append(crop)
                }
            }
        }
        return tempCrops
    }
    
    /// filters cell by plant type
    /// - Parameter term: <#term description#>
    func filterCellsByPlantType(term: String) -> [Crop] {
        var tempCrops: [Crop] = []
        
        for crop in allCropsName {
            //            if crop.Plant_Type.lowercased().prefix(term.count) == term.lowercased() {
            //                tempCrops.append(crop)
            //            }
            if crop.Plant_Type.lowercased().contains(term.lowercased()) {
                tempCrops.append(crop)
            }
        }
        return tempCrops
    }
    
    /// filters the plant by sort
    /// - Parameter term: <#term description#>
    func filterCellsBySoilType(term: String) -> [Crop] {
        var tempCrops: [Crop] = []
        
        for crop in allCropsName {
            if crop.Soil_Type.lowercased().prefix(term.count) == term.lowercased() {
                tempCrops.append(crop)
            }
        }
        return tempCrops
    }
    
    /// Filters the crop based on PlantType and SoilType
    /// - Parameters:
    ///   - plantType: <#plantType description#>
    ///   - soilType: <#soilType description#>
    func filterSoilAndPlantType(plantType: String, soilType: String) -> [Crop] {
        var tempCrops: [Crop] = []
        
        for crop in allCropsName {
            if crop.Soil_Type.lowercased().contains(soilType.lowercased()) && crop.Plant_Type.lowercased().contains(plantType.lowercased()) {
                tempCrops.append(crop)
            }
        }
        return tempCrops
    }
    
    /// searches the plants based on the user input
    /// - Parameters:
    ///   - searchBar: <#searchBar description#>
    ///   - searchText: <#searchText description#>
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

extension FoldingTableViewController: SelectionDelegate{
    
    func didAddCrop() {
        _ = navigationController?.popToRootViewController(animated: true)
    }
}
extension FoldingTableViewController: filterDelgate {
    /// gets the sorting ID from another class
    /// - Parameter id: <#id description#>
    func sortOption(id: Int) {
        //        print("Inside folding cell \(id)")
        sortingSchema = id
        sortCrops()
        tableView.reloadData()
        if sortingSchema == 2 {
            showSwiftMessage(title: "Sorted Alphabetically", message: "You can always change this!", iconIndex: 3)
        } else {
            showSwiftMessage(title: "Recommended First", message: "Ordered in recommended manner!", iconIndex: 2)
        }
        
    }
    
    /// gets the filter ID from another class
    /// - Parameters:
    ///   - plantType: <#plantType description#>
    ///   - soilType: <#soilType description#>
    func filterOption(plantType: String, soilType: String) {
        print(plantType)
        if plantType == "cancel" {
            searching = false
            self.plantFilter = "Please select"
            self.soilFilter = "Please select"
            tableView.reloadData()
        } else if plantType != "Please select" || soilType != "Please select" {
            searchedCrop = []
            if soilType != "Please select" && plantType != "Please select" {
                searchedCrop = filterSoilAndPlantType(plantType: plantType, soilType: soilType)
                searching = true
                soilFilter = soilType
                plantFilter = plantType
                
                if searchedCrop.count == 0 {
                    searchedCrop = filterCellsBySoilType(term: soilType)
                    searching = true
                    soilFilter = soilType
                    
                    
                }
            }else{
                if soilType != "Please select" {
                    searchedCrop = filterCellsBySoilType(term: soilType)
                    searching = true
                    soilFilter = soilType
                    
                }
                if plantType != "Please select" {
                    searchedCrop.append(contentsOf: filterCellsByPlantType(term: plantType))
                    searching = true
                    plantFilter = plantType
                    
                }
            }
            
            tableView.reloadData()
        }
        
        
    }
}
