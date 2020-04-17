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
//    var minSoilTemp: String
//    var maxTemp: String
//    var optimumTemp: String
//    var frostTol: String
//    var spacingPlantInRow: String
//    var spacingRow: String
//    var plantingDepth: String
//    var nutrients: String
//    var organicFertilises: String
//       
    
    init(cropId: String, cropName: String, cropImage: String) {
        self.cropId = cropId
        self.cropName = cropName
        self.cropImage = cropImage
    }
//    internal init(cropId: String, cropName: String, cropImage: String, minSoilTemp: String, maxTemp: String, optimumTemp: String, frostTol: String, spacingPlantInRow: String, spacingRow: String, plantingDepth: String, nutrients: String, organicFertilises: String) {
//         self.cropId = cropId
//         self.cropName = cropName
//         self.cropImage = cropImage
//         self.minSoilTemp = minSoilTemp
//         self.maxTemp = maxTemp
//         self.optimumTemp = optimumTemp
//         self.frostTol = frostTol
//         self.spacingPlantInRow = spacingPlantInRow
//         self.spacingRow = spacingRow
//         self.plantingDepth = plantingDepth
//         self.nutrients = nutrients
//         self.organicFertilises = organicFertilises
//     }
     
}
