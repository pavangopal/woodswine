//
//  AccountEditCell.swift
//  WoodsWholesaleWine
//
//  Created by Incture Mac on 30/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit

protocol AccountEditCellDelegate {
    func updateAccountDetails(user:User?)
}
class AccountEditCell: UITableViewCell {

    @IBOutlet weak var firstName: UITextField!
    @IBOutlet weak var emailId: UITextField!
    @IBOutlet weak var phoneNumber: UITextField!
    @IBOutlet weak var lastname: UITextField!
    
    
    var userCoreDataObject : User?
    var delegate : AccountEditCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }
    
    
    
    func updateCellWithData(user : User?){
        userCoreDataObject = user
        
        if Helper.lengthOfStringWithoutSpace(user?.firstName) > 0{
            emailId.text = user?.emailAddress
            phoneNumber.text = user?.phoneNumber
            firstName.text = user?.firstName
            lastname.text = user?.lastName
        }
        else{
            
        }
        
        
    }
    
    
    @IBAction func getPhoneNumber(sender: AnyObject) {
        let textField = sender as! UITextField
        userCoreDataObject?.phoneNumber = textField.text
        delegate?.updateAccountDetails(userCoreDataObject)
    }

    @IBAction func getLastName(sender: AnyObject) {
        let textField = sender as! UITextField
        userCoreDataObject?.lastName = textField.text
        delegate?.updateAccountDetails(userCoreDataObject)
    }

    @IBAction func getFirstname(sender: AnyObject) {
        let textField = sender as! UITextField
        userCoreDataObject?.firstName = textField.text
        delegate?.updateAccountDetails(userCoreDataObject)
    }
    
    @IBAction func getEmailId(sender: AnyObject) {
        let textField = sender as! UITextField
        userCoreDataObject?.emailAddress = textField.text
        delegate?.updateAccountDetails(userCoreDataObject)
    }
}
