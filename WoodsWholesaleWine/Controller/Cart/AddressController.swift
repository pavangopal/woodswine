//
//  AddressController.swift
//  WoodsWholesaleWine
//
//  Created by Incture Mac on 26/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit
import CoreData
import BRYXBanner

class AddressController: UIViewController {

    
    var addressToAddObject = AddressCreationCell.addressStruct()
    
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

        let saveItem = UIBarButtonItem(title: "Save", style: .Done, target: self, action: #selector(AddressController.saveNewAddressButtonPressed))
        
        navigationItem.rightBarButtonItems = [saveItem]
    }
    
    func saveNewAddressButtonPressed(){
        if Helper.lengthOfStringWithoutSpace(addressToAddObject.address) > 0 && Helper.lengthOfStringWithoutSpace(addressToAddObject.city) > 0 && Helper.lengthOfStringWithoutSpace(addressToAddObject.countryCode) > 0 && Helper.lengthOfStringWithoutSpace(addressToAddObject.firstName) > 0 && Helper.lengthOfStringWithoutSpace(addressToAddObject.lastName) > 0 && Helper.lengthOfStringWithoutSpace(addressToAddObject.province) > 0 && Helper.lengthOfStringWithoutSpace(addressToAddObject.zipCode) > 0{
            
            let addresess = Helper.fetchAllAddress()
            addressToAddObject.id = String(addresess.count)
            
           let addressCoreDataObject = Helper.AddressForDictionary(addressToAddObject)
            
            if addressCoreDataObject != nil{
                let banner = Banner(title: "Address added successfully", subtitle: "", image: UIImage(named: "Icon"), backgroundColor: ConstantColor.CWGreen)
                banner.dismissesOnTap = true
                banner.show(duration: 3.0)
                dismissViewControllerAnimated(true, completion: nil)
            }
            else{
                let banner = Banner(title: "Error adding address", subtitle: "", image: UIImage(named: "Icon"), backgroundColor: ConstantColor.CWOrange)
                banner.dismissesOnTap = true
                banner.show(duration: 3.0)
            }
        }
        else{
            let alertController = UIAlertController(title: "Cannot Save Empty Entry", message: "Please fill all the fields" , preferredStyle: .Alert)
            let okAction = UIAlertAction(title:  NSLocalizedString("okActionTitle", comment: ""), style:.Cancel ,handler:{ (action) -> Void in
            })
            alertController.addAction(okAction)
            presentViewController(alertController, animated: true, completion: nil)
        }

   
    }
 
}

extension AddressController : UITableViewDataSource,UITableViewDelegate,AddressCreationCellDelegate{
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let addressCreationCell = tableView.dequeueReusableCellWithIdentifier(String(AddressCreationCell), forIndexPath: indexPath) as! AddressCreationCell
        addressCreationCell.delegate = self
        return addressCreationCell
    }
    
    
    func updateAddress(addressObject: AddressCreationCell.addressStruct) {
        addressToAddObject = addressObject
    }
}