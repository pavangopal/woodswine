//
//  FirstViewController.swift
//  Pulse
//
//  Created by Pavan Gopal on 13/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit
import FBSDKLoginKit


class FirstViewController: UIViewController {

    var tabBarContainer : TabBarContainer?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        if UserDefaults.facebookAccessToken() == nil && UserDefaults.linkedInAccessToken() == nil{
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
        tabBarContainer?.delegate = self
        addViewController(tabBarContainer!)
    }
    
    
    
}

extension FirstViewController: PresentPhotoProtocol{
    func loadPhotoPresentationScreen(controller: UIViewController) {
        if let topVC = getTopViewController(){
            topVC.presentViewController(controller, animated: true, completion: nil)
        }
    }
}

extension FirstViewController:TabBarContainerDelegate{
    func logoutDelegate() {
        removeViewController(tabBarContainer!)
        UserDefaults.setFacebookAccessToken(nil)
        UserDefaults.setUserId(nil)
        UserDefaults.setLinkedInAccessToken(nil)
        UserDefaults.setLoggedInUserImageName(nil)
        let loginManager: FBSDKLoginManager = FBSDKLoginManager()
        loginManager.logOut()
        launchLoginController()
    }
}