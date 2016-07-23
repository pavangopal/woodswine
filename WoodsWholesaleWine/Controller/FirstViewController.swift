//
//  FirstViewController.swift
//  Pulse
//
//  Created by Pavan Gopal on 13/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit

class FirstViewController: UIViewController {

    var tabBarContainer : TabBarContainer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        if !checkForExistingAccessToken(){
            launchLoginController()
        }
        else{
            launchTabBarController()
        }
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func launchLoginController(){
        
        let loginController = UIStoryboard.loginStoryboard().instantiateViewControllerWithIdentifier(String(LoginController)) as! LoginController
        addViewController(loginController)
        
        loginController.loginCompletionHandler = {() -> Void in
            self.removeViewController(loginController)
            self.launchTabBarController()
        }
    }
    
    func launchTabBarController() {
        tabBarContainer = TabBarContainer()
        addViewController(tabBarContainer!)
    }
    
    func checkForExistingAccessToken() -> Bool {
        if NSUserDefaults.standardUserDefaults().objectForKey("LIAccessToken") != nil {
            return true
        }
        else{
            return false
        }
    }
    
}

extension FirstViewController: PresentPhotoProtocol{
    func loadPhotoPresentationScreen(controller: UIViewController) {
        if let topVC = getTopViewController(){
            topVC.presentViewController(controller, animated: true, completion: nil)
        }
    }
}