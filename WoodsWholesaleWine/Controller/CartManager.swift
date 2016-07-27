//
//  CartManager.swift
//  WoodsWholesaleWine
//
//  Created by Pavan Gopal on 18/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import Foundation
import UIKit
import Buy
import BRYXBanner

protocol CartManagerDelegate {
    func cartBadgeCountUpdatingDelegateFunction(count:Int)
}

class CartManager: BUYCart {

    
    static let instance = CartManager()

    var totalCartPriceWitoutTax = Float()
    var totalCartTax = Float()
    var totalShippingCharge = Float()
    var billTotal = Float()
    var grandTotal = Float()
    var ShippingAddress : Address?
    var BillingAddress : Address?
    var emailAddress : String?
    var delegate : CartManagerDelegate?

//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }
    
    private override init() {
        
//        super.init(nibName: nil, bundle: nil)
        //        print("SINGLETON INITIALIZED: LoadingController")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
    
    func addProductVarientToCart(productVarient: BUYProductVariant?) {
        
        if let unwrappedProductVarient = productVarient{
            if unwrappedProductVarient.available{
                CartManager.instance.addVariant(unwrappedProductVarient)
                
               delegate?.cartBadgeCountUpdatingDelegateFunction(CartManager.instance.lineItems.count)
//                let banner = Banner(title: "Product Added", subtitle: "", image: UIImage(named: "Icon"), backgroundColor: ConstantColor.CWGreen)
//                banner.dismissesOnTap = true
//                banner.show(duration: 3.0)
            }
            else{
                let banner = Banner(title: "Product Not Available", subtitle: "", image: UIImage(named: "Icon"), backgroundColor: ConstantColor.CWOrange)
                banner.dismissesOnTap = true
                banner.show(duration: 3.0)
            }
        }else{
            print("product variant not available")
        }
        
    }
    
    func deleteProductVarientFromCart(productVarient: BUYProductVariant?) {
        
        if let unwrappedProductVarient = productVarient{
            if unwrappedProductVarient.available{
                CartManager.instance.removeVariant(unwrappedProductVarient)
                
                delegate?.cartBadgeCountUpdatingDelegateFunction(CartManager.instance.lineItems.count)

            }
            else{
                print("product variant not available")
            }
        }else{
            print("product variant not available")
        }
        
    }
}