//
//  CartCell.swift
//  WoodsWholesaleWine
//
//  Created by Incture Mac on 24/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit
import Buy

protocol CartCellDelegate {
    func updateCart()
}

class CartCell: UITableViewCell {

    @IBOutlet weak var deleteFromCart: UIButton!
    @IBOutlet weak var addToCart: UIButton!
    
    @IBOutlet weak var quantityLabel: UILabel!
    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var productName: UILabel!
    
    var delegate : CartCellDelegate?
    var productVariant : BUYProductVariant?
    var productGlobal : Product?
    var indexGlobal = NSIndexPath()

    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    func updateCellData(item : BUYCartLineItem,index:NSIndexPath){
        productVariant = item.variant
        productGlobal?.product = productVariant?.product
        productName.text = item.variant.product.title
        indexGlobal = index
        if let price = item.variant.price{
            priceLabel.text = "$" + kSpaceString + String(price)
        }
        if let unwrappedQuantity = item.quantity{
            quantityLabel.text =  String(unwrappedQuantity)
        }
    }
    
    @IBAction func addToCartButtonPressed(sender: AnyObject) {
        CartManager.instance.addProductVarientToCart(productGlobal,index: indexGlobal)
        delegate?.updateCart()

    }
    
    @IBAction func deleteFromCartButtonPressed(sender: AnyObject) {
        CartManager.instance.deleteProductVarientFromCart(productGlobal,index: indexGlobal)
        delegate?.updateCart()
    }
}
