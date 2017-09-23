//
//  CarAnnotation.swift
//  SixtTest
//
//  Created by prafull kumar on 23/09/17.
//  Copyright © 2017 Prafulla. All rights reserved.
//

import UIKit
import MapKit

class CarAnnotation: NSObject, MKAnnotation {
    var coordinate: CLLocationCoordinate2D
    
    var title: String?
    var subtitle: String?
    
    var data : BaseModel
    init(dataModel : BaseModel) {
        data = dataModel
        title = data.name ?? "Car"
        subtitle = data.modelName ?? "Unknown"
        self.coordinate = CLLocationCoordinate2D.init(latitude: CLLocationDegrees(data.latitude ?? 0.0), longitude: CLLocationDegrees(data.longitude ?? 0.0))
    }
    
    
}
