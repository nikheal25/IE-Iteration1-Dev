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
    var precipProb: Double
    init(maxtemp: Double, mintemp: Double, date: String, precip: Double, precipProb: Double) {
        self.maxtemp = maxtemp
        self.mintemp = mintemp
        self.date = date
        self.precip = precip
        self.precipProb = precipProb
    }
}
