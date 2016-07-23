//
//  Constants.h
//  Workbox
//
//  Created by Ratan D K on 07/12/15.
//  Copyright © 2015 Incture Technologies. All rights reserved.
//

import Foundation
import UIKit

let kEmptyString: String = ""
let kServerKeyStatus: String = "status"
let kServerKeyMessage: String = "message"
let kServerKeyFailure: String = "failure"
let kServerKeySuccess: String = "success"
let kServerKeyData: String = "data"
let kLoadingCellTag = 121212  //Any Integer Value
let kSpaceString = "\u{200c}"


enum ImageSizeConstant : String {
    case Thumbnail = "thumbnail"
    case Large = "large"
    case Medium = "medium"
}


public enum ErrorCode : Int {
    case Forbidden = 403
    case PageNotFound = 404
    case SimulatorError = 3010
}

struct ConstantUI {
    static let defaultPadding : CGFloat = 8.0
    static let defaultPaddingByTwo : CGFloat = 4.0
    static let screenWidth = UIScreen.mainScreen().bounds.width
    static let cardWidth = screenWidth - CGFloat(2*16)
    static let actionViewHeight : CGFloat = 38
    static let commentViewHeight : CGFloat = 48
    static let userProfileWidth : CGFloat = 50
}


struct ConstantDate {
    static let tzDateFormat = "yyyy'-'MM'-'dd'T'HH':'mm':'ss'.'SSS'Z'"
    static let ddmmyyyyFormat = "ddMMyyyy"
    static let MMMyyyyFormat = "MMMyyyy"
    static let utcTimeZone = "UTC"
    static let dMMMM = "d MMM"
    static let dMMMMyyyy = "d MMM, yyyy"
    static let hma = "h:m a"
    
}

struct ConstantIdentifier {
    struct Segue {
        static let cardToDetail = "CardToDetail"
    }
}

struct ConstantColor {
    static let CWBlue = UIColor(red: 0/255.0, green: 132/255.0, blue: 255/255.0, alpha: 1.0)
    static let CWOrange = UIColor(red: 255/255.0, green: 165/255.0, blue: 0/255.0, alpha: 1.0)
    static let CWGreen = UIColor(red: 32/255.0, green: 169/255.0, blue: 117/255.0, alpha: 1.0)
    static let CWYellow = UIColor(red: 255/255.0, green: 211/255.0, blue: 92/255.0, alpha: 1.0)
    static let CWRed = UIColor(red: 212/255.0, green: 73/255.0, blue: 66/255.0, alpha: 1.0)
    static let CWButtonGray = UIColor.grayColor()
    static let CWLightGray = UIColor(red: 230/255.0, green: 230/255.0, blue: 230/255.0, alpha: 1.0)
    static let CWBlackWithAlpa = UIColor(red: 0, green: 0, blue: 0, alpha: 0.1)
    
}

//MARK: - ENUM of Assets
// Declare enum for required images here and there will be no any dependency on string named UIImage.
// Usages: imageview.image = AssetImage.ProfileImage.image
public enum AssetImage : String {
    case RoundedCornerShadow = "card background"
    case arrow = "arrow"
    case navBarIcon = "sideNav"
    case account = "account"
    case add = "add"
    case apple = "apple"
    case catlog = "catlog"
    case close = " close"
    case comment = "comment"
    case credit = "credit"
    case creditcard = "creditcard"
    case envelop = "envelop"
    case filter = "filter"
    case help = "help"
    case home = "home"
    case houseprice = "houseprice"
    case invitefriends = "invitefriends"
    case item = "item"
    case leftarrow = "leftarrow"
    case like = "like"
    case minus = "minus"
    case offers = "offers"
    case orders = "orders"
    case password = "password"
    case pencil = "pencil"
    case redhome = "redhome"
    case rightarrow = "rightarrow"
    case search = "search"
    case sharewine = "sharewine"
    case shipping = "shipping"
    case shippingcart = "shippingcart"
    case skip = "skip"
    case slider = "slider"
    case starSolid = "star"
    case starEmpty = "star2"
    case stargold = "stargold"
    case truck = "truck"
    case ups = "ups"
    case user = "user"
    case verify = "verify"
    case wishlist = "wishlist"
    case cherry = "cherry"
    case profile = "profile_icon"
    
   }

public enum TabName : String {
    case Catalog = "Catalog"
    case Cart = "Cart"
    case Orders = "Orders"
    case Account = "Account"
    
}
