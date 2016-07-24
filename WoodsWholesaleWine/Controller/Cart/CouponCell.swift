//
//  CouponCell.swift
//  WoodsWholesaleWine
//
//  Created by Incture Mac on 25/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit
import Buy

class CouponCell: UITableViewCell {

    @IBOutlet weak var detailLabel: UILabel!
    @IBOutlet weak var titleLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state

    }

    func updateCouponCellWithData(index:Int){
        switch index{
        case 0 :
            titleLabel.text = "Apply Coupon"
            detailLabel.text = ""
            self.accessoryType = .DisclosureIndicator
            
            break
        case 1 :
            titleLabel.text = "Shipping Charges"
            detailLabel.text = "$" + kSpaceString + String(BUYShippingRate().price)
            break
        case 2 :
            titleLabel.text = "Grand Total"
            CartManager.instance.grandTotal = CartManager.instance.billTotal
            detailLabel.text = "$" + kSpaceString + String(CartManager.instance.grandTotal)
            break
        case 3:
            titleLabel.text = "Add order Notes"
            detailLabel.text = ""
            self.accessoryType = .DisclosureIndicator
            break
        default:
            break
        }
    }
}
