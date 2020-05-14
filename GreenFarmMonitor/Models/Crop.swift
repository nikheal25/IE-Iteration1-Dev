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
    var frostTol: String
    var minSoilpH: String
    var maxSoilpH: String
    
    var Description: String
    var AvMoisture_Percent: String
    var AvN_Percent: String
    var AvP_Percent: String
    var Days_to_maturity: String
    var Height_Ranges: String
    var Light_Needs: String
    var N_P_K_Req: String
    var Plant_Type: String
    var Soil_Additional: String
    var Water_Needs: String
    var Soil_Type: String
    var Spread_Ranges: String
    
    var minTemp:String
    var maxTemp:String
    //compatible
    var Compatible_plant: String
    var All_Compatible_plants: String
    //Fertilizer
    var Fertilizer_recommendation: String
    
    
    internal init(cropId: String, cropName: String, cropImage: String, frostTol: String, minSoilpH: String, maxSoilpH: String, Description: String, AvMoisture_Percent: String, AvN_Percent: String, AvP_Percent: String, Days_to_maturity: String, Height_Ranges: String, Light_Needs: String, N_P_K_Req: String, Plant_Type: String, Soil_Additional: String, Water_Needs: String, Soil_Type: String, Spread_Ranges: String, Compatible_plant: String, All_Compatible_plants: String, maxTemp: String, minTemp: String, Fertilizer_recommendation: String) {
        self.cropId = cropId
        self.cropName = cropName
        self.cropImage = cropImage
        self.frostTol = frostTol
        self.minSoilpH = minSoilpH
        self.maxSoilpH = maxSoilpH
        self.Description = Description
        self.AvMoisture_Percent = AvMoisture_Percent
        self.AvN_Percent = AvN_Percent
        self.AvP_Percent = AvP_Percent
        self.Days_to_maturity = Days_to_maturity
        self.Height_Ranges = Height_Ranges
        self.Light_Needs = Light_Needs
        self.N_P_K_Req = N_P_K_Req
        self.Plant_Type = Plant_Type
        self.Soil_Additional = Soil_Additional
        self.Water_Needs = Water_Needs
        self.Soil_Type = Soil_Type
        self.Spread_Ranges = Spread_Ranges
        self.Compatible_plant = Compatible_plant
        self.All_Compatible_plants = All_Compatible_plants
        self.maxTemp = maxTemp
        self.minTemp = minTemp
        self.Fertilizer_recommendation = Fertilizer_recommendation
    }
}
