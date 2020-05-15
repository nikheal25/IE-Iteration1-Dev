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
    
    var specificCrop: Crop?
    // MARK: Sort and Filter
    var sortingSchema: Int?
    var plantFilter: String?
    var soilFilter: String?
    
    var listenerType: ListenerType = ListenerType.all // listener
    weak var databaseController: DatabaseProtocol?
    weak var userDefaultController: UserdefaultsProtocol?
    
    var allCropsName: [Crop] = []
    var registeredCrop: [String]?
    
    var searchedCrop = [Crop]()
    var recomenededCropsName = [Crop]()
    var searching = false
    
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
        recommendedCrops = (api?.apiRecommendedCrop(lat: "182", long: "154"))!
        
    }
    
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
    
    func recommendedCrop() -> [Crop] {
      var tempCrops: [Crop] = []
        
        for crop in allCropsName {
            if recommendedCrops.contains(crop.cropName) {
                tempCrops.append(crop)
            }
        }
        return tempCrops
    }
    
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
    
    func filterCells(term: String) -> [Crop] {
        var tempCrops: [Crop] = []
        
        for crop in allCropsName {
            if crop.cropName.lowercased().prefix(term.count) == term.lowercased() {
                tempCrops.append(crop)
            }
        }
        return tempCrops
    }
    
    func filterCellsByPlantType(term: String) -> [Crop] {
        var tempCrops: [Crop] = []
        
        for crop in allCropsName {
            if crop.Plant_Type.lowercased().prefix(term.count) == term.lowercased() {
                tempCrops.append(crop)
            }
        }
        return tempCrops
    }
    
    func filterCellsBySoilType(term: String) -> [Crop] {
        var tempCrops: [Crop] = []
        
        for crop in allCropsName {
            if crop.Soil_Type.lowercased().prefix(term.count) == term.lowercased() {
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

extension FoldingTableViewController: SelectionDelegate{
    
    func didAddCrop() {
        _ = navigationController?.popToRootViewController(animated: true)
    }
}
extension FoldingTableViewController: filterDelgate {
    func sortOption(id: Int) {
        print("Inside folding cell \(id)")
        sortingSchema = id
        sortCrops()
        tableView.reloadData()
        if sortingSchema == 2 {
            showSwiftMessage(title: "Sorted Alphabetically", message: "You can always change this!", iconIndex: 3)
        } else {
            showSwiftMessage(title: "Recommended First", message: "Ordered in recommended manner!", iconIndex: 2)
        }
        
    }
    
    func filterOption(plantType: String, soilType: String) {
        print(plantType)
        if plantType != "Please select" || soilType != "Please select" {
            searchedCrop = []
            if soilType != "Please select" {
                searchedCrop = filterCellsBySoilType(term: soilType)
                searching = true
                soilFilter = soilType
                
            }
            if plantType != "Please select" {
                //                searchedCrop = filterCellsByPlantType(term: plantType)
                searchedCrop.append(contentsOf: filterCellsByPlantType(term: plantType))
                searching = true
                plantFilter = plantType
                
            }
            tableView.reloadData()
        }
        
        
    }
}
