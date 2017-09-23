//
//  BaseViewCell.swift
//  SixtTest
//
//  Created by prafull kumar on 23/09/17.
//  Copyright © 2017 Prafulla. All rights reserved.
//

import UIKit

class BaseViewCell: UITableViewCell {

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
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
