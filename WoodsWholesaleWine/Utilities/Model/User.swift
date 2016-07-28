//
//  User.swift
//  WoodsWholesaleWine
//
//  Created by Incture Mac on 28/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import Foundation
import CoreData


class User: NSManagedObject {
    
    @NSManaged var firstName: String?
    @NSManaged var lastName: String?
    @NSManaged var phoneNumber: String?
    @NSManaged var emailAddress: String?
    @NSManaged var image: String?
    @NSManaged var id: String? // primary key

    
}