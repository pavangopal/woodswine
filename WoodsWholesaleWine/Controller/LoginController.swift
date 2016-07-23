//
//  LoginController.swift
//  WoodsWholesaleWine
//
//  Created by Incture Mac on 23/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit
import FBSDKLoginKit


class LoginController: UIViewController {
    
    // MARK: IBOutlet Properties
    
    @IBOutlet weak var btnSignIn: UIButton!
    
    @IBOutlet weak var facebookLoginButton: FBSDKLoginButton!
    
    var loginCompletionHandler:(() -> Void)!

    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        btnSignIn.enabled = true
//        btnGetProfileInfo.enabled = false
//        btnOpenProfile.hidden = true
        
    
        
        configureFacebook()
    }
    
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        
        checkForExistingAccessToken()
    }
    
    func configureFacebook()
    {
        facebookLoginButton.readPermissions = ["public_profile", "email", "user_friends"];
        facebookLoginButton.delegate = self
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    // MARK: IBAction Functions
    
    @IBAction func LinkedInLoginButtonPressed(sender: AnyObject) {
        let webViewController = UIStoryboard.loginStoryboard().instantiateViewControllerWithIdentifier(String(WebViewController)) as! WebViewController
        let nc = UINavigationController.init(rootViewController: webViewController)
        nc.setupNavigationBar()
        self.presentViewController(nc, animated: true, completion: nil)
        
        webViewController.webViewCompletionHandler = {() -> Void in
            if self.loginCompletionHandler != nil {
                self.dismissViewControllerAnimated(true, completion: nil)
                self.loginCompletionHandler()
            }
//            self.removeViewController(nc)
        }
    }
    
    
    @IBAction func getProfileInfo(sender: AnyObject) {
        if let accessToken = NSUserDefaults.standardUserDefaults().objectForKey("LIAccessToken") {
            // Specify the URL string that we'll get the profile info from.
            let targetURLString = "https://api.linkedin.com/v1/people/~:(public-profile-url)?format=json"
            
            
            
            // Initialize a mutable URL request object.
            let request = NSMutableURLRequest(URL: NSURL(string: targetURLString)!)
            
            // Indicate that this is a GET request.
            request.HTTPMethod = "GET"
            
            // Add the access token as an HTTP header field.
            request.addValue("Bearer \(accessToken)", forHTTPHeaderField: "Authorization")
            
            
            // Initialize a NSURLSession object.
            let session = NSURLSession(configuration: NSURLSessionConfiguration.defaultSessionConfiguration())
            
            // Make the request.
            let task: NSURLSessionDataTask = session.dataTaskWithRequest(request) { (data, response, error) -> Void in
                // Get the HTTP status code of the request.
                let statusCode = (response as! NSHTTPURLResponse).statusCode
                
                if statusCode == 200 {
                    // Convert the received JSON data into a dictionary.
                    do {
                        let dataDictionary = try NSJSONSerialization.JSONObjectWithData(data!, options: NSJSONReadingOptions.MutableContainers)

                        
                        let profileURLString = dataDictionary["publicProfileUrl"] as! String
                        
                        
                        dispatch_async(dispatch_get_main_queue(), { () -> Void in
//                            self.btnOpenProfile.setTitle(profileURLString, forState: UIControlState.Normal)
//                            self.btnOpenProfile.hidden = false
                            
                        })
                    }
                    catch {
                        print("Could not convert JSON data into a dictionary.")
                    }
                }
            }
            
            task.resume()
        }
    }
    
    
//    @IBAction func openProfileInSafari(sender: AnyObject) {
//        let profileURL = NSURL(string: btnOpenProfile.titleForState(UIControlState.Normal)!)
//        UIApplication.sharedApplication().openURL(profileURL!)
//    }
    
    
    // MARK: Custom Functions
    
    func checkForExistingAccessToken() {
        if NSUserDefaults.standardUserDefaults().objectForKey("LIAccessToken") != nil {
            btnSignIn.enabled = false
//            btnGetProfileInfo.enabled = true
        }
    }
    
}


extension LoginController : FBSDKLoginButtonDelegate{
    
    func loginButton(loginButton: FBSDKLoginButton!, didCompleteWithResult result: FBSDKLoginManagerLoginResult!, error: NSError!)
    {
      let requestObject =   FBSDKGraphRequest.init(graphPath: "me", parameters: ["fields":"first_name, last_name, picture.type(large)"])
        
       requestObject.startWithCompletionHandler { (connection, result, error) -> Void in
            let strFirstName: String = (result.objectForKey("first_name") as? String)!
            let strLastName: String = (result.objectForKey("last_name") as? String)!
            let strPictureURL: String = (result.objectForKey("picture")?.objectForKey("data")?.objectForKey("url") as? String)!
            let token = requestObject.tokenString
            UserDefaults.setFacebookAccessToken(token)
        
            if self.loginCompletionHandler != nil {
                self.dismissViewControllerAnimated(true, completion: nil)
                self.loginCompletionHandler()
            }
            
//            self.lblName.text = "Welcome, \(strFirstName) \(strLastName)"
//            self.ivUserProfileImage.image = UIImage(data: NSData(contentsOfURL: NSURL(string: strPictureURL)!)!)
        }
       
    }
    
    func loginButtonDidLogOut(loginButton: FBSDKLoginButton!)
    {
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
//        ivUserProfileImage.image = nil
//        lblName.text = ""
    }
}