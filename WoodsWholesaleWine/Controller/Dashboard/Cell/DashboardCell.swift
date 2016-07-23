//
//  DashboardCell.swift
//  WineTesting
//
//  Created by Pavan Gopal on 07/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit
import Buy



protocol DashboardCellProtocol {
    func updateCart(productVarient:BUYProductVariant?,add:Bool,delete:Bool)
}

class DashboardCell: UICollectionViewCell {

    @IBOutlet weak var priceLabel: UILabel!
    @IBOutlet weak var imageViewHeightLayoutConstraint: NSLayoutConstraint!
    @IBOutlet weak var WineImageView: UIImageView!
    @IBOutlet weak var addToCartButton: UIButton!
    @IBOutlet weak var wineNameLabel: UILabel!
    @IBOutlet weak var deleteFromCartButton: UIButton!
    
    
    var productVariant : BUYProductVariant?
//    let cart = BUYCart()
    var delegate : DashboardCellProtocol?

    
    override func awakeFromNib() {
        
        super.awakeFromNib()
        
        let imageView = UIImageView()
        imageView.image = UIImage(named: "card background")
        self.backgroundView = imageView
    }

    func updateCellData(product:BUYProduct?){
        guard let unwrappedproductData = product else{
            return
        }
         productVariant = unwrappedproductData.variants.first
        
        WineImageView.setImageWithOptionalUrl(NSURL(string: unwrappedproductData.images[0].src),placeholderImage: UIImage())
        wineNameLabel.text = unwrappedproductData.title
        
        if let price = productVariant?.price{
            priceLabel.text = "$" + kSpaceString + String(price)
        }
        
        addToCartButton.clipToCircularCorner()
        addToCartButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 2, 1)
        addToCartButton.layer.borderWidth = 1
        addToCartButton.layer.borderColor = UIColor.lightGrayColor().CGColor
        deleteFromCartButton.clipToCircularCorner()
        deleteFromCartButton.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 2, 1)
        deleteFromCartButton.layer.borderWidth = 1
        deleteFromCartButton.layer.borderColor = UIColor.lightGrayColor().CGColor
    }
    
    @IBAction func addToCartButtonPressed(sender: UIButton) {
        delegate?.updateCart(productVariant,add: true,delete: false)
        
    }
    

    @IBAction func deleteFromCartButtonPressed(sender: UIButton) {
        delegate?.updateCart(productVariant,add:false,delete:true)

    }
    
    

}

