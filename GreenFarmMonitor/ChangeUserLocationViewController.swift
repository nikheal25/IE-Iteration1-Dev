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
class ChangeUserLocationViewController: UIViewController,DatabaseListener,MKMapViewDelegate,UITextFieldDelegate{
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
                    self.locationText.placeholder = "Add your farm here"
                    self.UIBtn.setTitle("Add", for:.normal)
                  
                }
                else
                {
                    self.locationText.placeholder = "Change your farm here"
                    self.UIBtn.setTitle("Change", for:.normal)
//                    self.locationText.placeholder = "Add your farm here"
//                    self.UIBtn.setTitle("Add", for:.normal)
                    self.mapView.addAnnotations(LocationList)
                    self.focusOn(annotation: LocationList.first!)
                    
                             }
        
    }
    
    override func viewWillAppear(_ animated: Bool) {
        super.viewWillAppear(animated)
        databaseController?.addListener(listener: self)
    }
    override func viewWillDisappear(_ animated: Bool) {
        super.viewWillDisappear(animated)
        databaseController?.removeListener(listener: self)
    }
   
    
  
    

    var LocationList = [LocationAnnotation]()
    
    weak var userDefaultController: UserdefaultsProtocol?
    
    weak var databaseController: DatabaseProtocol?
    override func viewDidLoad() {
        super.viewDidLoad()
//        "20-05-07-18:12:17x5bxy"
//        self.view.backgroundColor = UIColor(hexString: "#9bb666")
        let appDelegate = UIApplication.shared.delegate as! AppDelegate
     userDefaultController = appDelegate.userDefaultController
        databaseController = appDelegate.databaseController
     let currentUserId = userDefaultController?.retrieveUserId()
     let userList = databaseController?.userList
        self.mapView.delegate = self
        self.UIBtn.layer.cornerRadius = 8.0
        self.UIBtn.layer.borderWidth = 1.0
        self.UIBtn.layer.borderColor = UIColor.blue.cgColor
        self.continueUIBtn.layer.cornerRadius = 8.0
        self.continueUIBtn.layer.borderWidth = 1.0
        self.continueUIBtn.layer.borderColor = UIColor.blue.cgColor
        self.locationText.delegate = self
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
    
    @IBAction func ChangeBtn(_ sender: Any) {
        let address = self.locationText.text
        if address!.isEmpty
        {
           self.locationText.endEditing(true)
            displayMessage(title: "Empty", message: "Invalid values!")
            
        }
        else
        {
        let currentUserId = userDefaultController?.retrieveUserId()
        let geoCoder = CLGeocoder()
        geoCoder.geocodeAddressString(address!)
        {(placemarks,error) in
            guard
            let placemarks = placemarks?.first
            else
            {
                self.displayMessage(title: "Invalid Location!", message: "Please enter an valid location!")
                return}
            let location = LocationAnnotation(newTitle: "New farm", lat: (placemarks.location?.coordinate.latitude)!, long: (placemarks.location?.coordinate.longitude)!)
            let lat = String(location.coordinate.latitude)
            let long = String(location.coordinate.longitude)
            
            
            if self.LocationList.count == 0
            {
                let newUserId = self.userDefaultController?.generateUniqueUserId()
                let newUser = User(userId: newUserId!, userName: "TestUser", farmLocationName: "New farm", farmLat: lat, farmLong: long)
                     
                     // Firebase Update
                let successStatus = self.databaseController?.insertNewUserToFirebase(user: newUser)
                     if successStatus! {
                        self.userDefaultController?.assignName(name: newUser.userName)
                        self.displayMessage(title: "Add to database", message: "Successfully!")
                }
                
                
            }else{
            self.databaseController!.updateLocation(userId:currentUserId!, lat: lat ,locationName: "New farm", long: long)
            self.mapView.removeAnnotations(self.mapView.annotations)
            self.displayMessage(title: "Change database", message: "Successfully!")
            
//            self.mapView.addAnnotation(location)
//            self.focusOn(annotation:location)
            }
                }
        }
        
     
    }
  
    @IBOutlet weak var mapView: MKMapView!
    
  
    @IBAction func continueBtn(_ sender: Any) {
        displayContinueMessage(title: "Continue", message: "Do you ensure current location?")
        
        
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
        
        address.reverseGeocodeLocation(CLLocation.init(latitude: lat, longitude:long)) { (placemarks, error) in
            if error == nil{

            }
            let pm = placemarks! as [CLPlacemark]

            if pm.count > 0 {
                let pm = placemarks![0]
//                print(pm.country)
//                print(pm.locality)
//                print(pm.subLocality)
//                print(pm.thoroughfare)
//                print(pm.postalCode)
//                print(pm.subThoroughfare)
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
                if pm.country != nil {
                    addressString = addressString + pm.country! 
                }
              
                self.locationText.text = addressString
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
    func displayContinueMessage(title:String, message:String)
    {
        let alertController = UIAlertController(title: title, message: message, preferredStyle: UIAlertController.Style.alert)
        alertController.addAction(UIAlertAction(title: "Yes", style:UIAlertAction.Style.default)
        {
            (UIAlertAction) -> Void in
            self.performSegue(withIdentifier: "continueSegue", sender: self)
        } )
        alertController.addAction(UIAlertAction(title: "No", style:UIAlertAction.Style.default , handler:nil) )
        self.present(alertController,animated: true,completion: nil)
        
    }
}
