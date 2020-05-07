//
//  ChangeUserLocationViewController.swift
//  GreenFarmMonitor
//
//  Created by Hanlin Shen on 15/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import UIKit
import MapKit
import CoreLocation
class ChangeUserLocationViewController: UIViewController {
    

    var LocationList = [LocationAnnotation]()
    
    weak var userDefaultController: UserdefaultsProtocol?
    
    weak var databaseController: DatabaseProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
     userDefaultController = appDelegate.userDefaultController
        databaseController = appDelegate.databaseController
         let currentUserId = userDefaultController?.retrieveUserId()
        let userList = databaseController?.userList
        for user in userList!
        {
            if user.userId == "20-05-07-18:12:17x5bxy"{
            let lat = Double(user.farmLat)
            let long = Double(user.farmLong)
           
            LocationList.append(LocationAnnotation(newTitle: user.farmLocationName, lat: lat!, long: long!))
            }
        }
//        let location = LocationAnnotation(newTitle: "My farm", lat: -37.877623, long: 145.1362)
        if LocationList.first?.coordinate == nil
        {
            locationText.placeholder = "Add your farm here"
            UIBtn.setTitle("Add", for:.normal)
        }
        else
        {
            locationText.placeholder = "Change your farm here"
             UIBtn.setTitle("Change", for:.normal)
        }
        mapView.addAnnotations(LocationList)
        focusOn(annotation: LocationList.first!)
       
        // Do any additional setup after loading the view.
    }
    
    func focusOn(annotation:MKAnnotation){
        //mapView.selectedAnnotations(annotation,animated:true)
        let zoomRegion =  MKCoordinateRegion(center: annotation.coordinate,latitudinalMeters:1000,longitudinalMeters: 1000)
        mapView.setRegion(mapView.regionThatFits(zoomRegion), animated:true)
    }

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */
    
    @IBOutlet weak var UIBtn: UIButton!
    @IBOutlet weak var locationText: UITextField!
    
    @IBAction func ChangeBtn(_ sender: Any) {
        let address = locationText.text
        if address!.isEmpty
        {}
        else
        {
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address!)
        {placemarks,error in
            let placemarks = placemarks?.first
            let location = LocationAnnotation(newTitle: "New farm", lat: (placemarks?.location?.coordinate.latitude)!, long: (placemarks?.location?.coordinate.longitude)!)
            let lat = String(location.coordinate.latitude)
            let long = String(location.coordinate.longitude)
            self.databaseController!.updateLocation(userId:"20-04-16-15:00:22tqAOd", lat: lat ,locationName: "New farm", long: long)
            self.mapView.removeAnnotations(self.mapView.annotations)
            
            self.mapView.addAnnotation(location)
            self.focusOn(annotation:location)
            
                }
        }
     
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
}
