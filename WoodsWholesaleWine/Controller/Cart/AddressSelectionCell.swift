//
//  AddressSelectionCell.swift
//  WoodsWholesaleWine
//
//  Created by Incture Mac on 26/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit

class AddressSelectionCell: UITableViewCell {

    @IBOutlet weak var firstNameLabel: UILabel!
    @IBOutlet weak var lastNameLabel: UILabel!
    @IBOutlet weak var addressLabel: UILabel!
    @IBOutlet weak var citylabel: UILabel!
    @IBOutlet weak var provinceLabel: UILabel!
    @IBOutlet weak var zipCodeLabel: UILabel!
    @IBOutlet weak var countryCodeLabel: UILabel!
    
    
    override func awakeFromNib() {
        super.awakeFromNib()
        // Initialization code
    }

    override func setSelected(selected: Bool, animated: Bool) {
        super.setSelected(selected, animated: animated)

        // Configure the view for the selected state
    }

    func updateCellData(address:Address?){
        if let unwrappedAddress = address{
        firstNameLabel.text = unwrappedAddress.firstName
        lastNameLabel.text = unwrappedAddress.lastName
        addressLabel.text = unwrappedAddress.address1
        citylabel.text = unwrappedAddress.city
        provinceLabel.text = unwrappedAddress.province
        zipCodeLabel.text = unwrappedAddress.zip
        countryCodeLabel.text = unwrappedAddress.countryCode
        }
        else{
            print("Unwrapping of adress failed in AddressSelectionCell file")
        }
    }
}
