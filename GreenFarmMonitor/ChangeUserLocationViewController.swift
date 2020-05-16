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
class ChangeUserLocationViewController: UIViewController, DatabaseListener,MKMapViewDelegate,UITextFieldDelegate{
    //database controller
    var listenerType = ListenerType.all
    
    func onDiseaseOfCropsChange(change: DatabaseChange, diseaseOfCrops: [DiseaseOfCrops]) {
        
    }
    
    func onCropsChange(change: DatabaseChange, crops: [Crop]) {
        
    }
    
    func onUserCropRelationChange(change: DatabaseChange, userCropRelation: [UserCropRelation]) {
        
    }
    
    func onUserChange(change: DatabaseChange, users: [User]) {
        LocationList = [LocationAnnotation]()
        let currentUserId = userDefaultController?.retrieveUserId()
              for user in users
                   {
                       if user.userId == currentUserId{
                       let lat = Double(user.farmLat)
                       let long = Double(user.farmLong)
              
                        self.LocationList.append(LocationAnnotation(newTitle: user.farmLocationName, lat: lat!, long: long!))
                       }
                   }
        if LocationList.first?.coordinate == nil
                {
                    self.locationText.placeholder = "Add location of garden here"
                    self.UIBtn.setTitle("Add", for:.normal)
                  
                }
                else
                {
                    mapView.removeAnnotations(mapView.annotations)
                    self.locationText.placeholder = "Enter new garden here"
                    self.UIBtn.setTitle("Change", for:.normal)
//                    self.locationText.placeholder = "Add your farm here"
//                    self.UIBtn.setTitle("Add", for:.normal)
                    self.mapView.addAnnotations(LocationList)
                    self.focusOn(annotation: LocationList.first!)
                    self.introLabel.text = "Change your location here."
                    
                             }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
//        self.navigationItem.hidesBackButton = true
//        self.navigationController!.navigationBar.isTranslucent = true
        databaseController?.addListener(listener: self)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseController?.removeListener(listener: self)
    }
   
    
  
    

    @IBOutlet weak var introLabel: UILabel!
    var LocationList = [LocationAnnotation]()
    
    weak var userDefaultController: UserdefaultsProtocol?
    
    weak var databaseController: DatabaseProtocol?
    var newUserId = ""
    override func viewDidLoad() {
        super.viewDidLoad()
//        "20-05-07-18:12:17x5bxy"
//        self.view.backgroundColor = UIColor(hexString: "#9bb666")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
     userDefaultController = appDelegate.userDefaultController
        databaseController = appDelegate.databaseController
        
        self.mapView.delegate = self
        self.UIBtn.layer.cornerRadius = 8.0
        self.UIBtn.backgroundColor = UIColor(hexString: "#616163")
        self.continueUIBtn.backgroundColor = UIColor(hexString: "#616163")
        self.continueUIBtn.layer.cornerRadius = 8.0
        
        self.locationText.delegate = self
        //zoom to australia
       
        let Australia = CLLocation(latitude: -25.2744, longitude: 133.7751)
        let zoomRegion = MKCoordinateRegion(center: Australia.coordinate, latitudinalMeters: 5000000,longitudinalMeters: 5000000)
        mapView.setRegion(zoomRegion, animated: true)
        newUserId = (self.userDefaultController?.generateUniqueUserId())!
    }
    func textFieldShouldClear(_ textField: UITextField) -> Bool {
        self.locationText.endEditing(true)
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
    @IBOutlet weak var continueUIBtn: UIButton!
    
    @IBOutlet weak var UIBtn: UIButton!
    @IBOutlet weak var locationText: UITextField!
    var australiaMarks = [CLPlacemark]()
    @IBAction func ChangeBtn(_ sender: Any) {
        
        let address = self.locationText.text
        if address!.isEmpty
        {
           self.locationText.endEditing(true)
            displayMessage(title: "Empty", message: "Invalid values!")
            
        }
        else
        {//convert to coordinate
        let currentUserId = userDefaultController?.retrieveUserId()
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address!)
        {(placemarks,error) in
            guard
            
                let markList = placemarks
           
                
            else
            {
                self.displayMessage(title: "Invalid Location!", message: "Please enter an valid location!")
                return}
            
            self.australiaMarks = []
            for mark in markList
            {
                if mark.country == "Australia"
                {
                    self.australiaMarks.append(mark)
                    
                }
                
                
            }
                      
            if self.australiaMarks.count != 0{
           
            let result = self.australiaMarks.first
                                     
                                     
                                     
            let location = LocationAnnotation(newTitle: "New farm", lat: (result?.location!.coordinate.latitude)!, long: (result?.location!.coordinate.longitude)!)
            let lat = String(location.coordinate.latitude)
            let long = String(location.coordinate.longitude)
            if self.LocationList.count == 0
            {
              
                          
                let newUser = User(userId: self.newUserId, userName: "TestUser", farmLocationName: "New farm", farmLat: lat, farmLong: long)
                     
                     // Firebase Update
                let successStatus = self.databaseController?.insertNewUserToFirebase(user: newUser)
                     if successStatus! {
                        self.userDefaultController?.assignName(name: newUser.userName)
                        self.displayMessage(title: "Location saved", message: "Successfully!")
                        self.userDefaultController?.assignCLLocation(lat: lat, long: long)
                }
                
                // to be changed
            }else{
               
                    
                    
        
               
                    self.databaseController!.updateLocation(userId:currentUserId!, lat: lat ,locationName: "New farm", long: long)
//            self.mapView.removeAnnotations(self.mapView.annotations)
                    self.displayMessage(title: "Location saved", message: "Successfully!")
                    self.userDefaultController?.assignCLLocation(lat: lat, long: long)
                
//            self.mapView.addAnnotation(location)
//            self.focusOn(annotation:location)
                    
                
                }
                
            }else
            {
                
                self.displayMessage(title: "Warning!", message: "Please enter the locations in Australia!")
                
            }
            }
    
            }
                
        
     
    }
  
    @IBOutlet weak var mapView: MKMapView!
    
  
    @IBAction func continueBtn(_ sender: Any) {
       
        if self.LocationList.count == 0
        {
            
            
            let lat:String = "-37.8136"
            let long:String = "144.9631"
            let newUser = User(userId: self.newUserId, userName: "TestUser", farmLocationName: "New farm", farmLat: lat, farmLong: long)
                               
                               // default user
                          let successStatus = self.databaseController?.insertNewUserToFirebase(user: newUser)
                               if successStatus! {
                                self.userDefaultController?.assignName(name: newUser.userName)
                                self.userDefaultController?.assignCLLocation(lat: lat, long: long)
                          }
            
            
        }
         
        
        
    }
//    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
//
//
//
//
//            let reuseId = "test"
//
//        var anView = mapView.dequeueReusableAnnotationView(withIdentifier: reuseId)
//            if anView == nil {
//                anView = MKAnnotationView(annotation: annotation, reuseIdentifier: reuseId)
//
//                anView?.canShowCallout = true
//
//
//                let imageView = UIImageView(frame: CGRect(x: 0, y: 0, width: 50, height: 50))
//                imageView.image = UIImage(named: "anthracnose.jpg")
//                imageView.layer.cornerRadius = imageView.layer.frame.size.width / 2
//                imageView.layer.masksToBounds = true
//                anView?.frame = imageView.frame
//                anView?.addSubview(imageView)
//            }
//
//
//
//                       return anView
//    }
    
    
    //Drag map
    func mapView(_ mapView: MKMapView, regionDidChangeAnimated animated: Bool) {
        if self.UIBtn.titleLabel?.text == "Change"{
        self.mapView.removeAnnotations(mapView.annotations)

           // Add new annotation
        let annotation = MKPointAnnotation()
        annotation.coordinate = mapView.centerCoordinate
        annotation.title = self.LocationList.first?.title
        self.mapView.addAnnotation(annotation)
        let lat = annotation.coordinate.latitude
        let long = annotation.coordinate.longitude
        let address = CLGeocoder.init()
        // convert to text
        address.reverseGeocodeLocation(CLLocation.init(latitude: lat, longitude:long)) { (placemarks, error) in
            if error == nil{
                  let pm = placemarks! as [CLPlacemark]

                            if pm.count > 0 {
                                let pm = placemarks![0]
                                print(pm.country)
                                print(pm.locality)
                                print(pm.subLocality)
                                print(pm.thoroughfare)
                                print(pm.postalCode)
                                print(pm.subThoroughfare)
                                
                                var addressString : String = ""
                                if pm.subThoroughfare != nil {
                                                   addressString = addressString + pm.subThoroughfare! + ", "
                                               }
                                if pm.subLocality != nil {
                                    addressString = addressString + pm.subLocality! + ", "
                                }
                                if pm.thoroughfare != nil {
                                    addressString = addressString + pm.thoroughfare! + ", "
                                }
                               
                                if pm.locality != nil {
                                    addressString = addressString + pm.locality! + ", "
                                }
                                if pm.postalCode != nil {
                                    addressString = addressString + pm.postalCode! + ", "
                                }
                                if pm.country != nil {
                                    addressString = addressString + pm.country!
                                }
                              
                                
                                self.locationText.text = addressString
            }
          
            }
            
        }
        }
    }
    
    
    
    func displayMessage(title:String,message:String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "OK", style:UIAlertAction.Style.default ){
            (UIAlertAction) -> Void in
            self.locationText.endEditing(true)
            
            
        } )
        self.present(alertController,animated: true,completion: nil)
        
    }

  

//    func displayContinueMessage(title:String, message:String)
//    {
//        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
//        alertController.addAction(UIAlertAction(title: "Yes", style:UIAlertAction.Style.default)
//        {
//            (UIAlertAction) -> Void in
//            if self.LocationList.count == 0{
//                self.displayMessage(title: "Warning!", message: "You must enter you farm location.")
//
//            }else
//            {
//                self.performSegue(withIdentifier: "continueSegue", sender: self)}
//        } )
//        alertController.addAction(UIAlertAction(title: "No", style:UIAlertAction.Style.default , handler:nil) )
//        self.present(alertController,animated: true,completion: nil)
//
//    }

}
