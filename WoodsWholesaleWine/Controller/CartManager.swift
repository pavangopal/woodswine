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
    func cartBadgeCountUpdatingDelegateFunction(count:Int,indexPath :NSIndexPath)
}

class CartManager: BUYCart {

    
    static let instance = CartManager()

//    var userId : String?
//    var userImageUrl : String?
    
    var totalCartPriceWitoutTax = Float()
    var totalCartTax = Float()
    var totalShippingCharge = Float()
    var billTotal = Float()
    var grandTotal = Float()
    var ShippingAddress : Address?
    var BillingAddress : Address?
    var emailAddress : String?
    var delegate : CartManagerDelegate?
    var totalBadgeCount = 0


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
    
    func addProductVarientToCart(product: Product?,index:NSIndexPath) {
        totalBadgeCount = 0
        if let unwrappedProductVarient = product?.product?.variants.first{
            if unwrappedProductVarient.available{
                CartManager.instance.addVariant(unwrappedProductVarient)
                if let unwrappedProductQuantity = product?.productQuantity{
                    product?.productQuantity = unwrappedProductQuantity + 1
                }
                
                for item in CartManager.instance.lineItems{
                    totalBadgeCount += (item.quantity.integerValue)
                }

                delegate?.cartBadgeCountUpdatingDelegateFunction(totalBadgeCount,indexPath:index)
                
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
    
    func deleteProductVarientFromCart(product: Product?,index:NSIndexPath) {
        totalBadgeCount = 0

        if let unwrappedProductVarient = product?.product?.variants.first{
            if unwrappedProductVarient.available{
                CartManager.instance.removeVariant(unwrappedProductVarient)
                if let unwrappedProductQuantity = product?.productQuantity{
                    product?.productQuantity = unwrappedProductQuantity - 1
                }
                for item in CartManager.instance.lineItems{
                    totalBadgeCount += (item.quantity.integerValue)
                }
                delegate?.cartBadgeCountUpdatingDelegateFunction(totalBadgeCount,indexPath:index)

            }
            else{
                print("product variant not available")
            }
        }else{
            print("product variant not available")
        }
        
    }
}