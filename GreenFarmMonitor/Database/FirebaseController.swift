//
//  FirebaseController.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 14/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class FirebaseController: NSObject, DatabaseProtocol {
    var cropList: [Crop] = []
    
    override init() {
        cropList = [Crop] ()
    }
    
    func addCrop(crop: Crop) -> Crop {
        return Crop(cropId: "dev", cropName: "dev", cropImage: "test")
    }
    
    func addListener(listener: DatabaseListener) {
        
    }
    
    func removeListener(listener: DatabaseListener) {
        
    }
    
}
