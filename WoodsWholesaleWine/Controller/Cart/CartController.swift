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
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }


}

extension CartController : UITableViewDelegate,UITableViewDataSource{
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0: return 2
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
            let cartCell = tableView.dequeueReusableCellWithIdentifier("CartCell", forIndexPath: indexPath)
            return cartCell
        case 1:
            let priceCell = tableView.dequeueReusableCellWithIdentifier("PriceCell", forIndexPath: indexPath)
            return priceCell
        case 2:
            let couponCell = tableView.dequeueReusableCellWithIdentifier("CouponCell", forIndexPath: indexPath)
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
}