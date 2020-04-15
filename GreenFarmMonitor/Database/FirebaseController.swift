//
//  FirebaseController.swift
//  GreenFarmMonitor
//
//  Created by Nikhil Gholap on 14/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit
import Firebase
import FirebaseAuth
import FirebaseFirestore

class FirebaseController: NSObject, DatabaseProtocol {
    
    var listeners = MulticastDelegate<DatabaseListener>()
       var authController: Auth
       var database: Firestore
    
    var cropRef: CollectionReference?
    var userCropRelationRef: CollectionReference?
    var diseaseRef:CollectionReference?
    
    var diseaseList:[DiseaseOfCrops]
    var cropsList: [Crop] = []
    var userCropRelation: [UserCropRelation] = []
    var myCropList: [Crop] = []
    
  
    func addUserCropRelation(userCropRelation: UserCropRelation) -> UserCropRelation {
        // TODO
        let id = userCropRelationRef?.addDocument(data: ["cropId":userCropRelation.cropId, "userId":userCropRelation.userId])
        userCropRelation.relationId = id!.documentID
        return userCropRelation
    }
    
    func addListener(listener: DatabaseListener) {
        listeners.addDelegate(listener)
        if listener.listenerType == ListenerType.Crops || listener.listenerType == ListenerType.all {
            listener.onCropsChange(change: .update, crops: cropsList)
        }
        if listener.listenerType == ListenerType.UserCropRelation || listener.listenerType == ListenerType.all {
            listener.onUserCropRelationChange(change: .update, userCropRelation: userCropRelation)
        }
        if listener.listenerType == ListenerType.Disease || listener.listenerType == ListenerType.all {
            listener.onDiseaseOfCropsChange(change: .update, diseaseOfCrops: diseaseList)
        }
    }
    
    func removeListener(listener: DatabaseListener) {
        
    }
    
    override init() {
    // Configure method to establish a connection with Firebase
    FirebaseApp.configure()
    // Calling the autController to access Firebase collections
    authController = Auth.auth()
    database = Firestore.firestore()

    cropsList = [Crop]()
    userCropRelation = [UserCropRelation]()
    diseaseList = [DiseaseOfCrops]()
        super.init()
              
              // This will START THE PROCESS of signing in with an anonymous account
              // The closure will not execute until its recieved a message back which can be any time later
              authController.signInAnonymously() { (authResult, error) in
                  guard authResult != nil else {
                      fatalError("Firebase authentication failed")
                  }
                  // Attaching the listeners to the firebase firestore
                  self.setUpListeners()
              }
        
    }
    
    //This method setting up the listeners of Temperature, RGB and Whether_Recommendation
    func setUpListeners() {
        
    
        //Crop
        cropRef = database.collection("Crops")
        cropRef?.order(by: "date", descending: false)
        cropRef?.addSnapshotListener { querySnapshot, error in
            guard (querySnapshot?.documents) != nil else {
                print("Error fetching documents: \(error!)")
                return
            }
            self.parseCropSnapshot(snapshot: querySnapshot!)
        }
        
        //userCrop
        userCropRelationRef = database.collection("UserCropRelation")
        userCropRelationRef?.order(by: "date", descending: false)
        userCropRelationRef?.addSnapshotListener { querySnapshot, error in
            guard (querySnapshot?.documents) != nil else {
                print("Error fetching documents: \(error!)")
                return
            }
            self.parseUserCropRelationSnapshot(snapshot: querySnapshot!)
        }
        //Disease
        diseaseRef = database.collection("Diseases")
        diseaseRef?.addSnapshotListener { querySnapshot, error in
            guard (querySnapshot?.documents) != nil else {
                print("Error fetching documents: \(error!)")
                return
            }
            self.parseDiseaseSnapshot(snapshot: querySnapshot!)
        }

    }
    
    func stringUnwrapper(val: [String : Any], key: String) -> String {
        var finalValue = ""
        if let temp = val[key]{
            finalValue = temp as! String
        }  else {
            finalValue = "default"
        }
        return finalValue
    }
    
    //This method add all the Rule from Firebase to a list
       func parseUserCropRelationSnapshot(snapshot: QuerySnapshot) {
           snapshot.documentChanges.forEach { change in
               
                let documentRef = change.document.documentID
                let docData = change.document.data()
            
               let cropId = stringUnwrapper(val: docData, key: "cropId")
               let userId = stringUnwrapper(val: docData, key: "userId")
            
               if change.type == .added {
                   
                let newRelation = UserCropRelation(relationId: documentRef ,userId: userId, cropId: cropId)
                   userCropRelation.append(newRelation)
               }
               
               if change.type == .modified {
                //TODO
               }
               
               if change.type == .removed {
                //TODO
               }
           }
           
           listeners.invoke { (listener) in
               if listener.listenerType == ListenerType.UserCropRelation || listener.listenerType == ListenerType.all {
                listener.onUserCropRelationChange(change: .update, userCropRelation: userCropRelation)
               }
           }
       }
    
     //This method add all the Rule from Firebase to a list
           func parseCropSnapshot(snapshot: QuerySnapshot) {
               snapshot.documentChanges.forEach { change in
                   
                    let documentRef = change.document.documentID
                    let docData = change.document.data()
                
                   let cropId = stringUnwrapper(val: docData, key: "cropId")
                   let cropName = stringUnwrapper(val: docData, key: "cropName")
                   let cropImage = stringUnwrapper(val: docData, key: "cropImage")
                
                   if change.type == .added {
                       
                       let newCrop = Crop(cropId: documentRef, cropName: cropName, cropImage: cropImage)
                       
    //                   newCrop.ruleId = documentRef
                 
                       cropsList.append(newCrop)
                   }
                   
                   if change.type == .modified {
    //                   if let index = getRuleIndexByID(reference: documentRef) {
    //                       //newAlert.alertId = documentRef
    //                       ruleList[index].ruleId = documentRef
    //                       ruleList[index].iotId = cropId
    //                       ruleList[index].userId = userId
    //                       ruleList[index].severity = severity
    //                       ruleList[index].ruleName = ruleName
    //                       ruleList[index].ruleMessage = ruleMessage
    //                       ruleList[index].temperatureRule = temperature
    //                       ruleList[index].temperatureMin = temperatureMin
    //                       ruleList[index].temperatureMax = temperatureMax
    //                       ruleList[index].humidityRule = humidity
    //                       ruleList[index].humidityMin = humidityMin
    //                       ruleList[index].humidityMax = humidityMax
    //                       ruleList[index].lightRule = light
    //                       ruleList[index].lightIntensity = lightIntensity
    //                   }
                   }
                   
                   if change.type == .removed {
    //                   if let index = getCropIndexByID(reference: documentRef){
    //                       cropsList.remove(at: index)
    //                   }
                   }
               }
               
               listeners.invoke { (listener) in
                   if listener.listenerType == ListenerType.Crops || listener.listenerType == ListenerType.all {
                       listener.onCropsChange(change: .update, crops: cropsList)
                   }
               }
           }
    
    //  This method allows to get Index of the references to be updated or deleted.
    func getCropIndexByID(reference: String) -> Int? {
        for crop in cropsList {
            if(crop.cropId == reference) {
                return cropsList.firstIndex(of: crop)
            }
        }
        return nil
    }
    
   
    func parseDiseaseSnapshot(snapshot: QuerySnapshot) {
            
               snapshot.documentChanges.forEach { change in
                let documentRef = change.document.documentID
                let crop = change.document.data()["Crop"] as! String
                let name = change.document.data()["Name"] as! String
                let descriptionOfSymptom = change.document.data()["Description"] as! String
                let image = change.document.data ()["Image"]as! String
//                print(documentRef)
                if change.type == .added {
                    print("New disease: \(change.document.data())")
                let newDisease = DiseaseOfCrops(id: documentRef, name: name, image: image, crop: crop, descriptionOfSymptom: descriptionOfSymptom)
//                    newDisease.crop = crop
//                    newDisease.name = name
//                    newDisease.image = image
//                    newDisease.descriptionOfSymptom = descriptionOfSymptom
//                    newDisease.id = documentRef
                    diseaseList.append(newDisease)
                  }
                   if change.type == .modified {
                       print("Updated data: \(change.document.data())")
                      
                    let index = getDiseaseIndexByID(reference: documentRef)!
                    diseaseList[index].crop = crop
                    diseaseList[index].name = name
                    
                    diseaseList[index].descriptionOfSymptom = descriptionOfSymptom
                    diseaseList[index].id = documentRef
                   }
                  if change.type == .removed {
                    print("Removed data: \(change.document.data())")
                    
                    if let index = getDiseaseIndexByID(reference: documentRef) {
                          diseaseList.remove(at: index)
                     }
                 }
               }
              listeners.invoke { (listener) in
                  if listener.listenerType == ListenerType.Disease||listener.listenerType == ListenerType.all {
                      listener.onDiseaseOfCropsChange(change: .update, diseaseOfCrops: diseaseList)
                  }
               }
        }
    func getDiseaseIndexByID(reference: String)-> Int? {
        for data in diseaseList{
           if (data.id == reference){
                return diseaseList.firstIndex(of: data)
            }
            
        }
        return nil
    }
    
        
        
    
}
