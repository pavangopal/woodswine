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
        launchTabBarController()
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func launchTabBarController() {
        tabBarContainer = TabBarContainer()
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