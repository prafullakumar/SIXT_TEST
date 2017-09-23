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
    @IBOutlet weak var carDetails: UILabel!
    @IBOutlet weak var carSubtitle: UILabel!
    @IBOutlet weak var carTitle: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
}
