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

    var crop:String
    var name:String
    
    var descriptionOfSymptom: String

    
     init( name:String, crop:String,descriptionOfSymptom:String) {
           self.name = name

           self.crop = crop
            self.descriptionOfSymptom = descriptionOfSymptom


       }
}
