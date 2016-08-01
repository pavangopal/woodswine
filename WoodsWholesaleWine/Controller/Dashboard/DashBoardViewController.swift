
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

protocol DashBoardViewControllerDelagte{
    func dismissSideMenu()
}

class DashBoardViewController: UIViewController{
    
    @IBOutlet weak var collectionView: UICollectionView!
    
    var Mycollections = NSArray()
//    var Myproducts = NSMutableArray()
    var allOperations = NSArray()
    var searchController: UISearchController!
  var resultsController = UIStoryboard.mainStoryboard().instantiateViewControllerWithIdentifier(String(SearchController)) as! SearchController
    var  cart = BUYCart()
    var isMenuOpen = Bool()
    var delegate : DashBoardViewControllerDelagte?
    var products = [Product]()
    var isWorkItemDownloadingFinished = false
    var isMoreDataAvailable = false
    var PageNumber = UInt(1)
    var currentpage = UInt(1)
    var searchState = false
    var filteredProducts = [Product]()

    
    override func viewDidLoad() {
        super.viewDidLoad()
        isMenuOpen = false
        definesPresentationContext = false
        
        getDataFromShopifyStore()
        collectionView.registerNib(UINib(nibName:"DashboardHeaderView",bundle: nil), forSupplementaryViewOfKind: UICollectionElementKindSectionHeader, withReuseIdentifier: "DashboardHeaderView")
        
        collectionView.registerNib(UINib(nibName:"LodingCollectionCell", bundle:nil),forCellWithReuseIdentifier: "lodingCell")
        updateLeftNavBarItems()
        
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
        for product in products{
            product.productQuantity = 0
        }
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    func setSearchController(){
        searchController = UISearchController(searchResultsController: resultsController)
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
//        self.collectionView.contentOffset = CGPointMake(0, self.searchController.searchBar.bounds.size.height);
    }
    
    func showSideMenu(sender: AnyObject) {
        let sideMenuController = UIStoryboard.leftMenuStoryboard().instantiateViewControllerWithIdentifier(String(LeftMenuController)) as! LeftMenuController
        sideMenuController.modalPresentationStyle = .OverCurrentContext
        if !isMenuOpen{
        isMenuOpen = true
        
        presentViewController(sideMenuController, animated: false, completion: nil)
        }
        else{
            isMenuOpen = false
//            delegate?.dismissSideMenu()
            dismissViewControllerAnimated(false, completion: nil)
            
        }
    }
    
    
    func updateLeftNavBarItems() {
        
        let menuItem = UIBarButtonItem.init(image: UIImage.init(named: "sideNav"), style: UIBarButtonItemStyle.Plain, target: self, action: #selector(DashBoardViewController.showSideMenu))
        
        let filterItem = UIBarButtonItem.init(image: AssetImage.filter.image, style: UIBarButtonItemStyle.Plain, target: self, action: #selector(DashBoardViewController.showFilter))
        
        navigationItem.leftBarButtonItems = [menuItem]
        navigationItem.rightBarButtonItems = [filterItem]
    }
    
    func showFilter(){
        let filterMenuController = UIStoryboard.mainStoryboard().instantiateViewControllerWithIdentifier("FilterController") as! FilterController
        let nc = UINavigationController.init(rootViewController: filterMenuController)

        presentViewController(nc, animated: false, completion: nil)

    }
    
    func getDataFromShopifyStore(){
        
        LoadingController.instance.showLoadingWithUserInteractionForSender(self)
        
//        let client = BUYClient(shopDomain: "maria-hadrout-com.myshopify.com", apiKey: "3d0f7bce4ba54ad712d5866df544b4a7", channelId: "8") // production store

        
        CartManager.instance.client.pageSize = 25
        
        //        UIApplication.sharedApplication().networkActivityIndicatorVisible = true
        
        getProducts(PageNumber)
        
//        client.getCollections({(collections,error) -> Void in
//            LoadingController.instance.hideLoadingView()
//            if ((error == nil) && collections != nil) {
//                self.Mycollections = collections
//            }
//            else{
//                print("Error fetching products\(error)")
//            }
//        })
        
//        client.getProductsPage(2, completion: {(products,page,reachedEnd,error) -> Void in
//            if ((error == nil) && (products != nil)){
//                self.Myproducts = products
//                self.cratedata()
//                
//                self.collectionView.reloadData()
//            }
//            else{
//                print("Error:\(error)")
//            }
//        })
        
//        client.getProductsPage(1, inCollection: 1, completion: {(products,page,reachedEnd,error) -> Void in
//            if ((error == nil) && (products != nil)){
//                self.Myproducts = products
//                self.cratedata()
//                self.collectionView.reloadData()
//            }
//            else{
//                print("Error:\(error)")
//            }
//        })
        
//        client.getShop({(shop,error) -> Void
//            in
//            if ((error == nil) && (shop != nil)){
//                shop.city
//                
//                print(shop.city,shop.country,shop.currency)
//            }
//        })
    }
    
    func cratedata(products:[BUYProduct]){
        for i in 0..<products.count {
            let product = Product()
            product.product = products[i] 
            self.products.append(product)
        }
    }
    
    func getProducts(page:UInt){
        CartManager.instance.client.getProductsPage(page, completion: {(products,page,reachedEnd,error) -> Void in
            if ((error == nil) && (products != nil)){
                LoadingController.instance.hideLoadingView()
                self.isWorkItemDownloadingFinished = true
                self.cratedata(products)
                self.isMoreDataAvailable = !reachedEnd
                self.collectionView.reloadData()
            }
            else{
                print("Error:\(error)")
            }
        })
    }
}


extension DashBoardViewController:UICollectionViewDelegate,UICollectionViewDataSource,UICollectionViewDelegateFlowLayout,CartManagerDelegate{
    
    func collectionView(collectionView: UICollectionView, numberOfItemsInSection section: Int) -> Int {
//        if searchState == false{
        if (isMoreDataAvailable && products.count > 0) {
            return products.count + 1
        }
        return products.count
//        }else{
//            return filteredProducts.count
//        }
    }

    
    func collectionView(collectionView: UICollectionView, cellForItemAtIndexPath indexPath: NSIndexPath) -> UICollectionViewCell {
//        if searchState == false{
            if (indexPath.row == products.count) && isMoreDataAvailable {
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("lodingCell", forIndexPath: indexPath)
                
                cell.tag = kLoadingCellTag;
                let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
                activityIndicator.center = CGPoint(x: UIScreen.mainScreen().bounds.midX, y: cell.bounds.midY)
                cell.addSubview(activityIndicator)
                activityIndicator.startAnimating()
                return cell
            }
            else{
                let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DashboardCell", forIndexPath: indexPath) as! DashboardCell
//                cell.delegate = self
                cell.updateCellData(products[indexPath.row],index :indexPath)
                return cell
            }
            
//        }
//        else{
//            let cell = collectionView.dequeueReusableCellWithReuseIdentifier("DashboardCell", forIndexPath: indexPath) as! DashboardCell
//            cell.delegate = self
//            cell.updateCellData(filteredProducts[indexPath.row],index :indexPath)
//            return cell
//        }
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
    
    
    func collectionView(collectionView: UICollectionView, willDisplayCell cell: UICollectionViewCell, forItemAtIndexPath indexPath: NSIndexPath) {
         if (cell.tag == kLoadingCellTag && isWorkItemDownloadingFinished && isMoreDataAvailable) {
            currentpage += 1
            getProducts(currentpage)
        }
    }
    
    
    
    func collectionView(collectionView: UICollectionView, layout collectionViewLayout: UICollectionViewLayout, sizeForItemAtIndexPath indexPath: NSIndexPath) -> CGSize {
        let screenWidth = UIScreen.mainScreen().bounds.width
        return CGSize(width: screenWidth/2, height: screenWidth/2 )
    }

    
    func collectionView(collectionView: UICollectionView, didSelectItemAtIndexPath indexPath: NSIndexPath) {
        let detailViewController = UIStoryboard.mainStoryboard().instantiateViewControllerWithIdentifier(String(DetailViewController)) as! DetailViewController
        
        detailViewController.product = products[indexPath.row] 
        
        self.navigationController?.pushViewController(detailViewController, animated: true)
        
    }
    
 
    
    func cartBadgeCountUpdatingDelegateFunction(count:Int,indexPath:NSIndexPath){
        let tabArray = self.tabBarController?.tabBar.items as NSArray!
        if tabArray != nil{
            let tabItem = tabArray.objectAtIndex(1) as! UITabBarItem
            tabItem.badgeValue = String(count)
        }
        collectionView.reloadItemsAtIndexPaths([indexPath])
    }
    
    func loadingCell() -> UICollectionViewCell{
        let cell = collectionView.dequeueReusableCellWithReuseIdentifier("lodingCell", forIndexPath: NSIndexPath(forItem: products.count + 1, inSection: 0))
        
        cell.tag = kLoadingCellTag;
        let activityIndicator = UIActivityIndicatorView(activityIndicatorStyle: .Gray)
        activityIndicator.center = CGPoint(x: UIScreen.mainScreen().bounds.midX, y: cell.bounds.midY)
        cell.addSubview(activityIndicator)
        activityIndicator.startAnimating()
        return cell
    }

}

extension DashBoardViewController : UISearchBarDelegate,UISearchControllerDelegate,UISearchResultsUpdating,SearchControllerDeleagte{
    
    func updateSearchResultsForSearchController(searchController: UISearchController) {
        guard let searchText = searchController.searchBar.text else{
            return
        }
      resultsController.filteredProducts.removeAll()
        filteredProducts.removeAll()

        // search logic function Here
    }
    
    
    func searchBarSearchButtonClicked(searchBar: UISearchBar) {
        guard let searchtext = searchBar.text else{
            return
        }
        

//      let ProductsToSearch =   getAllProducts()
        
        
        var present : Bool?
        if Helper.lengthOfStringWithoutSpace(searchtext) > 0{
            
            for i in 0..<products.count{
//
//                if ((products[i].product?.tags.contains {
//                    $0.compare(searchtext, options: [.DiacriticInsensitiveSearch, .CaseInsensitiveSearch]) == .OrderedSame
//                    }) != nil) {
//                    filteredProducts.append(products[i])
//                    print("Found")
//                }
            
                let a =  products[i].product?.tags.map({$0.lowercaseString})
               present =  a?.contains(searchtext)
                if present == true {
//                    searchState = true
                    filteredProducts.append(products[i])
                }
                else{
                    
                }
            }
           
            resultsController.delegate = self
            resultsController.filteredProducts.appendContentsOf(self.filteredProducts)
            resultsController.collectionView.reloadData()
        }
        
        searchBar.resignFirstResponder()
   
    }
    
    func updateCartBadgeFromSeachController(count:Int) {
        let tabArray = self.tabBarController?.tabBar.items as NSArray!
        if tabArray != nil{
            let tabItem = tabArray.objectAtIndex(1) as! UITabBarItem
            tabItem.badgeValue = String(count)
        }
    }
    
//    func getAllProducts() -> [Product]{
//        var page = UInt(1)
//        var finishedDownloding = Bool()
//        var MyProducts = [BUYProduct]()
//        repeat{
//        CartManager.instance.client.getProductsPage(page, completion: {(products,page,reachedEnd,error) -> Void in
//            if ((error == nil) && (products != nil)){
//                LoadingController.instance.hideLoadingView()
//                self.isWorkItemDownloadingFinished = true
//                MyProducts.appendContentsOf(products)
//               finishedDownloding = reachedEnd
//            }
//            else{
//                print("Error:\(error)")
//            }
//        })
//            page = page + 1
//        }while(!finishedDownloding)
//       
//        return  self.crateSearchdata(MyProducts)
//    }
    
//    func crateSearchdata(products:[BUYProduct]) -> [Product]{
//        var MyProducts = [Product]()
//
//        for i in 0..<products.count {
//            let product = Product()
//            product.product = products[i]
//           MyProducts.append(product)
//        }
//        return MyProducts
//    }
    
//    func searchBarCancelButtonClicked(searchBar: UISearchBar) {
//        searchBar.resignFirstResponder()
//        setSearchController()
//
//        
////        searchState = false
//        collectionView.reloadData()
//    }
}



