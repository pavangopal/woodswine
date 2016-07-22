//
//  DetailViewController.swift
//  WoodsWholesaleWine
//
//  Created by Pavan Gopal on 18/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit

class DetailViewController: UIViewController {
    
    
    var product : BUYProduct?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    

}

extension DetailViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
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
            
            headerView.updateData(product)
            
            return headerView
        default:
            //4
            assert(false, "Unexpected element kind")
        }
    }
    
//    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, referenceSizeForHeaderInSection section: Int) -> CGSize {
//       
//        let font = UIFont.systemFontOfSize(13)
//        
////        collectionView.reloadSections(NSIndexSet(indexesInRange: NSMakeRange(0,1)))
//
//        return CGSize(width: collectionView.frame.width, height: Helper.heightForText(font, width: collectionView.frame.width, text: "Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat.Lorem ipsum dolor sit er elit lamet, consectetaur cillium adipisicing pecu, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. .") + 304)
//    }
  
    
}