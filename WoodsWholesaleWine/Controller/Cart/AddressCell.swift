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
            addressLabel.text = (unwrappedAddress.firstName ?? "") + kSpaceString + (unwrappedAddress.lastName ?? "" ) + kSpaceString + (unwrappedAddress.address1 ?? "")
            cityLabel.text = unwrappedAddress.city
            zipCodeLabel.text = unwrappedAddress.zip
        }
    }
    
    @IBAction func addNewAddressButtonPressed(sender: AnyObject) {
        delegate?.addNewAddressButtonPressed()
    }
    
    
//    - (void)updateWithDictionary:(NSDictionary *)dictionary
//    {
//    self.address1 = dictionary[@"address1"];
//    self.address2 = dictionary[@"address2"];
//    self.city = dictionary[@"city"];
//    self.company = dictionary[@"company"];
//    self.firstName = dictionary[@"first_name"];
//    self.lastName = dictionary[@"last_name"];
//    self.phone = dictionary[@"phone"];
//    
//    self.country = dictionary[@"country"];
//    self.countryCode = dictionary[@"country_code"];
//    self.province = [dictionary buy_objectForKey:@"province"];
//    self.provinceCode = [dictionary buy_objectForKey:@"province_code"];
//    self.zip = dictionary[@"zip"];
//    }
}
