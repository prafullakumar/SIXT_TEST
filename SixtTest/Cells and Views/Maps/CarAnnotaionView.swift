//
//  CarAnnotaionView.swift
//  SixtTest
//
//  Created by prafull kumar on 23/09/17.
//  Copyright © 2017 Prafulla. All rights reserved.
//

import UIKit
import MapKit
import Alamofire
class CarAnnotaionView: MKAnnotationView {

    @IBOutlet weak var bigImage: UIImageView!
    @IBOutlet weak var carNameAndModel: UILabel!
    @IBOutlet weak var howClean: UILabel!
    
    class func initFromNib() -> CarAnnotaionView {
        let annotaionView = UINib.init(nibName: "CarAnnotaionView", bundle: nil).instantiate(withOwner: nil, options: nil)[0] as! CarAnnotaionView
        return annotaionView
    }
    
    func configViewFor(data : BaseModel){
        
        carNameAndModel.text = (data.name ?? "") + " " + (data.modelName ?? "")
        howClean.text = (data.innerCleanliness ?? "") + " " + (data.licensePlate ?? "")
        
        self.bigImage.image = #imageLiteral(resourceName: "car")
        if let url = URL(string: data.imageUrlNew ?? "") {
            // handles catching and multiple api calls internally no need to add additional func
            Alamofire.request(url).responseImage(completionHandler: { [weak self] (response) in
                    if let image = response.result.value {
                        self?.bigImage.image = image
                    }
            })
        }
    }

}
