//
//  AddressSelectionController.swift
//  WoodsWholesaleWine
//
//  Created by Incture Mac on 26/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit

class AddressSelectionController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    var addressObjects : [Address]?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationController?.setupNavigationBar()
        updateLeftNavBarItems()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    func updateLeftNavBarItems() {
        
        let addItem = UIBarButtonItem(title: "Save", style: .Done, target: self, action: #selector(AddressSelectionController.addNewAddressButtonPressed))
        
        navigationItem.rightBarButtonItems = [addItem]
    }
    func addNewAddressButtonPressed(){
        let addressCreationController = UIStoryboard.cartStoryboard().instantiateViewControllerWithIdentifier(String(AddressController)) as! AddressController
        
        let nc = UINavigationController.init(rootViewController: addressCreationController)
        presentViewController(nc, animated: true, completion: nil)
    }
   
}

extension AddressSelectionController : UITableViewDelegate,UITableViewDataSource{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        if let count = addressObjects?.count {
        return count
        }
        else{
            return 0
        }
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let addressSelectionCell = tableView.dequeueReusableCellWithIdentifier(String(AddressSelectionCell), forIndexPath: indexPath) as! AddressSelectionCell
        
        addressSelectionCell.updateCellData(addressObjects?[indexPath.row])
        
        return addressSelectionCell
    }
}