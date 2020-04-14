//
//  DatabaseProtocol.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 14/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import Foundation

enum DatabaseChange {
    case add
    case remove
    case update
}
enum ListenerType {
    case Crops
    case DiseaseOfCrops
    case all
}
protocol DatabaseListener: AnyObject {
    var listenerType: ListenerType {get set}
    func onRDiseaseOfCrops(change: DiseaseOfCrops, diseaseOfCrops: [DiseaseOfCrops])
    func onCropsChange(change: DatabaseChange, crops: [Crop])
}
protocol DatabaseProtocol: AnyObject {
    var cropsList: [Crop] {get}
    func addCrop(crop: Crop) -> Crop
  //  func checkLogin(userName: String, password: String) -> User?
    func addListener(listener: DatabaseListener)
    func removeListener(listener: DatabaseListener)
}
