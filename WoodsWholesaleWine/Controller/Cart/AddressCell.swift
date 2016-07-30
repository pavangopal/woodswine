//
//  AddressCell.swift
//  WoodsWholesaleWine
//
//  Created by Incture Mac on 25/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit

protocol AddressCellDelegate {
    func addNewAddressButtonPressed()
}

class AddressCell: UITableViewCell {
    @IBOutlet weak var cityLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var selectAddressLabel: UILabel!
    @IBOutlet weak var zipCodeLabel: UILabel!
    @IBOutlet weak var NameLabel: UILabel!
    
    var delegate : AddressCellDelegate?
    
    override func awakeFromNib() {
        super.awakeFromNib()
        selectAddressLabel.text = "Select address"
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateAddress(address:Address?){
        if let unwrappedAddress = address{
            NameLabel.text = (unwrappedAddress.firstName  ?? "") + " " + kSpaceString +  kSpaceString + (unwrappedAddress.lastName ?? "" )
            addressLabel.text = (unwrappedAddress.address1 ?? "") + kSpaceString + " " + (unwrappedAddress.city ?? "") + kSpaceString + " " + (unwrappedAddress.zip ?? "")
            cityLabel.text = unwrappedAddress.phoneNumber
            zipCodeLabel.text = unwrappedAddress.email // email label
        }
    }
    
    @IBAction func addNewAddressButtonPressed(sender: AnyObject) {
        delegate?.addNewAddressButtonPressed()
    }

}
