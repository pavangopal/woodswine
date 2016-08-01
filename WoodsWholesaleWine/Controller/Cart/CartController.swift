//
//  CartController.swift
//  WoodsWholesaleWine
//
//  Created by Pavan Gopal on 21/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit
import Buy


protocol CartControllerDelegate {
    func updateDashBoardController()
}

class CartController: UIViewController,PayPalPaymentDelegate {

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var heightConstraint: NSLayoutConstraint!
    
    @IBOutlet weak var proceedToCheckoutButton: UIButton!
    @IBOutlet weak var buyWithApplePayButton: UIButton!
    @IBOutlet weak var buttonView: UIView!
    
    var addressFromCoreData : [Address]?
    var delegate : CartControllerDelegate?
    var checkout = BUYCheckout(cart: CartManager.instance)
 
    
    var payPalConfig = PayPalConfiguration()
    
    var environment:String = PayPalEnvironmentNoNetwork {
        willSet(newEnvironment) {
            if (newEnvironment != environment) {
                PayPalMobile.preconnectWithEnvironment(newEnvironment)
            }
        }
    }
    
    var acceptCreditCards: Bool = true {
        didSet {
            payPalConfig.acceptCreditCards = acceptCreditCards
        }
    }
    
    override func viewDidLoad() {
        super.viewDidLoad()

        tableView.estimatedRowHeight = 44
        tableView.rowHeight = UITableViewAutomaticDimension
        updateLeftNavBarItems()
        
        proceedToCheckoutButton.setImage(AssetImage.credit.image, forState: .Normal)
        proceedToCheckoutButton.imageEdgeInsets = UIEdgeInsetsMake(5, 0, 0, 5)
        proceedToCheckoutButton.setTitle("Checkout", forState: .Normal)
        buyWithApplePayButton.setImage(AssetImage.apple.image, forState: .Normal)
        buyWithApplePayButton.imageEdgeInsets = UIEdgeInsetsMake(5, 5, 5, 10)
        tableView.tableFooterView = UIView(frame: CGRectZero)
        CartManager.instance.ShippingAddress = Helper.fetchAllAddress().first
        buyWithApplePayButton.setTitle("Pay", forState: .Normal)
        
        configurePayPal()
        // Do any additional setup after loading the view.
    }

    func configurePayPal(){
        
        payPalConfig.acceptCreditCards = acceptCreditCards;
        payPalConfig.merchantName = "Siva Ganesh Inc."
        payPalConfig.merchantPrivacyPolicyURL = NSURL(string: "https://www.sivaganesh.com/privacy.html")
        payPalConfig.merchantUserAgreementURL = NSURL(string: "https://www.sivaganesh.com/useragreement.html")
        payPalConfig.languageOrLocale = NSLocale.preferredLanguages()[0]
        payPalConfig.payPalShippingAddressOption = .PayPal;
        
        PayPalMobile.preconnectWithEnvironment(environment)
        
    }
    
    
    // PayPalPaymentDelegate
    
    func payPalPaymentDidCancel(paymentViewController: PayPalPaymentViewController!) {
        print("PayPal Payment Cancelled")
        paymentViewController?.dismissViewControllerAnimated(true, completion: nil)
    }
    
    func payPalPaymentViewController(paymentViewController: PayPalPaymentViewController!, didCompletePayment completedPayment: PayPalPayment!) {
        
        print("PayPal Payment Success !")
        paymentViewController?.dismissViewControllerAnimated(true, completion: { () -> Void in
            // send completed confirmaion to your server
            print("Here is your proof of payment:\n\n\(completedPayment.confirmation)\n\nSend this to your server for confirmation and fulfillment.")
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }

    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        tableView.reloadData()
    }
    
    func updateLeftNavBarItems() {
        
        let menuItem = UIBarButtonItem.init(title: "Clear", style: UIBarButtonItemStyle.Plain, target: self, action: #selector(CartController.clearCartButtonPressed))
        
        
        navigationItem.leftBarButtonItems = [menuItem]
    }
    
    func clearCartButtonPressed(){
        CartManager.instance.clearCart()
        
            let tabArray = self.tabBarController?.tabBar.items as NSArray!
            let tabItem = tabArray.objectAtIndex(1) as! UITabBarItem
            
            tabItem.badgeValue = String(CartManager.instance.lineItems.count)
        delegate?.updateDashBoardController()
        tableView.reloadData()
    }
}

extension CartController : UITableViewDelegate,UITableViewDataSource,CartCellDelegate,AddressCellDelegate{
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 4
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        switch section{
        case 0: return(CartManager.instance.lineItems.count > 0) ?  CartManager.instance.lineItems.count :  0
        case 1: return 3
        case 2 : return 4
        case 3: return 1
        default :
            return 0
        }
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch indexPath.section {
        case 0:
            let cartCell = tableView.dequeueReusableCellWithIdentifier("CartCell", forIndexPath: indexPath) as! CartCell
            cartCell.delegate = self
            cartCell.updateCellData(CartManager.instance.lineItems[indexPath.row],index: indexPath)
            return cartCell
        case 1:
            let priceCell = tableView.dequeueReusableCellWithIdentifier("PriceCell", forIndexPath: indexPath) as! PriceCell
            priceCell.updatePriceCelWithData(indexPath.row)
            return priceCell
        case 2:
            let couponCell = tableView.dequeueReusableCellWithIdentifier("CouponCell", forIndexPath: indexPath) as! CouponCell
            couponCell.updateCouponCellWithData(indexPath.row)
            return couponCell
        case 3 :
            let addressCell = tableView.dequeueReusableCellWithIdentifier("AddressCell", forIndexPath: indexPath) as! AddressCell
            addressCell.delegate = self
            addressCell.updateAddress(CartManager.instance.ShippingAddress)
            return addressCell
        default:
            return UITableViewCell()
        }
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0
    }
    
    func updateCart(){
        tableView.reloadData()
    }
    
    func addNewAddressButtonPressed(){
        addressFromCoreData = Helper.fetchAllAddress()
        if addressFromCoreData?.count > 0{
            let addressSelectionController = UIStoryboard.cartStoryboard().instantiateViewControllerWithIdentifier(String(AddressSelectionController)) as! AddressSelectionController
//            addressSelectionController.delegate = self
            let nc = UINavigationController.init(rootViewController: addressSelectionController)
            presentViewController(nc, animated: true, completion: nil)
        }
        else{
            let addressCreationController = UIStoryboard.cartStoryboard().instantiateViewControllerWithIdentifier(String(AddressController)) as! AddressController
            
            let nc = UINavigationController.init(rootViewController: addressCreationController)
            presentViewController(nc, animated: true, completion: nil)
        }
    }
    
    @IBAction func proceedToCheckoutButtonPressed(sender: AnyObject) {
        
        CartManager.instance.client.createCheckout(self.checkout, completion: {(checkout,error) -> Void in
            if (error == nil) {
                self.checkout = checkout;
                // optionally, save the checkout.token token somewhere on disk
            } else {
                // Handle errors here
            }})
        
        self.checkout.billingAddress = createBillingAddress(CartManager.instance.BillingAddress)
        self.checkout.shippingAddress = createBillingAddress(CartManager.instance.ShippingAddress)
        self.checkout.email = CartManager.instance.emailAddress
        
        CartManager.instance.client.updateCheckout(self.checkout, completion: {(checkout,error) -> Void in
            if (error == nil) {
                self.checkout = checkout;
                // optionally, save the checkout.token token somewhere on disk
            } else {
                // Handle errors here
            }})
        
        CartManager.instance.client.getShippingRatesForCheckout(checkout, completion: {(shippingRates,status,error) -> Void in
            if (shippingRates != nil) && (error == nil) {
                // Assumes this property exists on caller
                CartManager.instance.shippingRates = shippingRates;
            }
            else {
                // Handle error
            }})
        
        self.checkout.shippingRate = CartManager.instance.shippingRates as? BUYShippingRate
        
        CartManager.instance.client.updateCheckout(self.checkout, completion: {(checkout,error) -> Void in
            if (error == nil) {
                self.checkout = checkout
            } else {
                // Handle errors here
            }})
        
        let creditCard = BUYCreditCard()
        
        creditCard.number = "4242424242424242"
        creditCard.expiryMonth = "12"
        creditCard.expiryYear = "20"
        creditCard.cvv = "123"
        creditCard.nameOnCard = "Dinosaur Banana"
        
        
        CartManager.instance.client.storeCreditCard(creditCard, checkout: self.checkout, completion: {(checkout,paymentToken,error) -> Void in
            if (error == nil) {
                // Assume this property exists
                CartManager.instance.paymentToken = paymentToken
            } else {
                // Handle errors here
            }})
        
        CartManager.instance.client.completeCheckout(checkout, completion: {(checkout,error) -> Void in
            if (error == nil) {
                // Assume this property exists
                self.checkout = checkout;
            } else {
                // Handle errors here
            }})
        
//        payButtonPressed(self.checkout)
    }
    
    func payButtonPressed(checkout:BUYCheckout){
//        // Process Payment once the pay button is clicked.
//        var items = [PayPalItem]()
//       
//        for i in CartManager.instance.lineItems{
//        
//            let item = PayPalItem(name: i.variant.title, withQuantity: UInt(i.quantity), withPrice: i.variant.price, withCurrency: "USD", withSku: "SivaGanesh-0001")
//            items.append(item)
//           
//        }
//        
//        
//        
//        let subtotal = PayPalItem.totalPriceForItems(items)
//        
//        // Optional: include payment details
//        let shipping =  NSDecimalNumber(string: "0")
//        
//        let tax = checkout.totalTax
//        
//        let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
//        
//        let total = subtotal.decimalNumberByAdding(shipping).decimalNumberByAdding(tax)
//        
//        let payment = PayPalPayment(amount: total, currencyCode: "USD", shortDescription: "WoodsWholeSaleWines", intent: .Sale)
//        
//        payment.items = items
//        payment.paymentDetails = paymentDetails
//        
//        if (payment.processable) {
//            
//            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
//            presentViewController(paymentViewController!, animated: true, completion: nil)
//        }
//        else {
//            
//            print("Payment not processalbe: \(payment)")
//        }
        let item1 = PayPalItem(name: "Siva Ganesh Test Item", withQuantity: 1, withPrice: NSDecimalNumber(string: "9.99"), withCurrency: "USD", withSku: "SivaGanesh-0001")
        
        let items = [item1]
        let subtotal = PayPalItem.totalPriceForItems(items)
        
        // Optional: include payment details
        let shipping = NSDecimalNumber(string: "0.00")
        let tax = NSDecimalNumber(string: "0.00")
        let paymentDetails = PayPalPaymentDetails(subtotal: subtotal, withShipping: shipping, withTax: tax)
        
        let total = subtotal.decimalNumberByAdding(shipping).decimalNumberByAdding(tax)
        
        let payment = PayPalPayment(amount: total, currencyCode: "USD", shortDescription: "Siva Ganesh Test", intent: .Sale)
        
        payment.items = items
        payment.paymentDetails = paymentDetails
        
        if (payment.processable) {
            
            let paymentViewController = PayPalPaymentViewController(payment: payment, configuration: payPalConfig, delegate: self)
            presentViewController(paymentViewController!, animated: true, completion: nil)
        }
        else {
            
            print("Payment not processalbe: \(payment)")
        }
    }

    
    func createBillingAddress(addressModel:Address?)->BUYAddress?{
        let address = BUYAddress(dictionary: nil)
        guard let unwrappedAddress = addressModel else{
            return nil
        }
        address.address1 = unwrappedAddress.address1
        address.city = unwrappedAddress.city
        address.countryCode = unwrappedAddress.countryCode
        address.firstName = unwrappedAddress.firstName
        address.lastName = unwrappedAddress.lastName
        address.province = unwrappedAddress.province
        address.phone = unwrappedAddress.phoneNumber
        address.zip = unwrappedAddress.zip
        
        return address
    }
    
    @IBAction func buyWithApplepayButtonPressed(sender: AnyObject) {
    }
    
    
}