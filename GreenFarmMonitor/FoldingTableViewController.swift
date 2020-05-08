//
//  FoldingTableViewController.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 18/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit
import FoldingCell

class FoldingTableViewController: UITableViewController, UIPopoverPresentationControllerDelegate {
    
    var specificCrop: Crop?
    
    var listenerType: ListenerType = ListenerType.all // listener
    weak var databaseController: DatabaseProtocol?
    weak var userDefaultController: UserdefaultsProtocol?
    
    var allCropsName: [Crop] = []
    var registeredCrop: [String]?
    
    var searchedCrop = [Crop]()
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
    
    var cellHeights: [CGFloat] = []
    
    // MARK: Life Cycle
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
        userDefaultController = appDelegate.userDefaultController
        databaseController = appDelegate.databaseController
        
        self.title = "All Crops"
        
        tableView.tableFooterView = UIView()
        allCropsName = getRelevantCrops()
        searchBar.delegate = self
        // Do any additional setup after
        
        setup()
        
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
    
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        if segue.identifier == "showPopOverSegue" {
            let popoverViewController = segue.destination
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
            
            cell.setUp(crop: searchedCrop[indexPath.row])
            cell.selectionDelegate = self
            
        } else {
            
            cell.durationsForExpandedState = durations
            cell.durationsForCollapsedState = durations
            
            cell.setUp(crop: allCropsName[indexPath.row])
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
            
            // fix https://github.com/Ramotion/folding-cell/issues/169
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
