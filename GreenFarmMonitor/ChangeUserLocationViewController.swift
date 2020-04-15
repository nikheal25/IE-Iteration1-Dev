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
  
    
    override func viewDidLoad() {
        super.viewDidLoad()
        let location = LocationAnnotation(newTitle: "My farm", lat: -37.877623, long: 145.1362)
        mapView.addAnnotation(location)
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
    
    @IBOutlet weak var locationText: UITextField!
    
    @IBAction func ChangeBtn(_ sender: Any) {
        let address = locationText.text
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address!)
        {placemarks,error in
            let placemarks = placemarks?.first
            let location = LocationAnnotation(newTitle: "New farm", lat: (placemarks?.location?.coordinate.latitude)!, long: (placemarks?.location?.coordinate.longitude)!)
            self.mapView.addAnnotation(location)
            
                }
     
    }
    
    @IBOutlet weak var mapView: MKMapView!
    
}
