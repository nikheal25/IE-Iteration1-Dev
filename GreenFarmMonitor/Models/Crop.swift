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
    var minSoilTemp: String
    var maxSoilTemp: String
    var optimmumSoilTemp: String
    var frostTol: String
    var spacingPlantInRow: String
    var spacingRow: String
    var plantingDepth: String
    var nutrients: String
    var organicFertilises: String
    var minSoilpH: String
    var maxSoilpH: String
       
    
//    init(cropId: String, cropName: String, cropImage: String) {
//        self.cropId = cropId
//        self.cropName = cropName
//        self.cropImage = cropImage
//    }

     internal init(cropId: String, cropName: String, cropImage: String, minSoilTemp: String, maxSoilTemp: String, optimmumSoilTemp: String, frostTol: String, spacingPlantInRow: String, spacingRow: String, plantingDepth: String, nutrients: String, organicFertilises: String, minSoilpH: String, maxSoilpH: String) {
         self.cropId = cropId
         self.cropName = cropName
         self.cropImage = cropImage
         self.minSoilTemp = minSoilTemp
         self.maxSoilTemp = maxSoilTemp
         self.optimmumSoilTemp = optimmumSoilTemp
         self.frostTol = frostTol
         self.spacingPlantInRow = spacingPlantInRow
         self.spacingRow = spacingRow
         self.plantingDepth = plantingDepth
         self.nutrients = nutrients
         self.organicFertilises = organicFertilises
         self.minSoilpH = minSoilpH
         self.maxSoilpH = maxSoilpH
     }
}
