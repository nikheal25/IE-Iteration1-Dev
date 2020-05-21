//
//  UserCropRelation.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 15/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import Foundation

/// Model for relationship between User and Crops
class UserCropRelation: NSObject {
    var relationId: String
    var userId: String
    var cropId: String
    
    init(relationId:String, userId: String, cropId: String) {
        self.relationId = relationId
        self.userId = userId
        self.cropId = cropId
    }
}
