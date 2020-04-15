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
    case UserCropRelation
    case all
}
protocol DatabaseListener: AnyObject {
    var listenerType: ListenerType {get set}
    func onRDiseaseOfCrops(change: DiseaseOfCrops, diseaseOfCrops: [DiseaseOfCrops])
    func onCropsChange(change: DatabaseChange, crops: [Crop])
    func onUserCropRelationChange(change: DatabaseChange, userCropRelation: [UserCropRelation])
}
protocol DatabaseProtocol: AnyObject {
    var cropsList: [Crop] {get}
    var userCropRelation: [UserCropRelation] {get}
//    func addCrop(crop: Crop) -> Crop
  //  func checkLogin(userName: String, password: String) -> User?
    func addUserCropRelation(userCropRelation: UserCropRelation) -> UserCropRelation
    func addListener(listener: DatabaseListener)
    func removeListener(listener: DatabaseListener)
}
