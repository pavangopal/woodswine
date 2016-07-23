//
//  DetailHeaderView.swift
//  WoodsWholesaleWine
//
//  Created by Pavan Gopal on 18/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit
import Buy


class DetailHeaderView: UICollectionReusableView {
    @IBOutlet weak var backGorundImageView: UIImageView!
        
    @IBOutlet weak var wineImageView: UIImageView!
    
    @IBOutlet weak var wineTitleLabel: UILabel!
    
    @IBOutlet weak var mprPriceLabel: UILabel!
    
    @IBOutlet weak var discountPriceLabel: UILabel!
    
    
    @IBAction func deleteFromCart(sender: AnyObject) {
    }
    
    @IBOutlet weak var addToCart: UIButton!
    
    @IBAction func shareWineButtonPressed(sender: AnyObject) {
    }
    
    @IBOutlet weak var wishListButtonPressed: UIButton!
    
    @IBOutlet weak var productInfoTextView: UITextView!
    
    var productVariant : BUYProductVariant?
    let cart = BUYCart()

    
    func updateData(product:BUYProduct?){
        
        guard let unwrappedproductData = product else{
            return
        }
        productVariant = unwrappedproductData.variants.first
        
        wineImageView.setImageWithOptionalUrl(NSURL(string: unwrappedproductData.images[0].src),placeholderImage: UIImage())
        wineTitleLabel.text = unwrappedproductData.title
        backGorundImageView.setImageWithOptionalUrl(NSURL(string: unwrappedproductData.images[0].src),placeholderImage: UIImage())
        
        let blurEffect = UIBlurEffect(style: UIBlurEffectStyle.Light) //Adding blur to the background image
        let blurEffectView = UIVisualEffectView(effect: blurEffect)
        blurEffectView.frame = backGorundImageView.bounds
        backGorundImageView.clipsToBounds = true
        backGorundImageView.addSubview(blurEffectView)
        if let price = productVariant?.price{
            discountPriceLabel.text = "$" + kSpaceString + String(price)
        }
        
        //Adding gradient to background view
        let gradient: CAGradientLayer = CAGradientLayer()
        gradient.frame = backGorundImageView.bounds
        gradient.colors = [UIColor.clearColor().CGColor,UIColor.clearColor().CGColor, UIColor.blackColor().CGColor]
        backGorundImageView.layer.insertSublayer(gradient, atIndex: 0)
        
        if productVariant?.available == true && (productVariant?.compareAtPrice != nil) {
            print("availabe")
            let attributes = [
                NSFontAttributeName: UIFont.systemFontOfSize(13),
                NSForegroundColorAttributeName: UIColor.lightGrayColor(),
                NSStrikethroughStyleAttributeName: NSNumber(integer: NSUnderlineStyle.StyleSingle.rawValue)
            ]
  
            let attributedString = NSAttributedString.init(string: String(productVariant!.compareAtPrice!),attributes: attributes)
            
            mprPriceLabel.attributedText = Helper.concatinateAttributtedString("$", text2: attributedString)

        }
        else{
            print("Not available")
            mprPriceLabel.text = "Sold Out"
        }
    }
    
    
    
    
    
    
    
    
    
    
    
    
    
    
}
