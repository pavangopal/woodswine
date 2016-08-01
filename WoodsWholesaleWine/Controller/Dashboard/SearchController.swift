//
//  SearchController.swift
//  WoodsWholesaleWine
//
//  Created by Pavan Gopal on 17/07/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit

protocol SearchControllerDeleagte {
    func updateCartBadgeFromSeachController(count:Int)
}

class SearchController: UIViewController {

    
    
    
    @IBOutlet weak var collectionView: UICollectionView!
    var filteredProducts = [Product]()
    var delegate : SearchControllerDeleagte?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func viewWillAppear(animated: Bool) {
        CartManager.instance.delegate = self
        collectionView.reloadData()
        if CartManager.instance.lineItems.count == 0{
            clearProductQuantity()
            collectionView.reloadData()
        }
        
    }
    
    func clearProductQuantity(){
        for product in filteredProducts{
            product.productQuantity = 0
        }
    }
    


}

extension SearchController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CartManagerDelegate{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return filteredProducts.count

    }
    
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
   
            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DashboardCell", forIndexPath: indexPath) as! DashboardCell
            cell.updateCellData(filteredProducts[indexPath.row],index :indexPath)
            return cell
        
    }
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let screenWidth = UIScreen.mainScreen().bounds.width
        return CGSize(width: screenWidth/2, height: screenWidth/2 )
    }
    
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailViewController = UIStoryboard.mainStoryboard().instantiateViewControllerWithIdentifier(String(DetailViewController)) as! DetailViewController
        
        detailViewController.product = filteredProducts[indexPath.row]
        
        self.navigationController?.presentViewController(detailViewController, animated: true, completion: nil)
    }
    
    func cartBadgeCountUpdatingDelegateFunction(count:Int,indexPath:NSIndexPath){
        delegate?.updateCartBadgeFromSeachController(count)
        collectionView.reloadItemsAtIndexPaths([indexPath])
    }
}