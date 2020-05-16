//
//  weather.swift
//  GreenFarmMonitor
//
//  Created by Hanlin Shen on 13/5/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import Foundation
class Weather: NSObject {
    var maxtemp: Double
    var mintemp: Double
    var date: String
    var precip: Double
    var lat: String
    var long: String
    init(maxtemp: Double, mintemp: Double, date: String, precip: Double, lat: String, long: String) {
        self.maxtemp = maxtemp
        self.mintemp = mintemp
        self.date = date
        self.precip = precip
        self.lat = lat
        self.long = long
    }
}
