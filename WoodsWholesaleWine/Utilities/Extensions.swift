//
//  Extensions.swift
//  Workbox
//
//  Created by Ratan D K on 15/12/15.
//  Copyright © 2015 Incture Technologies. All rights reserved.
//

import UIKit
import Kingfisher

extension UIStoryboard {
    class func mainStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Main", bundle: NSBundle.mainBundle())
    }
    class func leftMenuStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "LeftMenu", bundle: NSBundle.mainBundle())
    }
    class func ordersStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Orders", bundle: NSBundle.mainBundle())
    }
    class func cartStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Cart", bundle: NSBundle.mainBundle())
    }
    class func accountStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Account", bundle: NSBundle.mainBundle())
    }
    class func loginStoryboard() -> UIStoryboard {
        return UIStoryboard(name: "Login", bundle: NSBundle.mainBundle())
    }
    
}

extension UIColor {
    class func navBarColor() -> UIColor {
        return UIColor(red: 62/255.0, green: 61/255.0, blue: 122/255.0, alpha:1)
    }
    
    class func navBarItemColor() -> UIColor{
        return UIColor.whiteColor()
    }
    
    class func sectionBackGroundColor() -> UIColor{
        return UIColor(red: 247/255, green: 247/255, blue: 247/255, alpha: 1)
    }
}

extension UINavigationController{
    
    func setupNavigationBar() {
        self.navigationBar.barTintColor = UIColor.navBarColor()
        self.navigationBar.tintColor = UIColor.navBarItemColor()
        self.navigationBar.titleTextAttributes = [NSForegroundColorAttributeName: UIColor.whiteColor()]
        self.navigationItem.leftBarButtonItem?.tintColor = UIColor.navBarItemColor()
        self.navigationItem.rightBarButtonItem?.tintColor = UIColor.navBarItemColor()
        self.navigationItem.titleView?.tintColor = UIColor.navBarItemColor()

    }
}





protocol ToBool {}
extension ToBool {
    var boolValue: Bool {
        return NSString(string: String(self)).boolValue
    }
}
extension String : ToBool{}
extension Int : ToBool{}


extension String{
    func toNSURL(imageSize : ImageSizeConstant) -> NSURL? {
        return Helper.nsurlFromStringWithImageSize(self, imageSize: imageSize)
    }
}


extension UIViewController {
    func addViewController (anyController: AnyObject) {
        if let viewController = anyController as? UIViewController {
            addChildViewController(viewController)
            view.addSubview(viewController.view)
            viewController.didMoveToParentViewController(self)
        }
    }
    
    func removeViewController (anyController: AnyObject) {
        if let viewController = anyController as? UIViewController {
            viewController.willMoveToParentViewController(nil)
            viewController.view.removeFromSuperview()
            viewController.removeFromParentViewController()
        }
    }
}
extension String {
    var camelCasedString: String {
        let source = self
        if source.characters.contains(" ") {
            let first = source.substringToIndex(source.startIndex.advancedBy(1))
            let cammel = NSString(format: "%@", (source as NSString).capitalizedString.stringByReplacingOccurrencesOfString(" ", withString: "", options: [], range: nil)) as String
            let rest = String(cammel.characters.dropFirst())
            return "\(first)\(rest)"
        } else {
            let first = (source as NSString).lowercaseString.substringToIndex(source.startIndex.advancedBy(1))
            let rest = String(source.characters.dropFirst())
            return "\(first)\(rest)"
        }
    }
    
    var captilizedEachWordString: String{
        return self.capitalizedStringWithLocale(NSLocale.currentLocale())
    }
}

extension UITableView {
    ///This method register cells in a tableview using strings [Make sure name of cell Class and cell identifier is same]
    func registerNibWithStrings(classStrings : String...){
        for arg: String in classStrings {
            self.registerNib(UINib(nibName: arg, bundle: nil), forCellReuseIdentifier: arg)
        }
    }
}


protocol CellForTable {}
extension CellForTable {
    static func cellFromClassType(tableView : UITableView,indexPath : NSIndexPath) -> Self {
        let cell = tableView.dequeueReusableCellWithIdentifier(String(Self), forIndexPath: indexPath)
        return cell as! Self
    }
    
}



protocol CellBackgroundProtocol{}
extension CellBackgroundProtocol where Self : UITableViewCell {
    
    static func setCellBackgroundView(cell: Self) {
        
        let imageView = UIImageView()
        imageView.image = AssetImage.RoundedCornerShadow.image
        cell.backgroundView = imageView
        
    }
    
    
}
extension UITableViewCell : CellBackgroundProtocol{}
extension UITableViewCell {
    func setZeroInset(){
        let inset = UIEdgeInsetsZero
        self.separatorInset = inset
        self.preservesSuperviewLayoutMargins = false
        self.layoutMargins = inset
    }
}


extension AssetImage {
    var image : UIImage {
        if let unwrappedImage = UIImage(named: self.rawValue){
            return unwrappedImage
        }
        else{
            print("ERROR: Asset with string '\(self.rawValue)' not found! [showing default image instead, Please verify asset string]")
            return UIImage(named: "errorImage")!
        }
    }
}


protocol UIViewLoading {}
extension UIView : UIViewLoading {}

extension UIViewLoading where Self : UIView {
    static func loadArrayFromNib() -> [Self] {
        let nibName = "\(self)".characters.split{$0 == "."}.map(String.init).last!
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiateWithOwner(self, options: nil) as! [Self]
    }
    static func loadFromNib() -> Self {
        let nibName = "\(self)".characters.split{$0 == "."}.map(String.init).last!
        let nib = UINib(nibName: nibName, bundle: nil)
        return nib.instantiateWithOwner(self, options: nil).first as! Self
    }
    
}
extension UIImage {
    
    var decompressedImage: UIImage {
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        drawAtPoint(CGPointZero)
        let decompressedImage = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return decompressedImage
    }
    
    
    
}

extension UIView {
    func fadeIn(duration: NSTimeInterval = 1.0, delay: NSTimeInterval = 0.0, completion: ((Bool) -> Void) = {(finished: Bool) -> Void in}) {
        UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.alpha = 1.0
            }, completion: completion)  }
    
    func fadeOut(duration: NSTimeInterval = 1.0, delay: NSTimeInterval = 0.0, completion: (Bool) -> Void = {(finished: Bool) -> Void in}) {
        UIView.animateWithDuration(duration, delay: delay, options: UIViewAnimationOptions.CurveEaseIn, animations: {
            self.alpha = 0.0
            }, completion: completion)
    }
    
    func clipToCircularCorner(){
        self.layer.cornerRadius = self.bounds.height/2
        self.clipsToBounds = true
    }
    
}

extension UIImageView{
    /// Use this for setting image to any imageView using OPTIONAL url (e.g. avatarUrl) and an appropriate placeholder image.
    func setImageWithOptionalUrl(url : NSURL?, placeholderImage: UIImage){
        if let unwrappedUrl = url{
            self.kf_setImageWithURL(unwrappedUrl, placeholderImage: placeholderImage)
        }
        else{
            self.image = placeholderImage
        }
    }
    
    /// Use this for setting image to any imageView using OPTIONAL url (e.g. avatarUrl) and an appropriate placeholder image.
    func setImageWithOptionalUrlWithoutPlaceholder(url : NSURL?){
        if let unwrappedUrl = url{
            self.kf_setImageWithURL(unwrappedUrl)
        }
    }
    
    func clipToCircularImageView(){
        self.layer.cornerRadius = self.bounds.width/2
        self.clipsToBounds = true
    }
    
    func setColor(color:UIColor){
        self.image!.imageWithRenderingMode(.AlwaysTemplate)
        self.tintColor = color
    }
    
}


extension _ArrayType where Generator.Element : Equatable{
    mutating func removeObject(object : Self.Generator.Element) {
        while let index = self.indexOf(object){
            self.removeAtIndex(index)
        }
    }
}

extension _ArrayType where Generator.Element : Equatable{
    mutating func indexOfObject(object : Self.Generator.Element) -> Index?{
        if let index = self.indexOf(object){
            return index
        }
        else{
            return nil
        }
    }
}

public extension UIWindow {
    public var visibleViewController: UIViewController? {
        return UIWindow.getVisibleViewControllerFrom(self.rootViewController)
    }
    
    public static func getVisibleViewControllerFrom(vc: UIViewController?) -> UIViewController? {
        if let nc = vc as? UINavigationController {
            return UIWindow.getVisibleViewControllerFrom(nc.visibleViewController)
        } else if let tc = vc as? UITabBarController {
            return UIWindow.getVisibleViewControllerFrom(tc.selectedViewController)
        } else {
            if let pvc = vc?.presentedViewController {
                return UIWindow.getVisibleViewControllerFrom(pvc)
            } else {
                return vc
            }
        }
    }
}

func getTopViewController() -> UIViewController? {
    let appDelegate = UIApplication.sharedApplication().delegate
    if let window = appDelegate!.window {
        return window?.visibleViewController
    }
    return nil
}





extension NSDate {
    
    public var timeAgoSimple: String {
        let components = self.dateComponents()
        
        if components.year > 0 {
            return stringFromFormat("%%d%@yr", withValue: components.year)
        }
        
        if components.month > 0 {
            return stringFromFormat("%%d%@mo", withValue: components.month)
        }
        
        // TODO: localize for other calanders
        if components.day >= 7 {
            let value = components.day/7
            return stringFromFormat("%%d%@w", withValue: value)
        }
        
        if components.day > 0 {
            return stringFromFormat("%%d%@d", withValue: components.day)
        }
        
        if components.hour > 0 {
            return stringFromFormat("%%d%@h", withValue: components.hour)
        }
        
        if components.minute > 0 {
            return stringFromFormat("%%d%@m", withValue: components.minute)
        }
        
        if components.second > 0 {
            return stringFromFormat("%%d%@s", withValue: components.second )
        }
        
        return ""
    }
    
    public var timeAgo: String {
        let components = self.dateComponents()
        
        if components.year > 0 {
            
            
             let dateString = Helper.stringForDateWithYearCorrection(self)
                return dateString
//            }else{
//                if components.year < 2 {
//                    return "Last year"
//                } else {
//                    return stringFromFormat("%%d %@years ago", withValue: components.year)
//                }
//            }
        }
        
        if components.month > 0 {
            let dateString = Helper.stringForDateWithYearCorrection(self)
                return dateString
//            }else{
//                if components.month < 2 {
//                    return "Last month"
//                } else {
//                    return stringFromFormat("%%d %@months ago", withValue: components.month)
//                }
//            }
        }
        
        if components.day >= 7 {
            let dateString = Helper.stringForDateWithYearCorrection(self)
                return dateString
//            }else{
//                let week = components.day/7
//                if week < 2 {
//                    return "Last week"
//                } else {
//                    return stringFromFormat("%%d %@weeks ago", withValue: week)
//                }
//            }
        }
        
        if components.day > 0 {
            if components.day < 2 {
//                return "Yesterday,\(Helper.stringForDate(self,format: ConstantDate.hma))"
                return "Yesterday"

            } else  {
                
                let dateString = Helper.stringForDateWithYearCorrection(self)
                    return dateString
//                }else{
//                    return stringFromFormat("%%d %@days ago", withValue: components.day)
//                }
//            }
            }
        }
        
        if components.hour > 0 {
            if components.hour < 2 {
                return "1 hr"
            } else  {
                return stringFromFormat("%%d %@hrs", withValue: components.hour)
            }
        }
        
        if components.minute > 0 {
            if components.minute < 2 {
                return "1 min"
            } else {
                return stringFromFormat("%%d %@min", withValue: components.minute)
            }
        }
        
        if components.second >= 0 {
            if components.second < 5 {
                return "Just now"
            } else {
                return stringFromFormat("%%d %@sec", withValue: components.second)
            }
        }
        if components.second < 0 {
            return "Just now"
        }
        return ""
    }
    
    private func dateComponents() -> NSDateComponents {
        let calander = NSCalendar.currentCalendar()
        return calander.components([.Second, .Minute, .Hour, .Day, .Month, .Year], fromDate: self, toDate: NSDate(), options: [])
    }
    
    private func stringFromFormat(format: String, withValue value: Int) -> String {
        let localeFormat = String(format: format, getLocaleFormatUnderscoresWithValue(Double(value)))
        return String(format: localeFormat, value)
    }
    
    private func getLocaleFormatUnderscoresWithValue(value: Double) -> String {
        guard let localeCode = NSLocale.preferredLanguages().first else {
            return ""
        }
        
        // Russian (ru) and Ukrainian (uk)
        if localeCode == "ru" || localeCode == "uk" {
            let XY = Int(floor(value)) % 100
            let Y = Int(floor(value)) % 10
            
            if Y == 0 || Y > 4 || (XY > 10 && XY < 15) {
                return ""
            }
            
            if Y > 1 && Y < 5 && (XY < 10 || XY > 20) {
                return "_"
            }
            
            if Y == 1 && XY != 11 {
                return "__"
            }
        }
        
        return ""
    }
    
    func startOfMonth(NoOfMonths : Int, currentDate : NSDate) -> NSDate? {
        let calendar = NSCalendar.currentCalendar()
        if let minusOneMonthDate = dateByAddingMonths(NoOfMonths, currentDate: currentDate) {
            let minusOneMonthDateComponents = calendar.components([.Year, .Month], fromDate: minusOneMonthDate)
            
            let startOfMonth = calendar.dateFromComponents(minusOneMonthDateComponents)
            return startOfMonth
                
        }
        return nil
    }
    
    func dateByAddingMonths(monthsToAdd : Int, currentDate : NSDate) -> NSDate? {
        
        let calendar = NSCalendar.currentCalendar()
        let months = NSDateComponents()
        months.month = monthsToAdd
        return calendar.dateByAddingComponents(months, toDate: currentDate, options: [])
    }
    
     func endOfMonth(NoOfMonths : Int, currentDate : NSDate ) -> NSDate? {
        
        let calendar = NSCalendar.currentCalendar()
        if let plusOneMonthDate = dateByAddingMonths(NoOfMonths, currentDate: currentDate) {
            let plusOneMonthDateComponents = calendar.components([.Year, .Month], fromDate: plusOneMonthDate)
            
            let endOfMonth = calendar.dateFromComponents(plusOneMonthDateComponents)?.dateByAddingTimeInterval(-1)
            
            return endOfMonth
        }
        return nil
    }
    
}


