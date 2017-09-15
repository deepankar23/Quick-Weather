//
//  WeatherInfoCell.swift
//  Quick Weather
//
//  Created by Deepankar Srivastava on 9/13/17.
//  Copyright © 2017 Deepankar Srivastava. All rights reserved.
//

import UIKit

class WeatherInfoCell: UITableViewCell {

    //MARK:- IB-Outlets
    
    @IBOutlet weak var dayNameLabel: UILabel!
    @IBOutlet weak var dayDescriptionLabel: UILabel!
    @IBOutlet weak var highValue: UILabel!
    @IBOutlet weak var lowValue: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(_ selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
