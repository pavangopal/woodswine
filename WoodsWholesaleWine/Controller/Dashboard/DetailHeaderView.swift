//
//  DetailHeaderView.swift
//  WoodsWholesaleWine
//
//  Created by Pavan Gopal on 18/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit
import Buy
import Cosmos

protocol DetailHeaderViewDelegate {
    func updateBadgeCount()
}


class DetailHeaderView: UICollectionReusableView {
    @IBOutlet weak var backGorundImageView: UIImageView!
    
    @IBOutlet weak var cosmosView: CosmosView!
    @IBOutlet weak var wineImageView: UIImageView!
    
    @IBOutlet weak var wineTitleLabel: UILabel!
    
    @IBOutlet weak var mprPriceLabel: UILabel!
    
    @IBOutlet weak var discountPriceLabel: UILabel!
    
    @IBOutlet weak var deleteFromCart: UIButton!
    @IBOutlet weak var addToCart: UIButton!
    @IBOutlet weak var shareButton: UIButton!
    @IBOutlet weak var productInfoTextView: UITextView!
    @IBOutlet weak var wishListButton: UIButton!
    
    var productVariant : BUYProductVariant?
    var delegate : DetailHeaderViewDelegate?
    
    func updateData(product:BUYProduct?){
        
        guard let unwrappedproductData = product else{
            return
        }
        customizeUI()
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
        let text = Helper.getDescriptionFromHtml(product?.htmlDescription)
        
        productInfoTextView.attributedText = text
        productInfoTextView.layoutSubviews()
    }
    
    override func layoutSubviews() {
        self.productInfoTextView.setContentOffset(CGPointZero, animated: false)
        
    }
    
    func customizeUI()
    {
        shareButton.setImage(AssetImage.share.image, forState: .Normal)
        shareButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 0)
        wishListButton.setImage(AssetImage.wishlist.image, forState: .Normal)
        wishListButton.titleEdgeInsets = UIEdgeInsets(top: 0, left: 2, bottom: 0, right: 0)

        
        addToCart.clipToCircularCorner()
        addToCart.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 2, 1)
        addToCart.layer.borderWidth = 1
        addToCart.layer.borderColor = UIColor.lightGrayColor().CGColor
        
        deleteFromCart.clipToCircularCorner()
        deleteFromCart.titleEdgeInsets = UIEdgeInsetsMake(0, 0, 2, 1)
        deleteFromCart.layer.borderWidth = 1
        deleteFromCart.layer.borderColor = UIColor.lightGrayColor().CGColor
        
    }
    
    
    @IBAction func deleteFromCartButtonPressed(sender: AnyObject) {
        CartManager.instance.deleteProductVarientFromCart(productVariant)
        delegate?.updateBadgeCount()

    }
    
    @IBAction func addToCartButtonPressed(sender: AnyObject) {
        CartManager.instance.addProductVarientToCart(productVariant)
        delegate?.updateBadgeCount()

    }
    
    @IBAction func shareWineButtonPressed(sender: AnyObject) {
    }
    
    @IBAction func wishListButtonPressed(sender: AnyObject) {
    }
    
}
