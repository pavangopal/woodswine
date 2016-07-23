//
//  UserDefaults.swift
//  Workbox
//
//  Created by Ratan D K on 07/12/15.
//  Copyright © 2015 Incture Technologies. All rights reserved.
//

import UIKit
import Alamofire


private let ksetLinkedInAccessTokenAccessToken = "kLinkedInAccessToken"
private let kFacebookAccessToken = "kFacebookAccessToken"
private let kDeviceId = "kDeviceId"
private let kDeviceToken = "kDeviceToken"
private let kUser = "kUser"
private let kUserId = "kUserId"
private let kEmail = "kEmail"
private let kDisplayName = "kDisplayName"


class UserDefaults {
    
    static let sharedInstance = NSUserDefaults.standardUserDefaults()

 
    class func linkedInAccessToken() -> String? {
        return sharedInstance.valueForKey(ksetLinkedInAccessTokenAccessToken) as? String
    }
    
    class func facebookAccessToken() -> String? {
        return sharedInstance.valueForKey(kFacebookAccessToken) as? String
    }
    
    class func setLinkedInAccessToken(token: String?) {
        sharedInstance.setValue(token, forKey: ksetLinkedInAccessTokenAccessToken)
        sharedInstance.synchronize()
    }
    
    class func setFacebookAccessToken(token : String?){
        sharedInstance.setValue(token, forKey: kFacebookAccessToken)
        sharedInstance.synchronize()
    }
    
    class func deviceToken() -> String? {
        return sharedInstance.valueForKey(kDeviceToken) as? String
    }
    
    class func setDeviceToken(token: String?) {
        sharedInstance.setValue(token, forKey: kDeviceToken)
        sharedInstance.synchronize()
    }
    
    class func userId() -> String? {
        return sharedInstance.valueForKey(kUserId) as? String
    }
    
    // MARK: temp
    
    class func loggedInEmail() -> String? {
        return sharedInstance.valueForKey(kEmail) as? String
    }
    
    class func setLoggedInEmail(email: String?) {
        sharedInstance.setValue(email, forKey: kEmail)
        sharedInstance.synchronize()
    }
    
    class func loggedInName() -> String? {
        return sharedInstance.valueForKey(kDisplayName) as? String
    }
    
    class func setLoggedInName(name: String?) {
        sharedInstance.setValue(name, forKey: kDisplayName)
        sharedInstance.synchronize()
    }

}
