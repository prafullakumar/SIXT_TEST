//
//  SIXTCarsListController.swift
//  SixtTest
//
//  Created by prafull kumar on 23/09/17.
//  Copyright © 2017 Prafulla. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage

class SIXTCarsListController: UIViewController {

    var dataModel : [BaseModel] = []
    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()
        tableView.delegate = self
        tableView.dataSource = self
        
        //register cell
        tableView.register(UINib.init(nibName: "BaseViewCell", bundle: nil), forCellReuseIdentifier: "BaseViewCell")
        
        // get new data
        LoadingOverlay.shared.showOverlay(view: self.view)
        fetchData()
        
        // pull to refresh handling
        self.tableView.refreshControl = UIRefreshControl()
        self.tableView.refreshControl?.addTarget(self, action: #selector(refreshData), for: .valueChanged)
        
        
        
    }

    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    
    override func traitCollectionDidChange(_ previousTraitCollection: UITraitCollection?) {
        // orientation changed or iPad split view
        self.tableView.reloadData()
    }

    
    // MARK: - Network Handler
    func refreshData(refreshControl : UIRefreshControl) {
        //self.tableView.refreshControl?.endRefreshing()
        fetchData(isPulltorefresh: true)
    }
    
    func fetchData(isPulltorefresh : Bool = false){
        // if pull to refresh alwas get new data
        // can update the logic with one more var for forcefetch not doing it for now
        ApiHandler.shared.getCarDetails(isForceFetch: isPulltorefresh)  { [weak self] (data, error) in
            if let newData = data {
                self?.dataModel = newData;
                self?.tableView.reloadData()
            }
            if let errorMessage = error {
                let alertController = UIAlertController(title: "Error!", message: errorMessage, preferredStyle: .alert)
                let cancelAction = UIAlertAction.init(title: "OK", style: .cancel, handler: nil)
                alertController.addAction(cancelAction)
                self?.present(alertController, animated: true, completion:nil)
            }
            if isPulltorefresh {
                self?.tableView.refreshControl?.endRefreshing()
            }else{
                LoadingOverlay.shared.hideOverlayView()
            }
        }
        
    }
}


extension SIXTCarsListController : UITableViewDataSource {
    
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        if self.traitCollection.horizontalSizeClass == .regular {
            return 100
        }else{
            return 200
        }
    }
    
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BaseViewCell", for: indexPath) as! BaseViewCell
        let data = dataModel[indexPath.row]
        cell.modelName.text = "Model Name: " + (data.modelName ?? "X")
        cell.carName.text = "Car Name: " + (data.name ?? "X")
        cell.make.text = "Brand: " + (data.make ?? "X")
        
        cell.series.text = "Series: " + (data.series ?? "X")
        cell.fuleType.text = "Fuel Type: " + (data.fuelType ?? "X")
        cell.fuleLabel.text = "Fuel Level: " + String(data.fuelLevel ?? 0.0)
        
        cell.licence.text = "License: " + (data.licensePlate ?? "X")
        cell.cleanNess.text = "Cleanliness: " + (data.innerCleanliness ?? "X")
        cell.curLocation.text = "Fetching Address..."
        
        cell.carImage.image = #imageLiteral(resourceName: "car")
        cell.carImage.tag = indexPath.row  // avoid image derefer
        if let url = URL(string: data.imageUrlNew ?? "") {
            // handles catching and multiple api calls internally no need to add additional func
            Alamofire.request(url).responseImage(completionHandler: { (response) in
                if cell.carImage.tag == indexPath.row {  // validate if response came after cell reuse in that case not using image
                    if let image = response.result.value {
                       cell.carImage.image = image
                    }
                }
            })
        }
        
        
        return cell
    }
    
    func numberOfSections(in tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataModel.count
    }
    
    
    
}

extension SIXTCarsListController : UITableViewDelegate {
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        // handle click
    }
}
