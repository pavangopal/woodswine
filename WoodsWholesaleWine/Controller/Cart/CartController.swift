//
//  CartController.swift
//  WoodsWholesaleWine
//
//  Created by Pavan Gopal on 21/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit
import Buy

class CartController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var proceedToCheckoutButton: UIButton!
    @IBOutlet weak var buyWithApplePayButton: UIButton!
    @IBOutlet weak var buttonView: UIView!
    var addressFromCoreData : [Address]?
        
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        updateLeftNavBarItems()
        proceedToCheckoutButton.setImage(AssetImage.credit.image, forState: .Normal)
        proceedToCheckoutButton.imageEdgeInsets = UIEdgeInsetsMake(5, 0, 0, 5)
        proceedToCheckoutButton.setTitle("Checkout", forState: .Normal)
        buyWithApplePayButton.setImage(AssetImage.apple.image, forState: .Normal)
        buyWithApplePayButton.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 10)
        tableView.tableFooterView = UIView(frame: CGRectZero)
        CartManager.instance.ShippingAddress = Helper.fetchAllAddress().first
        buyWithApplePayButton.setTitle("Pay", forState: .Normal)
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    func updateLeftNavBarItems() {
        
        let menuItem = UIBarButtonItem.init(title: "Clear", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CartController.clearCartButtonPressed))
        
        
        navigationItem.leftBarButtonItems = [menuItem]
    }
    
    func clearCartButtonPressed(){
        CartManager.instance.clearCart()
        
            let tabArray = self.tabBarController?.tabBar.items as NSArray!
            let tabItem = tabArray.objectAtIndex(1) as! UITabBarItem
            
            tabItem.badgeValue = String(CartManager.instance.lineItems.count)
        
        tableView.reloadData()
    }
}

extension CartController : UITableViewDelegate,UITableViewDataSource,CartCellDelegate,AddressCellDelegate{
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0: return(CartManager.instance.lineItems.count > 0) ?  CartManager.instance.lineItems.count :  0
        case 1: return 3
        case 2 : return 4
        case 3: return 1
        default :
            return 0
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cartCell = tableView.dequeueReusableCellWithIdentifier("CartCell", forIndexPath: indexPath) as! CartCell
            cartCell.delegate = self
            cartCell.updateCellData(CartManager.instance.lineItems[indexPath.row])
            return cartCell
        case 1:
            let priceCell = tableView.dequeueReusableCellWithIdentifier("PriceCell", forIndexPath: indexPath) as! PriceCell
            priceCell.updatePriceCelWithData(indexPath.row)
            return priceCell
        case 2:
            let couponCell = tableView.dequeueReusableCellWithIdentifier("CouponCell", forIndexPath: indexPath) as! CouponCell
            couponCell.updateCouponCellWithData(indexPath.row)
            return couponCell
        case 3 :
            let addressCell = tableView.dequeueReusableCellWithIdentifier("AddressCell", forIndexPath: indexPath) as! AddressCell
            addressCell.delegate = self
            addressCell.updateAddress(CartManager.instance.ShippingAddress)
            return addressCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func updateCart(){
        tableView.reloadData()
    }
    
    func addNewAddressButtonPressed(){
        addressFromCoreData = Helper.fetchAllAddress()
        if addressFromCoreData?.count > 0{
            let addressSelectionController = UIStoryboard.cartStoryboard().instantiateViewControllerWithIdentifier(String(AddressSelectionController)) as! AddressSelectionController
//            addressSelectionController.delegate = self
            let nc = UINavigationController.init(rootViewController: addressSelectionController)
            presentViewController(nc, animated: true, completion: nil)
        }
        else{
            let addressCreationController = UIStoryboard.cartStoryboard().instantiateViewControllerWithIdentifier(String(AddressController)) as! AddressController
            
            let nc = UINavigationController.init(rootViewController: addressCreationController)
            presentViewController(nc, animated: true, completion: nil)
        }
    }
    
    @IBAction func proceedToCheckoutButtonPressed(sender: AnyObject) {
    }
    
    @IBAction func buyWithApplepayButtonPressed(sender: AnyObject) {
    }
    
    
}