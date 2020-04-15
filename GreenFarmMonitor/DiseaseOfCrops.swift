//
//  DiseaseOfCrops.swift
//  GreenFarmMonitor
//
//  Created by Hanlin Shen on 13/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import Foundation

class DiseaseOfCrops:NSObject
{
    var id:String
    var crop:String
    var name:String
    var image:String
    var descriptionOfSymptom: String
    
    init(id:String, name:String, image:String,crop:String,descriptionOfSymptom:String) {
        self.id = id
        self.name = name
        self.image = image
        self.crop = crop
        self.descriptionOfSymptom = descriptionOfSymptom
        
    }
    
}
