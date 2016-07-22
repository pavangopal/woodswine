//
//  Helper.swift
//  Workbox
//
//  Created by Ratan D K on 07/12/15.
//  Copyright © 2015 Incture Technologies. All rights reserved.
//

import UIKit
import CoreData
import ReachabilitySwift

class Helper {
    
    class func clearAllCookies() {
        let storage = NSHTTPCookieStorage.sharedHTTPCookieStorage()
        let cookies = storage.cookies
        for cookie in cookies! {
            storage.deleteCookie(cookie)
        }
    }
    
    class func urlEncode(string: String) -> String {
        let encodedURL = string.stringByAddingPercentEncodingWithAllowedCharacters(NSCharacterSet.URLQueryAllowedCharacterSet())!
        return encodedURL
    }
    
   class func isConnectedToInternet() -> Bool{
        let reachability = try! Reachability.reachabilityForInternetConnection()
        if reachability.currentReachabilityStatus == .NotReachable {
            print("not connected")
            return false
        } else {
            print("connected")
            return true
        }
    }
    
    class func base64ForImage(image: UIImage) -> String? {
        guard let imageData = UIImagePNGRepresentation(image) else{
            return nil
        }
        return imageData.base64EncodedStringWithOptions([])
    }
    
    
    
    class func dateForString(dateString: String?) -> NSDate? {
        guard let unwrappedDateString = dateString where unwrappedDateString.characters.count > 0 else{
            return nil
        }
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone(abbreviation: ConstantDate.utcTimeZone)
        dateFormatter.dateFormat = ConstantDate.tzDateFormat
        let date = dateFormatter.dateFromString(unwrappedDateString)
        return date;
        
    }
    
    class func dateForDDMMYYYYString(dateString: String?) -> NSDate? {
        guard let unwrappedDateString = dateString where unwrappedDateString.characters.count > 0 else{
            return nil
        }
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone(abbreviation: ConstantDate.utcTimeZone)
        dateFormatter.dateFormat = ConstantDate.ddmmyyyyFormat
        let date = dateFormatter.dateFromString(unwrappedDateString)
        return date
    }
    
    class func dateForMMYYYYString(dateString: String?) -> NSDate? {
        guard let unwrappedDateString = dateString where unwrappedDateString.characters.count > 0 else{
            return nil
        }
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone(abbreviation: ConstantDate.utcTimeZone)
        dateFormatter.dateFormat = ConstantDate.MMMyyyyFormat
        let date = dateFormatter.dateFromString(unwrappedDateString)
        return date;
        
    }
    
    class func stringForDate(date:NSDate?, format:String) -> String {
        
        guard let date = date else {
            return kEmptyString
        }
        
        let dateFormatter = NSDateFormatter()
        dateFormatter.timeZone = NSTimeZone(abbreviation: ConstantDate.utcTimeZone)
        dateFormatter.dateFormat = format
        let dateString = dateFormatter.stringFromDate(date)
        return dateString;
    }
    
    class func stringForDateWithYearCorrection(date:NSDate?) -> String {
        
        
        guard let unwrappedDate = date else {
            return kEmptyString
        }
        let calander = NSCalendar.currentCalendar()
        let dateYear = calander.components([.Day , .Month , .Year], fromDate: unwrappedDate).year
        let currentYear =  calander.components([.Day , .Month , .Year], fromDate: NSDate()).year
        
        if dateYear == currentYear{
            let dateFormatter = NSDateFormatter()
            dateFormatter.timeZone = NSTimeZone(abbreviation: ConstantDate.utcTimeZone)
            dateFormatter.dateFormat = ConstantDate.dMMMM
            let dateString = dateFormatter.stringFromDate(unwrappedDate)
            return dateString;
        
        }else{
            let dateFormatter = NSDateFormatter()
            dateFormatter.timeZone = NSTimeZone(abbreviation: ConstantDate.utcTimeZone)
            dateFormatter.dateFormat = ConstantDate.dMMMMyyyy
            let dateString = dateFormatter.stringFromDate(unwrappedDate)
            return dateString;
        }
    }
    
    
    class func stringForDateWithYearCorrectionIncludingDayOfWeek(date:NSDate?) -> String {
        
        
        guard let unwrappedDate = date else {
            return kEmptyString
        }
        let calander = NSCalendar.currentCalendar()
        let dateYear = calander.components([.Day , .Month , .Year], fromDate: unwrappedDate).year
        let currentYear =  calander.components([.Day , .Month , .Year], fromDate: NSDate()).year
        
        if dateYear == currentYear{
            let dateFormatter = NSDateFormatter()
            dateFormatter.timeZone = NSTimeZone(abbreviation: ConstantDate.utcTimeZone)
            dateFormatter.dateFormat = "E, MMM d"
            let dateString = dateFormatter.stringFromDate(unwrappedDate)
            return dateString;
            
        }else{
            let dateFormatter = NSDateFormatter()
            dateFormatter.timeZone = NSTimeZone(abbreviation: ConstantDate.utcTimeZone)
            dateFormatter.dateFormat = "E, MMM d yyyy"
            let dateString = dateFormatter.stringFromDate(unwrappedDate)
            return dateString;
        }
    }
    
    class func stringFromDateInHumanReadableFormat(date: NSDate?, dateStype : NSDateFormatterStyle, timeStyle: NSDateFormatterStyle) -> String? {
        guard let unwrappedDate = date else{
            return nil
        }
        let dateFormatter = NSDateFormatter()
        dateFormatter.dateStyle = dateStype
        dateFormatter.timeStyle = timeStyle
        dateFormatter.doesRelativeDateFormatting = true
        let dateString = dateFormatter.stringFromDate(unwrappedDate)
        return dateString
    }
    
    class func isValidEmail(string:String) -> Bool {
        let emailRegEx = "^[a-zA-Z0-9.!#$%&'*+/=?^_`{|}~-]+@[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?(?:\\.[a-zA-Z0-9](?:[a-zA-Z0-9-]{0,61}[a-zA-Z0-9])?)*$"
        let emailTest = NSPredicate(format:"SELF MATCHES %@", emailRegEx)
        return emailTest.evaluateWithObject(string)
    }
    
    class func nsurlFromString(urlString: String?) -> NSURL? {
        guard let unwrappedUrlString = urlString where unwrappedUrlString.characters.count > 0 else{
            return nil
        }
        let url = NSURL(string: "\(unwrappedUrlString)")
                print(url)
        return url;
    }
    
    class func nsurlFromStringWithImageSize(urlString: String?, imageSize : ImageSizeConstant ) -> NSURL? {
        guard let unwrappedUrlString = urlString where unwrappedUrlString.characters.count > 0 else{
            return nil
        }
        let url = NSURL(string: "\(unwrappedUrlString)")
                print(url)
        return url;
    }
    

    
    class func lengthOfStringWithoutSpace(string:String?) -> Int {
        guard let text = string else {
            return 0
        }
        
        let trimmedText = text.stringByTrimmingCharactersInSet(NSCharacterSet.whitespaceAndNewlineCharacterSet())
        return trimmedText.characters.count
    }
    

    
    class func timeInHMformatForMinutes(minutes: Int) -> String {
        let hours = minutes / 60
        let mins = minutes % 60
        return "\(hours)h" + " \(mins)m"
    }

    
    class func getBoldAttributtedString(text1:String?,text2:String?,font:CGFloat) -> NSMutableAttributedString{
    
        let attributedString = NSMutableAttributedString(string: text1 ?? "", attributes: [NSFontAttributeName: UIFont.boldSystemFontOfSize(font)])
        
        let tempStr = NSMutableAttributedString(string: " ")
        tempStr.appendAttributedString(NSMutableAttributedString(string: text2 ?? ""))
        attributedString.appendAttributedString(tempStr)
        
       return attributedString
    }
    
    class func concatinateAttributtedString(text1:String?,text2:NSAttributedString?) -> NSMutableAttributedString{
        
        let attributedString = NSMutableAttributedString(string: text1 ?? "", attributes: [NSForegroundColorAttributeName: UIColor.lightGrayColor()])
        
        let tempStr = NSMutableAttributedString(string: " ")
        tempStr.appendAttributedString(text2 ?? NSMutableAttributedString(string: ""))
        attributedString.appendAttributedString(tempStr)
        
        return attributedString
    }
    
    class func setBorderForButtons(button:UIButton,color:UIColor){
        button.backgroundColor = UIColor.whiteColor()
        button.titleLabel?.font = UIFont.systemFontOfSize(13)
        button.setTitleColor(color, forState: .Normal)
        button.layer.cornerRadius = 5
        button.clipsToBounds = true
        button.layer.borderColor = color.CGColor
        button.layer.borderWidth = 1
    }
  
    class func createNotificationBadge(badgeValue : Int?) -> UIButton {
        let notificationImage = UIImage()
        let button = UIButton(frame: CGRect(x: 0 , y: 0, width: 25 , height: 25))
        button.setBackgroundImage(notificationImage, forState: .Normal)
        
        if let unwrappedBadgeValue = badgeValue {
            
            let badgeLabel = UILabel(frame: CGRect(x: button.frame.midX + 1, y: -5 , width: 15, height: 15))
            badgeLabel.text = String(unwrappedBadgeValue)
            badgeLabel.sizeToFit()
            if badgeLabel.frame.width < 18 {
                badgeLabel.frame = CGRect(x: button.frame.midX + 1, y: -5, width: 15, height: 15)
            }
            badgeLabel.textAlignment = .Center
            badgeLabel.textColor = UIColor.whiteColor()
            badgeLabel.font = UIFont.systemFontOfSize(12)
            badgeLabel.backgroundColor = UIColor.redColor()
            badgeLabel.clipToCircularCorner()
            button.addSubview(badgeLabel)
        }
        return button
    }
    
    class func getImageFromSCR(imageSrcString:String?) -> UIImage? {
        guard let unwrappedUrlString = imageSrcString where unwrappedUrlString.characters.count > 0 else{
            return nil
        }
        var image = UIImage()
        
        if  let imageUrl = NSURL(string: unwrappedUrlString){
            if  let imageData = NSData(contentsOfURL: imageUrl){
                image = UIImage(data: imageData)!
            }
        }
        return image
    }
    
    
    class func heightForText(font: UIFont, width: CGFloat,text:String) -> CGFloat {
        
        let rect = NSString(string: text).boundingRectWithSize(CGSize(width: width, height: CGFloat(MAXFLOAT)), options: .UsesLineFragmentOrigin, attributes: [NSFontAttributeName: font], context: nil)
        return ceil(rect.height + 16)
    }

}

func compressedDataForImage(image: UIImage?) -> UIImage? {
    guard let originaImage = image else {
        return nil
    }
    
    var compression: CGFloat = 0.9
    let maxCompression: CGFloat = 0.1
    let maxFileSize: Int = 300000    // 300 KB
    
    if var imageData: NSData = UIImageJPEGRepresentation(originaImage, compression) {
        
        while (imageData.length > maxFileSize && compression > maxCompression)
        {
            compression -= 0.1
            imageData = UIImageJPEGRepresentation(originaImage, compression)!
        }
        
        return UIImage(data: imageData)
    }
    
    return nil
}


class UIBorderedLabel: UILabel {
    
    var topInset:       CGFloat = 0
    var rightInset:     CGFloat = 0
    var bottomInset:    CGFloat = 0
    var leftInset:      CGFloat = 8
    
    override func drawTextInRect(rect: CGRect) {
        let insets: UIEdgeInsets = UIEdgeInsets(top: topInset, left: leftInset, bottom: bottomInset, right: rightInset)
        super.drawTextInRect(UIEdgeInsetsInsetRect(rect, insets))
    }
    
    override func intrinsicContentSize() -> CGSize {
        var intrinsicSuperViewContentSize = super.intrinsicContentSize()
        intrinsicSuperViewContentSize.height += topInset + bottomInset
        intrinsicSuperViewContentSize.width += leftInset + rightInset
        return intrinsicSuperViewContentSize
    }
    

}
