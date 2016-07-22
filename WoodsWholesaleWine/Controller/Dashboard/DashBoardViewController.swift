//
//  ViewController.swift
//  WineTesting
//
//  Created by Pavan Gopal on 28/06/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit
import AVFoundation


class DashBoardViewController: UIViewController {

    @IBOutlet weak var collectionView: UICollectionView!
    
    let collections = NSArray()
    var Myproducts = NSArray()
    var allOperations = NSArray()
    var searchController: UISearchController!
    var resultsTableController: SearchController!
    var  cart = BUYCart()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        definesPresentationContext = false

        getDataFromShopifyStore()
        
        collectionView.registerNib(UINib(nibName:"DashboardHeaderView",bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "DashboardHeaderView")
        updateLeftNavBarItems()
    }

    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setSearchController(){
        resultsTableController = SearchController()
        searchController = UISearchController(searchResultsController: resultsTableController)
        searchController.searchResultsUpdater = self
        searchController.searchBar.placeholder = "Search for Wine, Spirits, Champagne...etc"
        searchController.searchBar.sizeToFit()
        
        //        searchController.searchBar.barTintColor = ConstantColor.CWLightGray
        //        searchController.searchBar.tintColor = ConstantColor.CWLightGray
        //        searchController.searchBar.backgroundColor = ConstantColor.CWLightGray
        
        
        
        searchController.dimsBackgroundDuringPresentation = true // default is YES
        searchController.searchBar.delegate = self    // so we can monitor text changes + others
        /*
         Search is now just presenting a view controller. As such, normal view controller
         presentation semantics apply. Namely that presentation will walk up the view controller
         hierarchy until it finds the root view controller or one that defines a presentation context.
         */
        definesPresentationContext = true
        self.collectionView.contentOffset = CGPointMake(0, self.searchController.searchBar.bounds.size.height);
    }

   func showSideMenu(sender: AnyObject) {
    
        let sideMenuController = UIStoryboard.leftMenuStoryboard().instantiateViewControllerWithIdentifier("LeftMenuController")
        sideMenuController.modalPresentationStyle = .OverCurrentContext
        
        presentViewController(sideMenuController, animated: false, completion: nil)
    }
    
    
    func updateLeftNavBarItems() {
        
        let menuItem = UIBarButtonItem.init(image: UIImage.init(named: "sideNav"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(DashBoardViewController.showSideMenu))
        
        
        navigationItem.leftBarButtonItems = [menuItem]
    }
    
    func getDataFromShopifyStore(){
        LoadingController.instance.setSuperViewWithUserInteraction(self)
        
        let client = BUYClient(shopDomain: "frontend-dev.myshopify.com", apiKey: "4016256b9915ea5e5d8b78eb4400b966", channelId: "58768321")
        
        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        client.getCollections({(collections,error) -> Void in
            UIApplication.sharedApplication().networkActivityIndicatorVisible = false
            if ((error == nil) && collections != nil) {
                
            }
            else{
                print("Error fetching products\(error)")
            }
        })
        
        client.getProductsPage(1, completion: {(products,page,reachedEnd,error) -> Void in
            if ((error == nil) && (products != nil)){
                self.Myproducts = products
                self.collectionView.reloadData()
            }
            else{
                print("Error:\(error)")
            }
        })
        
        client.getShop({(shop,error) -> Void
            in
            if ((error == nil) && (shop != nil)){
                shop.city
                
                print(shop.city,shop.country,shop.currency)
            }
        })
        
        LoadingController.instance.hideLoadingView()
        
        //        let shopOperetion = GetShopOperation(client: client)
        //
        //        NSOperationQueue.mainQueue().addOperation(shopOperetion)
        //        let cart = BUYCart()
        //        let checkout = BUYCheckout.init(cart: cart)
        //        let product = Myproducts[0] as! BUYProduct
        //        cart.addVariant(product.variants.first!)
        //
        //
        //        let shippingOperation = GetShippingRatesOperation(client: client, withCheckout: checkout)
        //
        //        NSOperationQueue.mainQueue().addOperation(shippingOperation)
        //        let blockOpertion = NSBlockOperation(block: ({() -> Void in
        //        print("Do something here")}))
        //
        //
        //        blockOpertion.addDependency(shopOperetion)
        //        blockOpertion.addDependency(shippingOperation)
        //        NSOperationQueue.mainQueue().addOperation(blockOpertion)
        //        allOperations = [blockOpertion,shopOperetion,shippingOperation]
        
    }
}


extension DashBoardViewController:UICollectionViewDelegate,UICollectionViewDataSource,DashboardCellProtocol{
 
     func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Myproducts.count
    }
    
     func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DashboardCell", forIndexPath: indexPath) as! DashboardCell
        cell.delegate = self
        cell.updateCellData(Myproducts[indexPath.row] as? BUYProduct)
        return cell
    }
    



    
    func collectionView(collectionView: UICollectionView, viewForSupplementaryElementOfKind kind: String, atIndexPath indexPath: NSIndexPath) -> UICollectionReusableView {
        switch kind {
        //2
        case UICollectionElementKindSectionHeader:
            //3
            let headerView =
                collectionView.dequeueReusableSupplementaryViewOfKind(kind,
                                                                      withReuseIdentifier: "DashboardHeaderView",
                                                                      forIndexPath: indexPath)
                    as! DashboardHeaderView
          
            setSearchController()

            searchController.searchBar.frame = CGRectMake(0, 0, collectionView.bounds.size.width, self.searchController.searchBar.bounds.size.height)
            
            headerView.addSubview(searchController.searchBar)
            return headerView
        default:
            //4
            assert(false, "Unexpected element kind")
        }
    }
    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
             let detailViewController = UIStoryboard.mainStoryboard().instantiateViewControllerWithIdentifier(String(DetailViewController)) as! DetailViewController
        
        detailViewController.product = Myproducts[indexPath.row] as? BUYProduct
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
        
    }
    
    func updateCart(productVarient: BUYProductVariant?, add: Bool, delete: Bool) {
        
        if add{
            if let unwrappedProductVarient = productVarient{
//                BUYCartLineItem *lineItem = [[BUYCartLineItem alloc] initWithVariant:variant];
//                BUYCartLineItem *existingLineItem = [self.lineItemsSet member:lineItem];
//                if (existingLineItem) {
//                    existingLineItem.quantity = [existingLineItem.quantity decimalNumberByAdding:[NSDecimalNumber one]];
//                } else {
//                    [self.lineItemsSet addObject:lineItem];
//                }
                
                let lineItem = BUYCartLineItem()
                let existingLineItem = 
                cart.addVariant(unwrappedProductVarient)
            }else{
                print("product variant not available")
            }
        }
        else if delete{
            if let unwrappedProductVarient = productVarient{
                cart.removeVariant(unwrappedProductVarient)
            }else{
                print("product variant not available")
            }
        }
//        print(cart.lineItems[0].quantity)
        
    }
    
}


extension DashBoardViewController : UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating{
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        //        self.searchController.searchBar.tintColor = UIColor.whiteColor()
        //        self.searchController.searchBar.barStyle = UIBarStyle.Black
        //        self.searchController.searchBar.translucent = true
        //        self.searchController.searchBar.alpha = 0.9
        //        self.tableView.alpha = 0.9
        
        guard let searchText = searchController.searchBar.text?.lowercaseString else{
            return
        }
        // search logic function Here
    }
}


