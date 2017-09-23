//
//  MainViewController.swift
//  SixtTest
//
//  Created by prafull kumar on 23/09/17.
//  Copyright © 2017 Prafulla. All rights reserved.
//

import UIKit
import Alamofire
import AlamofireImage
import SwiftyJSON

class MainViewController: UITableViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.refreshControl = UIRefreshControl()
        refreshControl?.addTarget(self, action: #selector(callApis), for: .valueChanged)
        
        tableView.register(UINib.init(nibName: "BaseViewCell", bundle: nil), forCellReuseIdentifier: "BaseViewCell")
        
        
        self.loadJson()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    
    // MARK: - Network Handler
    func callApis(refreshControl : UIRefreshControl) {
        //self.tableView.refreshControl?.endRefreshing()
        loadJson(isPullTorefresh: true)
    }
    
    func loadJson(isPullTorefresh : Bool = false){
//        Alamofire.request("http://www.codetalk.de/cars.json").response(completionHandler: <#T##(DefaultDataResponse) -> Void#>)
        
        if isPullTorefresh {
            self.tableView.refreshControl?.endRefreshing()
        }else{
            LoadingOverlay.shared.hideOverlayView()
        }
    }
    
    
    // MARK: - Table view data source

    override func numberOfSections(in tableView: UITableView) -> Int {
        
        return 1
    }

    override func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        return 10
    }

    
    override func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let cell = tableView.dequeueReusableCell(withIdentifier: "BaseViewCell", for: indexPath) as! BaseViewCell
        
      
        // Configure the cell...

        return cell
    }
    
    
    //heights
    
    override func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return 100
    }
 
    // MARK: - Table view delegate
    


    

}
