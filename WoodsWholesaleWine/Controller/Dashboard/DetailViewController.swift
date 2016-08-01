//
//  DetailViewController.swift
//  WoodsWholesaleWine
//
//  Created by Pavan Gopal on 18/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit
import Buy


class DetailViewController: UIViewController {
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var product : Product?
    
    override func viewDidLoad() {
        super.viewDidLoad()
        print("detail")
//       print(CartManager.instance.lineItems[0].quantity)
        
        // Do any additional setup after loading the view.
    }
    override func viewWillAppear(animated: Bool) {
        CartManager.instance.delegate = self
        if CartManager.instance.lineItems.count == 0{
            product?.productQuantity = 0
            collectionView.reloadData()
        }
    }
    
  
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension DetailViewController:UICollectionViewDelegate,UICollectionViewDataSource,CartManagerDelegate{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return 1
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let detailCell = collectionView.dequeueReusableCellWithReuseIdentifier("DetailCell", forIndexPath: indexPath) as! DetailCell

        return detailCell
    }
    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        switch kind {
        //2
        case UICollectionElementKindSectionHeader:
            //3
            let headerView =
                collectionView.dequeueReusableSupplementaryViewOfKind(kind,
                                                                      withReuseIdentifier: "DetailHeaderView",
                                                                      forIndexPath: indexPath)
                    as! DetailHeaderView
            
            headerView.updateData(product,index: indexPath)
//            headerView.delegate = self

            return headerView
        default:
            //4
            assert(false, "Unexpected element kind")
        }
    }
    
   
    func cartBadgeCountUpdatingDelegateFunction(count:Int,indexPath:NSIndexPath){
        let tabArray = self.tabBarController?.tabBar.items as NSArray!
        if tabArray != nil{
        let tabItem = tabArray.objectAtIndex(1) as! UITabBarItem
        tabItem.badgeValue = String(count)
        }
        collectionView.reloadData()
    }
}