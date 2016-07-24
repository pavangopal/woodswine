//
//  CartController.swift
//  WoodsWholesaleWine
//
//  Created by Pavan Gopal on 21/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit

class CartController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        updateLeftNavBarItems()
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
        
        tableView.reloadData()
    }
}

extension CartController : UITableViewDelegate,UITableViewDataSource,CartCellDelegate{
    
    
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
            let addressCell = tableView.dequeueReusableCellWithIdentifier("AddressCell", forIndexPath: indexPath)
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
}