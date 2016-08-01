//
//  FilterCell.swift
//  WoodsWholesaleWine
//
//  Created by Incture Mac on 01/08/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit

class FilterCell: UITableViewCell {

    @IBOutlet weak var valueLabel: UILabel!
    @IBOutlet weak var keyLabel: UILabel!
    @IBOutlet weak var checkBoxButton: UIButton!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    func updateCelldata(key : String?,value : String?){
        keyLabel.text = key
        valueLabel.text = value
    }
    
    @IBAction func checkBoxButtonPressed(sender: AnyObject) {
    }
}
