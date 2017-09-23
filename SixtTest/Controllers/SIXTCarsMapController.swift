//
//  SIXTCarsMapController.swift
//  SixtTest
//
//  Created by prafull kumar on 23/09/17.
//  Copyright © 2017 Prafulla. All rights reserved.
//

import UIKit
import MapKit

class SIXTCarsMapController: UIViewController {
    @IBOutlet weak var mapView: MKMapView!
    var cars:[UIView] = []
    var dataModel : [BaseModel] = []
    
    override func viewDidLoad() {
        super.viewDidLoad()
        mapView.delegate = self
        
        self.getApiData();
        
        
        
    }

    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    //Mark: -  network call
    func getApiData() {
        LoadingOverlay.shared.showOverlay(view: self.view)
        
        ApiHandler.shared.getCarDetails  { [weak self] (data, error) in
            if let newData = data {
                self?.dataModel = newData;
                // Add annotation
                self?.updateMap()
            }
            if let errorMessage = error {
                let alertController = UIAlertController(title: "Error!", message: errorMessage, preferredStyle: .alert)
                let cancelAction = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                self?.present(alertController, animated: true, completion:nil)
            }
            
            LoadingOverlay.shared.hideOverlayView()
            
        }
        
    }
    
    //Mark: - UI Update
    func updateMap(){
        for data in dataModel {
            let anAnnotation = CarAnnotation.init(dataModel: data)
            mapView.addAnnotation(anAnnotation)
        }
        // update map
        mapView.showAnnotations(mapView.annotations, animated: true)
    }

    
    
    
    func layoutDetailView(_ view:UIView, _ viewWidth:CGFloat, _ viewHeight:CGFloat) -> UIView {
        let updatedView = view
        let views = ["newViewSize": updatedView]
        updatedView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "H:[newViewSize(\(viewWidth))]", options: [], metrics: nil, views: views))
        updatedView.addConstraints(NSLayoutConstraint.constraints(withVisualFormat: "V:[newViewSize(\(viewHeight))]", options: [], metrics: nil, views: views))
        return updatedView
    }
    
    
}


extension SIXTCarsMapController : MKMapViewDelegate {
    func mapView(_ mapView: MKMapView, viewFor annotation: MKAnnotation) -> MKAnnotationView? {
        var annotationView = mapView.dequeueReusableAnnotationView(withIdentifier: "AnnotationView")
        if annotationView == nil {
            annotationView = MKAnnotationView.init(annotation: annotation, reuseIdentifier: "AnnotationView")
            annotationView?.image = #imageLiteral(resourceName: "icons8-Car Top View-50 (1)")
        }
        
        
        if let myAnnotation = annotation as? CarAnnotation {
            let detailAnnotaionView = CarAnnotaionView.initFromNib()
            detailAnnotaionView.configViewFor(data: myAnnotation.data)
            annotationView!.canShowCallout = true
            
            annotationView!.detailCalloutAccessoryView =
                self.layoutDetailView(detailAnnotaionView, 200, detailAnnotaionView.frame.size.height)
        }
        return annotationView
        
    }
}
