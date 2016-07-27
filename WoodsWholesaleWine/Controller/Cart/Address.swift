//
//  Address.swift
//  WoodsWholesaleWine
//
//  Created by Incture Mac on 26/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import Foundation
import CoreData


class Address: NSManagedObject {
    
    @NSManaged var id: String? // primary key
    @NSManaged var address1: String?
    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var zip: String?
    @NSManaged var province: String?
    @NSManaged var city: String?
    @NSManaged var countryCode: String?
    @NSManaged var email: String?

}