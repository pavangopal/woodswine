//
//  AccountController.swift
//  WoodsWholesaleWine
//
//  Created by Pavan Gopal on 21/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit
protocol AccountControllerDelegate{
    func logoutHandler()
}

class AccountController: UIViewController {

    @IBOutlet weak var versionLabel: UILabel!
    @IBOutlet weak var profileImageView: UIImageView!
    
    @IBOutlet weak var userName: UILabel!
    
    @IBOutlet weak var emailIdLabel: UILabel!
    
    @IBOutlet weak var phoneNumberLabel: UILabel!
    
    @IBOutlet weak var tableView: UITableView!
    

    
    var delegate : AccountControllerDelegate?
    var userCoreDataObject : User?
    var keyArray = ["Manage Addresses","Help"]
    
    override func viewDidLoad() {
        super.viewDidLoad()
        versionLabel.text = ""
        let infoDict:NSDictionary = NSBundle.mainBundle().infoDictionary!
        if let appVersion = infoDict.valueForKey("CFBundleShortVersionString") as? String{
            versionLabel.text = "App Version" + " " + appVersion
        }
        formatHeaderWithData()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
        formatHeaderWithData()
    }
    
    func formatHeaderWithData(){
        
        userCoreDataObject = Helper.fetchUser(forId: UserDefaults.userId())
        if let unwrappedUserCoreDataObject = userCoreDataObject{
            
            profileImageView.setImageWithOptionalUrl(NSURL(string: unwrappedUserCoreDataObject.image!),placeholderImage: AssetImage.profile.image)
            userName.text = (unwrappedUserCoreDataObject.firstName ?? "") + " " + (unwrappedUserCoreDataObject.lastName ?? "")
            emailIdLabel.text = unwrappedUserCoreDataObject.emailAddress ?? ""
            phoneNumberLabel.text = unwrappedUserCoreDataObject.phoneNumber ?? ""
        }

        
    }

    @IBAction func logoutButtonPressed(sender: AnyObject) {
        let alertController = UIAlertController.init(title: "Confirm Logout", message: "Log out of the app?", preferredStyle: UIAlertControllerStyle.Alert)
        let noAction = UIAlertAction.init(title: "No", style: UIAlertActionStyle.Cancel, handler: nil)
        let yesAction = UIAlertAction.init(title: "Yes", style: UIAlertActionStyle.Destructive, handler: { (alert: UIAlertAction!) -> Void in
            self.delegate?.logoutHandler()

        })
        alertController.addAction(noAction)
        alertController.addAction(yesAction)
        presentViewController(alertController, animated: true, completion: nil)
    }

    @IBAction func editButtonPressed(sender: AnyObject) {
        
        let accountEditController = UIStoryboard.accountStoryboard().instantiateViewControllerWithIdentifier(String(AccountEditController)) as! AccountEditController
        
        accountEditController.userCoreDataObject = self.userCoreDataObject
        let nc = UINavigationController.init(rootViewController: accountEditController)
        self.navigationController?.presentViewController(nc, animated: true, completion: nil)
        
        //        self.navigationController?.pushViewController(accountEditController, animated: true)
        
    }

}


extension AccountController : UITableViewDelegate,UITableViewDataSource{
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return keyArray.count
    }
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        let accountCell = tableView.dequeueReusableCellWithIdentifier(String(AccountCell), forIndexPath: indexPath) as! AccountCell
        
        accountCell.textLabel?.text = keyArray[indexPath.row]
        
        return accountCell
    }
}
