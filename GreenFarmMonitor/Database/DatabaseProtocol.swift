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
    case Crop
    case all
}
protocol DatabaseListener: AnyObject {
    var listenerType: ListenerType {get set}
   
    func onAlertChange(change: DatabaseChange, alert: [Crop])
}
protocol DatabaseProtocol: AnyObject {
    
    var cropList: [Crop] {get}
  
//    func addUser(user: User) -> User
    func addCrop(crop: Crop) -> Crop
 
    //func checkLogin(userName: String, password: String) -> User?
    func addListener(listener: DatabaseListener)
    func removeListener(listener: DatabaseListener)
    
}
