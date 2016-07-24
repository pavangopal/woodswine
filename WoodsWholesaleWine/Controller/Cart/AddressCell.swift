//
//  AddressCell.swift
//  WoodsWholesaleWine
//
//  Created by Incture Mac on 25/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit

class AddressCell: UITableViewCell {

    @IBOutlet weak var emailLabel: UILabel!
    @IBOutlet weak var phoneNumberLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var selectAddressLabel: UILabel!
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateAddress(){
        
    }
    
    @IBAction func addNewAddressButtonPressed(sender: AnyObject) {
        
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
