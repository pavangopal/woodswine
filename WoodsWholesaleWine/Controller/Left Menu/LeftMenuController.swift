//
//  ConstraintController.swift
//  learning0
//
//  Created by Pavan Gopal on 26/04/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit

class LeftMenuController: UIViewController {
    

    @IBOutlet weak var menuContainerView: UIView!
    @IBOutlet weak var xContraint: NSLayoutConstraint!
    @IBOutlet weak var dismissVIew: UIView!
    @IBOutlet weak var tableView: UITableView!
    
    
    var leftMenuArray = ["Home","About Us","Shop","Shipping","Contact Us","Log In","Create Account","Search","About Us","Terms & Conditions","Privacy Policy"]
    var shopArray = ["All Categories","Wine","Champagne","Sprits","Rare Sprits","Today's Pick"]
    
    var collapsedSection = [Int]()
    var kDropDownButtonTag = 1000
    var isOpen =  false
    let dropDownButton = UIButton()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        view.backgroundColor = UIColor.clearColor()
        view.opaque = false
        
        dismissVIew.userInteractionEnabled = true
        menuContainerView.layer.shadowOpacity = 0.8
        self.xContraint.constant = -menuContainerView.frame.size.width
       let contentInsets = UIEdgeInsetsMake(0.0, 0.0, 44, 0.0)
        tableView.contentInset = contentInsets
        tableView.scrollIndicatorInsets = contentInsets
    }
    
    override func viewDidAppear(animated: Bool) {
        super.viewDidAppear(animated)
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.xContraint.constant = 0
            self.view.layoutIfNeeded()
            
        })
    }
    
    override func viewWillDisappear(animated: Bool) {
        super.viewWillDisappear(animated)
        
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.xContraint.constant = -self.menuContainerView.frame.width
            self.view.layoutIfNeeded()
            }, completion: {finished in
                self.dismissViewControllerAnimated(false, completion: nil)
        })
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    @IBAction func dismiss(sender: AnyObject) {
        UIView.animateWithDuration(0.25, animations: { () -> Void in
            self.xContraint.constant = -self.menuContainerView.frame.width
            self.view.layoutIfNeeded()
            }, completion: {finished in
                self.dismissViewControllerAnimated(false, completion: nil)
        })
    }
    
    func indexPathsForSectionWithNumberOfRows( section: Int, noOfRows: Int) -> [NSIndexPath] {
        
        var indexPaths = [NSIndexPath]()
        indexPaths.removeAll()
        var i = 0
        
        while (i < noOfRows){
            let row = leftMenuArray.indexOf(shopArray[i])
            let indexPath = NSIndexPath(forRow: row!, inSection: section)
            indexPaths.append(indexPath)
            i += 1
        }
        return indexPaths
    }
    
    func sectionTapped(){
        
//        tableView.beginUpdates()
 
            if isOpen {
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.dropDownButton.transform = CGAffineTransformMakeRotation(CGFloat(-M_PI))
                })
            }
            else {
                UIView.animateWithDuration(0.25, animations: { () -> Void in
                    self.dropDownButton.transform = CGAffineTransformMakeRotation(CGFloat(0))
                })
            }
        
        
        if (!isOpen) {
            
            let numOfRows = shopArray.count
            
            let  indexPaths = indexPathsForSectionWithNumberOfRows(0, noOfRows: numOfRows)
            
            for i in  0..<shopArray.count{
                leftMenuArray.removeAtIndex(i+3)
            }
            tableView.deleteRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        }
        else {
            let numOfRows = shopArray.count
            leftMenuArray.insertContentsOf(shopArray, at:3)

            let  indexPaths = indexPathsForSectionWithNumberOfRows(0, noOfRows: numOfRows)
            

            tableView.insertRowsAtIndexPaths(indexPaths, withRowAnimation: .Automatic)
        }
//        tableView.endUpdates()
//        tableView.reloadData()
        
    }
    
}

extension LeftMenuController : UITableViewDataSource,UITableViewDelegate{
    
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return 1
    }
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return leftMenuArray.count
        
  
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        if isOpen{
            
            switch indexPath.row{
            case 4, 5 , 6 , 7 , 8 :
                
                let CategoryRow = tableView.dequeueReusableCellWithIdentifier("CategoryRow", forIndexPath: indexPath) as! CategoryRowCell
                CategoryRow.categoryRowLabel.text = leftMenuArray[indexPath.row]
                
                return CategoryRow
            case 3 , 9 :   let CategorySection = tableView.dequeueReusableCellWithIdentifier("CategorySection", forIndexPath: indexPath) as! CategorySectionCell
            CategorySection.categorySectionLabel.text = leftMenuArray[indexPath.row]
            
            return CategorySection
            default:        let leftMenuCell = tableView.dequeueReusableCellWithIdentifier("LeftMenuCell", forIndexPath: indexPath)
            leftMenuCell.textLabel?.text  = leftMenuArray[indexPath.row]
            
            if indexPath.row == 2 {
                
                dropDownButton.tag = kDropDownButtonTag
                dropDownButton.frame = CGRectMake(tableView.frame.size.width - 30, 10 , 20, 20 )
                dropDownButton.setImage(AssetImage.arrow.image, forState: UIControlState.Normal)

                dropDownButton.userInteractionEnabled = false
                
                leftMenuCell.addSubview(dropDownButton)
            }
            else{
                if leftMenuCell.subviews.contains(dropDownButton){
                    dropDownButton.removeFromSuperview()
                }
            }
            return leftMenuCell
            }
        }
        else{
            
        let leftMenuCell = tableView.dequeueReusableCellWithIdentifier("LeftMenuCell", forIndexPath: indexPath)
        leftMenuCell.textLabel?.text  = leftMenuArray[indexPath.row]
        
        if indexPath.row == 2 {
            
            dropDownButton.tag = kDropDownButtonTag
            dropDownButton.frame = CGRectMake(tableView.frame.size.width - 30, 10 , 20, 20 )
            dropDownButton.setImage(AssetImage.arrow.image, forState: UIControlState.Normal)
            dropDownButton.userInteractionEnabled = false
            
            leftMenuCell.addSubview(dropDownButton)
        }
        else{
            if leftMenuCell.subviews.contains(dropDownButton){
                dropDownButton.removeFromSuperview()
            }
        }
        return leftMenuCell
        }
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        if indexPath.row == 2{
            if isOpen{
             isOpen = false
            }
                else{
                    isOpen = true
             
                }
            
            sectionTapped()
        }
    }
}
