//
//  OrdersController.swift
//  WoodsWholesaleWine
//
//  Created by Pavan Gopal on 21/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit

class OrdersController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepareForSegue(segue: UIStoryboardSegue, sender: AnyObject?) {
        // Get the new view controller using segue.destinationViewController.
        // Pass the selected object to the new view controller.
    }
    */

}

extension OrdersController : UITableViewDelegate,UITableViewDataSource{

func numberOfSectionsInTableView(tableView: UITableView) -> Int {
    return 1
}


func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
    return 5
}


func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
    let orderCell = tableView.dequeueReusableCellWithIdentifier(String(OrderCell), forIndexPath: indexPath) as! OrderCell
    
    
    return orderCell
}
}