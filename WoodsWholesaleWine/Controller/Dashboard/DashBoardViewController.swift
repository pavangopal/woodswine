//
//  ViewController.swift
//  WineTesting
//
//  Created by Pavan Gopal on 28/06/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit
import AVFoundation
import Buy
import BRYXBanner


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
        
        let filterItem = UIBarButtonItem.init(image: AssetImage.filter.image, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(DashBoardViewController.showFilter))
        
        navigationItem.leftBarButtonItems = [menuItem]
        navigationItem.rightBarButtonItems = [filterItem]
    }
    
    func showFilter(){
        let filterMenuController = UIStoryboard.mainStoryboard().instantiateViewControllerWithIdentifier("FilterController")
        
        presentViewController(filterMenuController, animated: false, completion: nil)

    }
    
    func getDataFromShopifyStore(){
        
        LoadingController.instance.showLoadingWithUserInteractionForSender(self)
        
        let client = BUYClient(shopDomain: "frontend-dev.myshopify.com", apiKey: "4016256b9915ea5e5d8b78eb4400b966", channelId: "58768321")
        
        //        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        client.getCollections({(collections,error) -> Void in
            LoadingController.instance.hideLoadingView()
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
    }
}


extension DashBoardViewController:UICollectionViewDelegate,UICollectionViewDataSource{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
        return Myproducts.count
    }
    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DashboardCell", forIndexPath: indexPath) as! DashboardCell
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
}

extension DashBoardViewController : UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating{
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text?.lowercaseString else{
            return
        }
        // search logic function Here
    }
}


