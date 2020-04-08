//
//  UserdefaultsProtocol.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 8/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import Foundation

protocol UserdefaultsProtocol {
    func generateUniqueUserId() -> String
    func retrieveUserId() -> String
}
