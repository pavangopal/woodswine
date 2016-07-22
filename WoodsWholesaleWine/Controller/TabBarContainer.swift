//
//  TabBarController.swift
//  Pulse
//
//  Created by Pavan Gopal on 13/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit

class TabBarContainer: UIViewController {

    var myTabBarController: UITabBarController!
    
    


    override func viewDidLoad() {
        super.viewDidLoad()
        launchTabBar()
        
        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    
    func launchTabBar()  {
        
        let tabNames = ["\(TabName.Catalog)", "\(TabName.Cart)", "\(TabName.Orders)","\(TabName.Account)"]
        
        var navControllers = [UINavigationController]()
        for tabName:String in tabNames {
            let index:Int = tabNames.indexOf(tabName)!
            if (tabName == "\(TabName.Catalog)") {
           //launch catlog controller
                let tabItem = UITabBarItem.init(title: tabName, image: AssetImage.cherry.image, tag: index)
                
//                let dashBoardController = UIStoryboard.mainStoryboard().instantiateViewControllerWithIdentifier(String(DashBoardViewController)) as! DashBoardViewController
                 let detailViewController = UIStoryboard.mainStoryboard().instantiateViewControllerWithIdentifier(String(DetailViewController)) as! DetailViewController
                detailViewController.tabBarItem = tabItem
                
                let nc = UINavigationController.init(rootViewController: detailViewController)
                nc.setupNavigationBar()
                navControllers.append(nc)
            }
                
            else if (tabName == "\(TabName.Cart)") {
            // launch card controller
                let tabItem = UITabBarItem.init(title: tabName, image: AssetImage.cherry.image, tag: index)
                
                let cartController = UIStoryboard.cartStoryboard().instantiateViewControllerWithIdentifier(String(CartController)) as! CartController
                cartController.tabBarItem = tabItem
                
                let nc = UINavigationController.init(rootViewController: cartController)
                nc.setupNavigationBar()
                navControllers.append(nc)
            }
                
            else if (tabName == "\(TabName.Orders)") {
               // launch Orders conroller
                let tabItem = UITabBarItem.init(title: tabName, image: AssetImage.cherry.image, tag: index)
                
                let ordersController = UIStoryboard.ordersStoryboard().instantiateViewControllerWithIdentifier(String(OrdersController)) as! OrdersController
                ordersController.tabBarItem = tabItem
                
                let nc = UINavigationController.init(rootViewController: ordersController)
                nc.setupNavigationBar()
                navControllers.append(nc)
            }
            else{
                //launch account controller
                let tabItem = UITabBarItem.init(title: tabName, image: AssetImage.cherry.image, tag: index)
                
                let accountController = UIStoryboard.accountStoryboard().instantiateViewControllerWithIdentifier(String(AccountController)) as! AccountController
                accountController.tabBarItem = tabItem
                
                let nc = UINavigationController.init(rootViewController: accountController)
                nc.setupNavigationBar()
                navControllers.append(nc)
            }
        }
        
        if myTabBarController != nil {
            removeViewController(myTabBarController)
            myTabBarController.viewControllers = nil
            myTabBarController = nil
        }
        
        myTabBarController = UITabBarController()
        myTabBarController.viewControllers = navControllers
        myTabBarController.tabBar.selectionIndicatorImage?.imageWithRenderingMode(.AlwaysTemplate)
        myTabBarController.tabBar.tintColor = UIColor.navBarColor()
        addViewController(myTabBarController)
    }
}


