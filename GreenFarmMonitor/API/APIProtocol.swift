//
//  APIProtocol.swift
//  GreenFarmMonitor
//
//  Created by Hanlin Shen on 13/5/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import Foundation
protocol APIProtocol: AnyObject {
    func apiCall() -> [Weather]
}