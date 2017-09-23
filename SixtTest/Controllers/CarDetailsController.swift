//
//  CarDetailsController.swift
//  SixtTest
//
//  Created by prafull kumar on 23/09/17.
//  Copyright © 2017 Prafulla. All rights reserved.
//

import UIKit
import MapKit
import Alamofire

class CarDetailsController: UIViewController {

    @IBOutlet weak var carImage: UIImageView!
    @IBOutlet weak var carName: UILabel!
    @IBOutlet weak var make: UILabel!
    
    @IBOutlet weak var series: UILabel!
    @IBOutlet weak var fuleType: UILabel!
    @IBOutlet weak var licence: UILabel!
    
    @IBOutlet weak var cleanNess: UILabel!
    
    @IBOutlet weak var curLocation: UILabel!
    @IBOutlet weak var fuleLabel: UILabel!
    @IBOutlet weak var modelName: UILabel!
    
    
    @IBOutlet weak var mapView: MKMapView!
    
    var dataSixt : BaseModel? = nil
    
    override func viewDidLoad() {
        super.viewDidLoad()

        //
        self.modelName.text = "Model Name: " + (dataSixt?.modelName ?? "X")
        self.carName.text = "Car Name: " + (dataSixt?.name ?? "X")
        self.make.text = "Brand: " + (dataSixt?.make ?? "X")
        
        self.series.text = "Series: " + (dataSixt?.series ?? "X")
        self.fuleType.text = "Fuel Type: " + (dataSixt?.fuelType ?? "X")
        self.fuleLabel.text = "Fuel Level: " + String(dataSixt?.fuelLevel ?? 0.0)
        
        self.licence.text = "License: " + (dataSixt?.licensePlate ?? "X")
        self.cleanNess.text = "Cleanliness: " + (dataSixt?.innerCleanliness ?? "X")
        self.curLocation.text = "Fetching Address..."
        
        self.carImage.image = #imageLiteral(resourceName: "car")
        
        if let url = URL(string: dataSixt?.imageUrlNew ?? "") {
            // handles catching and multiple api calls internally no need to add additional func
            Alamofire.request(url).responseImage(completionHandler: { [weak self] (response) in
                    if let image = response.result.value {
                        self?.carImage.image = image
                    }
            })
        }
        
        // map
        
        self.mapView.delegate = self
        
        let coordinate = CLLocationCoordinate2D.init(latitude: CLLocationDegrees(dataSixt?.latitude ?? 0.0), longitude: CLLocationDegrees(dataSixt?.longitude ?? 0.0))
        let span = MKCoordinateSpan.init(latitudeDelta: 0.001, longitudeDelta: 0.001)
        let region = MKCoordinateRegion.init(center: coordinate, span: span)
        self.mapView.setRegion(region, animated: false)
        
        
        //////
        let anAnnotation = CarAnnotation.init(dataModel: dataSixt!)
        mapView.addAnnotation(anAnnotation)
        
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    @IBAction func bookNowClicked(_ sender: Any) {
        // to do
    }
   

}

extension CarDetailsController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
        if annotationView == nil {
            annotationView = MKAnnotationView.init(annotation: annotation, reuseIdentifier: "AnnotationView")
            annotationView?.image = #imageLiteral(resourceName: "icons8-Car Top View-50 (1)")
        }
        return annotationView
    }
}
