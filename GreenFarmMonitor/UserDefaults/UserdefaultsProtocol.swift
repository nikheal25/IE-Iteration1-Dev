//
//  UserdefaultsProtocol.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 8/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import Foundation

protocol UserdefaultsProtocol: AnyObject {
    func generateUniqueUserId() -> String
    func assignUserId(userId: String)
    func assignName(name: String)
    func assignCLLocation(lat: String, long: String)
    func retrieveName() -> String
    func retrieveUserId() -> String
}
