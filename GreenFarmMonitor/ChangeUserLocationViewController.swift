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
                    self.searchBar.placeholder = "Enter suburb or pincode of garden location"
                    self.UIBtn.setTitle("Add", for:.normal)
                  
                }
                else
                {
                    mapView.removeAnnotations(mapView.annotations)
                    self.searchBar.placeholder = "Enter suburb or pincode of garden location"
                    self.UIBtn.setTitle("Change", for:.normal)
//                    self.locationText.placeholder = "Add your farm here"
//                    self.UIBtn.setTitle("Add", for:.normal)
                    self.mapView.addAnnotations(LocationList)
                    self.focusOn(annotation: LocationList.first!)
                   
                    
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
   
    
   var searchSource: [String] = []
    var australiaSource: [String] = []

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
//        self.locationText.addTarget(self, action: #selector(self.textFieldDidChange(sender:)), for: UIControl.Event.editingChanged)
//        self.locationText.delegate = self
        
        self.searchList.layer.cornerRadius = 8.0
        self.searchList.dataSource = self
        self.searchList.delegate = self
        self.searchList.isHidden = true
        //zoom to australia
        let Australia = CLLocation(latitude: -25.2744, longitude: 133.7751)
        let zoomRegion = MKCoordinateRegion(center: Australia.coordinate, latitudinalMeters: 3000000,longitudinalMeters: 4000000)
        mapView.setRegion(zoomRegion, animated: true)
        newUserId = (self.userDefaultController?.generateUniqueUserId())!
       
        self.searchCompleter.delegate = self
        self.searchCompleter.region = mapView.region
self.searchBar[keyPath:\.searchTextField].font = UIFont(name: "SFProText-Regular", size: 12.0) ?? UIFont.boldSystemFont(ofSize: 12.0)
        self.searchBar.delegate = self
       
    
   
        
        
    
    }
   var searchCompleter = MKLocalSearchCompleter()

   var searchResults = [MKLocalSearchCompletion]()
    
    
    @IBOutlet weak var searchBar: UISearchBar!
    
    
    
//    @objc func textFieldDidChange(sender:UITextField)
//    {   australiaMarks = []
//        let address = self.locationText.text
//        let geoCoder = CLGeocoder()
//        geoCoder.geocodeAddressString(address!)
//        {(placemarks,error) in
//            guard
//
//                let markList = placemarks
//           else
//            {
//                self.searchList.isHidden = true
//                return
//               }
//
//            for mark in markList
//            {
//                if mark.country == "Australia"
//                {
//                        self.australiaMarks.append(mark)
//
//                }
//
//
//            }
//            print(self.australiaMarks.count)
//            if self.australiaMarks.count != 0{
//             self.searchList.reloadData()
//                self.searchList.isHidden = false
//
//            }
//            else {
//                self.searchList.isHidden = true
//
//            }
//        }
//       }
//
//    func textFieldShouldClear(_ textField: UITextField) -> Bool {
//
//
//        self.searchList.isHidden = true
//       self.locationText.endEditing(true)
//       return true
//    }
   
    
    
    
    
    
      
    
    @IBOutlet weak var searchList: UITableView!
    func focusOn(annotation:MKAnnotation){
        //mapView.selectedAnnotations(annotation,animated:true)
        let zoomRegion =  MKCoordinateRegion(center: annotation.coordinate,latitudinalMeters:2000,longitudinalMeters: 2000)
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
    var resultList = [String]()
    @IBOutlet weak var UIBtn: UIButton!
   
    var australiaMarks = [CLPlacemark]()
    @IBAction func ChangeBtn(_ sender: Any) {
        searchList.isHidden = true
        let address = self.searchBar.text
        if address!.isEmpty
        {
           self.searchBar.endEditing(true)
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
                                
                                let addressString = self.convertToString(location: pm)
                              
                                
                                self.searchBar.text = addressString
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
            self.searchBar.endEditing(true)
            
            
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
extension ChangeUserLocationViewController: UITableViewDelegate, UITableViewDataSource
{
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return australiaSource.count ?? 0
        }

        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            //I've created SearchCell beforehand; it might be your cell type
            let cell = searchList.dequeueReusableCell(withIdentifier: "relevantLocations", for: indexPath) as! relevantLocationsTableViewCell

            cell.searchResult.text = self.australiaSource[indexPath.row]
   

            return cell
        }
    
    
    
    
     
    
    

    func convertToString (location: CLPlacemark) -> String
    {
        var addressString : String = ""
        
        if location.subThoroughfare != nil {
                                            addressString = addressString + location.subThoroughfare! + ", "
                                                      }
        if location.subLocality != nil {
                                           addressString = addressString + location.subLocality! + ", "
                                       }
        if location.thoroughfare != nil {
                                           addressString = addressString + location.thoroughfare! + ", "
                                       }
                                      
        if location.locality != nil {
                                           addressString = addressString + location.locality! + ", "
                                       }
        if location.postalCode != nil {
                                           addressString = addressString + location.postalCode! + ", "
                                       }
        if location.country != nil {
                                           addressString = addressString + location.country!
                                       }
        return addressString
        
        
    }
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {

       

        let selectedLocation = australiaSource[indexPath.row]
        
        self.searchBar.text = selectedLocation
        self.searchBar.endEditing(true)
            
    
        searchList.isHidden = true
        }

    
    
//    func tableView(_ tableView: UITableView, willDisplay cell: UITableViewCell, forRowAt indexPath: IndexPath) {
//
//        self.searchList.heightAnchor.constraint(equalToConstant: searchList.contentSize.height).isActive = true
//
//    }
    
    
    
}
//search
extension ChangeUserLocationViewController: MKLocalSearchCompleterDelegate {
    func completerDidUpdateResults(_ completer: MKLocalSearchCompleter) {
        //get result, transform it to our needs and fill our dataSource
        
        self.searchSource = completer.results.map { $0.title + ", " + $0.subtitle }
        self.australiaSource = searchSource.filter{ $0.contains("Australia")}
        DispatchQueue.main.async {
            self.searchList.reloadData()
        }
    }

    func completer(_ completer: MKLocalSearchCompleter, didFailWithError error: Error) {
        //handle the error
        print(error.localizedDescription)
    }
}

extension ChangeUserLocationViewController: UISearchBarDelegate {
    func searchBar(_ searchBar: UISearchBar, textDidChange searchText: String) {
        //change searchCompleter depends on searchBar's text
        if !searchText.isEmpty {
            self.searchList.isHidden = false
            searchCompleter.queryFragment = searchText
        }else{
            self.searchList.isHidden = true
            
        }
    }
    
}
