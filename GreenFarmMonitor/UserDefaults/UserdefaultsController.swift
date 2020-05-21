//
//  UserdefaultsController.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 8/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit

/// This controller takes care of all the Userdefaults
class UserdefaultsController: NSObject, UserdefaultsProtocol {
    let defaults = UserDefaults.standard
    
    override init() {
        super.init()
    }
    
    //gererates the random unique string that'll be used as a userId
    func generateUniqueUserId() -> String {
        let date = Date()
        let format = DateFormatter()
        format.dateFormat = "yy-MM-dd-HH:mm:ss"
        let formattedDate = format.string(from: date)
        let random = randomString(length: 5)
        assignUserId(userId: (formattedDate+random))
        return (formattedDate+random)
    }
    
    //Assign the userId
    func assignUserId(userId: String) {
        defaults.set(userId, forKey: "userUniqueIdKey")
    }
    
    //generates the random string of the length that is passed to it
    func randomString(length: Int) -> String {
        let letters = "abcdefghijklmnopqrstuvwxyzABCDEFGHIJKLMNOPQRSTUVWXYZ0123456789"
        return String((0..<length).map{ _ in letters.randomElement()! })
    }
    
    func retrieveUserId() -> String {
        var id: String = ""
        if let tempId = defaults.string(forKey: "userUniqueIdKey") {
            id = tempId
        }
        return id
    }
    
    //Assigns the userNameKey value for user's name
    func assignName(name: String) {
        defaults.set(name, forKey: "userNameKey")
    }
    
    //returns the user name from userDefaults
    func retrieveName() -> String {
        var name: String = ""
        if let tempName = defaults.string(forKey: "userNameKey") {
            
            name = tempName
        }
        return name
    }
    
    func retriveLat() -> String
    {
        var lat: String = ""
        if let userlat = defaults.string(forKey: "userLatKey") {
            lat = userlat
            
        }
        return lat
        
        
    }
    
    func retriveLong() -> String
    {
        var long: String = ""
        if let userlong = defaults.string(forKey: "userLongKey") {
            long = userlong
            
        }
        return long
        
        
    }
    
    func assignCLLocation(lat: String, long: String) {
        defaults.set(lat, forKey: "userLatKey")
        defaults.set(long, forKey: "userLongKey")
    }
    
}
