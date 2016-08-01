//
//  DashboardCell.swift
//  WineTesting
//
//  Created by Pavan Gopal on 07/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit
import Buy

protocol DashboardCellDelegate {
    func updateBadgeCount()
}

class DashboardCell: UICollectionViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var WineImageView: UIImageView!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var wineNameLabel: UILabel!
    @IBOutlet weak var deleteFromCartButton: UIButton!
    
    @IBOutlet weak var itemCountLabel: UILabel!
    
    var productVariant : BUYProductVariant?
    var delegate : DashboardCellDelegate?
    var productGlobal : Product?
    var indexPathGlobal = NSIndexPath()

    override func awakeFromNib() {
        
        super.awakeFromNib()
        itemCountLabel.text = ""
        let imageView = UIImageView()
        imageView.image = UIImage(named: "card background")
        self.backgroundView = imageView
    }

    func updateCellData(product:Product?,index:NSIndexPath){
        guard let unwrappedproductData = product?.product else{
            return
        }
         productVariant = unwrappedproductData.variants.first
        productGlobal = product
        indexPathGlobal = index
        if unwrappedproductData.images.count > 0{
        WineImageView.setImageWithOptionalUrl(NSURL(string: unwrappedproductData.images[0].src),placeholderImage: UIImage())
        }
        wineNameLabel.text = unwrappedproductData.title
        
        if let price = productVariant?.price{
            priceLabel.text = "$" + kSpaceString + String(price)
        }
        if let unwrappedProductQuantity = product?.productQuantity{
            itemCountLabel.text = String(unwrappedProductQuantity)
        }
//        addToCartButton.clipToCircularCorner()
//        addToCartButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 2, 1)
//        addToCartButton.layer.borderWidth = 1
//        addToCartButton.layer.borderColor = UIColor.lightGrayColor().CGColor
//        deleteFromCartButton.clipToCircularCorner()
//        deleteFromCartButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 2, 1)
//        deleteFromCartButton.layer.borderWidth = 1
//        deleteFromCartButton.layer.borderColor = UIColor.lightGrayColor().CGColor
    }
    
    @IBAction func addToCartButtonPressed(sender: UIButton) {

        CartManager.instance.addProductVarientToCart(productGlobal,index:indexPathGlobal)
        
//        delegate?.updateBadgeCount()
    }
    

    @IBAction func deleteFromCartButtonPressed(sender: UIButton) {
        if productGlobal?.productQuantity != 0{
        CartManager.instance.deleteProductVarientFromCart(productGlobal,index:indexPathGlobal)
        }
//        delegate?.updateBadgeCount()

    }
    
    

}

