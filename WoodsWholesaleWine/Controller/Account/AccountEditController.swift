//
//  AccountEditController.swift
//  WoodsWholesaleWine
//
//  Created by Incture Mac on 30/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit
import BRYXBanner

class AccountEditController: UIViewController {

    @IBOutlet weak var tableView: UITableView!
    
    
    var userCoreDataObject : User?
    
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
        
        let saveItem = UIBarButtonItem.init(title: "Save", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(AccountEditController.saveButtonPressed))
        let closeItem = UIBarButtonItem.init(title: "Close", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(AccountEditController.closeButtonPressed))
        navigationItem.leftBarButtonItem = closeItem
        navigationItem.rightBarButtonItem = saveItem
    }
    
    func closeButtonPressed(){
        dismissViewControllerAnimated(true, completion: nil)
    }
    
    func saveButtonPressed(){
        let user = createStructFromCoreDataObject()
       let userSavedObject =  Helper.UserForDictionary(user)
        
        if userSavedObject != nil{
            let banner = Banner(title: "Profile Updated Successfully", subtitle: "", image: UIImage(named: "Icon"), backgroundColor: ConstantColor.CWGreen)
            banner.dismissesOnTap = true
            banner.show(duration: 3.0)
            dismissViewControllerAnimated(true, completion: nil)
            
        }
        else{
            let banner = Banner(title: "Error editing Profile", subtitle: "", image: UIImage(named: "Icon"), backgroundColor: ConstantColor.CWOrange)
            banner.dismissesOnTap = true
            banner.show(duration: 3.0)
        }
    }
   
}

extension AccountEditController : UITableViewDelegate,UITableViewDataSource,AccountEditCellDelegate{
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let accountEditCell = tableView.dequeueReusableCellWithIdentifier(String(AccountEditCell), forIndexPath: indexPath) as! AccountEditCell
        accountEditCell.delegate = self
      accountEditCell.updateCellWithData(userCoreDataObject)
        
        return accountEditCell
    }
    
    func updateAccountDetails(user: User?) {
        userCoreDataObject = user
    }
    
    func createStructFromCoreDataObject() -> LoginController.UserStruct{
        var userStruct = LoginController.UserStruct()
        userStruct.emailAddress = userCoreDataObject?.emailAddress
        userStruct.id = UserDefaults.userId()
        userStruct.image = UserDefaults.loggedInUserImage()
        userStruct.firstname = userCoreDataObject?.firstName
        userStruct.lastname = userCoreDataObject?.lastName
        userStruct.phoneNumber = userCoreDataObject?.phoneNumber
        return userStruct
    }
}