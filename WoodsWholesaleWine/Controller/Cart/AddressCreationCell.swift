//
//  AddressCreationCell.swift
//  WoodsWholesaleWine
//
//  Created by Incture Mac on 26/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit

protocol AddressCreationCellDelegate{
    func updateAddress(addressObject:AddressCreationCell.addressStruct)
}

class AddressCreationCell: UITableViewCell,UITextFieldDelegate {
    
    @IBOutlet weak var firstNameTextField: UITextField!
    @IBOutlet weak var lastNameTextField: UITextField!
    @IBOutlet weak var addressTextField: UITextField!
    @IBOutlet weak var provinceTextField: UITextField!
    @IBOutlet weak var cityTextField: UITextField!
    @IBOutlet weak var zipTextField: UITextField!
    @IBOutlet weak var countryCodeTextField: UITextField!
    
    
 
    
    var addressStructObject = addressStruct()
    var delegate : AddressCreationCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        
        
        // Initialization code
    }
    
    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)
        
        // Configure the view for the selected state
    }
    
    @IBAction func getfirstName(sender: AnyObject) {
        let textField = sender as! UITextField
        addressStructObject.firstName = textField.text
        delegate?.updateAddress(addressStructObject)
    }
    @IBAction func getlastName(sender: AnyObject) {
        let textField = sender as! UITextField
        addressStructObject.lastName = textField.text
        delegate?.updateAddress(addressStructObject)

    }
    
    @IBAction func getAddress(sender: AnyObject) {
        let textField = sender as! UITextField
        addressStructObject.address = textField.text
        delegate?.updateAddress(addressStructObject)

    }
    
    @IBAction func getCity(sender: AnyObject) {
        let textField = sender as! UITextField
        addressStructObject.city = textField.text
        delegate?.updateAddress(addressStructObject)

    }
    @IBAction func getProvince(sender: AnyObject) {
        let textField = sender as! UITextField
        addressStructObject.province = textField.text
        delegate?.updateAddress(addressStructObject)

    }
    @IBAction func getZipCode(sender: AnyObject) {
        let textField = sender as! UITextField
        addressStructObject.zipCode = textField.text
        delegate?.updateAddress(addressStructObject)

    }
    
    @IBAction func getCountryCode(sender: AnyObject) {
        let textField = sender as! UITextField
        addressStructObject.countryCode = textField.text
        delegate?.updateAddress(addressStructObject)

    }
    
}

extension  AddressCreationCell{
    
struct addressStruct{
    var id : String?
    var firstName:String?
    var lastName : String?
    var address : String?
    var province : String?
    var city : String?
    var zipCode : String?
    var countryCode : String?
}
}
