//
//  Crop.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 13/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import Foundation

class Crop: NSObject {
    var cropId: String
    var cropName: String
    var cropImage: String
    
    init(cropId: String, cropName: String, cropImage: String) {
        self.cropId = cropId
        self.cropName = cropName
        self.cropImage = cropImage
    }
}
