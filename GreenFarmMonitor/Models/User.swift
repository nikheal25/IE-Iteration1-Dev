//
//  User.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 15/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import Foundation

/// Model for the user
class User: NSObject {
    var userId: String
    var userName: String
    var farmLocationName: String
    var farmLat: String
    var farmLong: String
    
    init(userId: String, userName: String, farmLocationName: String, farmLat: String, farmLong: String) {
        self.userId = userId
        self.userName = userName
        self.farmLocationName = farmLocationName
        self.farmLat = farmLat
        self.farmLong = farmLong
    }
}
