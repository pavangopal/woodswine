//
//  PriceCell.swift
//  WoodsWholesaleWine
//
//  Created by Incture Mac on 25/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit

class PriceCell: UITableViewCell {

    @IBOutlet weak var titleLabel: UILabel!
    @IBOutlet weak var detailLabel: UILabel!
    
    var totalPrice = Float()
    var totalTax = Float()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    
    func updatePriceCelWithData(index:Int){
        switch index {
        case 0:
            titleLabel.text = "Item total ( \(CartManager.instance.lineItems.count) items in total )"
            totalPrice = 0
            for item in CartManager.instance.lineItems{
                    totalPrice = totalPrice + (item.variant.price.floatValue * item.quantity.floatValue)
                
            }
            CartManager.instance.totalCartPriceWitoutTax = totalPrice
            detailLabel.text = "$" + kSpaceString + String(totalPrice)
            
            break
        case 1:
            // problem here
            totalTax = 0
            for item in CartManager.instance.lineItems{
                totalTax = totalTax + (item.variant.taxable.floatValue * item.quantity.floatValue)
            }
            CartManager.instance.totalCartTax = totalTax
            titleLabel.text = "Tax"
            detailLabel.text =  "$" + kSpaceString + String(totalTax)
            break
        case 2:
            var billTotal = Float()
            billTotal = CartManager.instance.totalCartTax + CartManager.instance.totalCartPriceWitoutTax
            CartManager.instance.billTotal = billTotal
            titleLabel.text = "Bill total"
            detailLabel.text = "$" + kSpaceString + String(billTotal)
            break
        default:
            break
        }
      
    }
}
