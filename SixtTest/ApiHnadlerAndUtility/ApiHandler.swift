//
//  ApiHandler.swift
//  SixtTest
//
//  Created by prafull kumar on 23/09/17.
//  Copyright © 2017 Prafulla. All rights reserved.
//

import UIKit
import Alamofire
import SwiftyJSON

class ApiHandler {
    
    
    fileprivate var carsData : [BaseModel]?
    static let shared = ApiHandler();

    func getCarDetails(isForceFetch : Bool = false,completion : @escaping (_ dataArray : [BaseModel]?,_ errorMessage : String?) -> Void){
        if carsData != nil && !isForceFetch {
            // send cached data  (also can be archive but not doing it for now)
            completion(carsData,nil) // already checked for nil
        }else{
            let apiReq = Alamofire.request("http://www.codetalk.de/cars.json")
            
            apiReq.responseJSON(completionHandler: { (response) in
                if let data = response.data {
                    
                    let json:JSON = JSON(data: data)
                    if let items = json.array {
                        self.carsData = items.map { BaseModel.init(json: $0) }
                        completion(self.carsData,nil)
                    }else{
                        let errorMessage = self.fetchErrorFromResponse(response)
                        completion(nil,errorMessage)
                    }
                }else{
                    let errorMessage = self.fetchErrorFromResponse(response)
                    completion(nil,errorMessage)
                }
            })
        }
    }
    
    func fetchErrorFromResponse(_ response : DataResponse<Any>) -> String {
        if let errorMsg = response.result.error?.localizedDescription {
            return errorMsg
        }
        return "Error while fetching data please try later!"
    }
}
