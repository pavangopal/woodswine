//
//  OrderCell.swift
//  WoodsWholesaleWine
//
//  Created by Incture Mac on 23/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit

class OrderCell: UITableViewCell {

    @IBOutlet weak var orderCostLabel: UILabel!
    @IBOutlet weak var orderTImeLabel: UILabel!
    @IBOutlet weak var orderDateLabel: UILabel!
    @IBOutlet weak var orderIdLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

}
