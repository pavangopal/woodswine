//
//  CartManager.swift
//  WoodsWholesaleWine
//
//  Created by Pavan Gopal on 18/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import Foundation
import UIKit
import Buy

class CartManager: BUYCart {

    
    static let instance = CartManager()

    
//    override func viewDidLoad() {
//        super.viewDidLoad()
//        // Do any additional setup after loading the view.
//    }
    
    private override init() {
        
//        super.init(nibName: nil, bundle: nil)
        //        print("SINGLETON INITIALIZED: LoadingController")
    }
    
    required init?(coder aDecoder: NSCoder) {
        fatalError("init(coder:) has not been implemented")
    }
}