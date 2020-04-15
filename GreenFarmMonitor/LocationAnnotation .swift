//
//  LocationAnnotation .swift
//  GreenFarmMonitor
//
//  Created by Hanlin Shen on 15/4/20.
//  Copyright © 2020 Nikhil Gholap. All rights reserved.
//

import Foundation
import UIKit
import MapKit
class LocationAnnotation:NSObject,MKAnnotation{
    var coordinate: CLLocationCoordinate2D
    var title: String?
    init(newTitle:String,lat:Double, long:Double) {
        self.title = newTitle
        coordinate = CLLocationCoordinate2D(latitude: lat, longitude: long)
    }
    
}
