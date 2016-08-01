//
//  FilterController.swift
//  WoodsWholesaleWine
//
//  Created by Incture Mac on 01/08/16.
//  Copyright © 2016 Pavan Gopal. All rights reserved.
//

import UIKit
protocol FilterControllerDelegate {
    func applyFilter()
}

class FilterController: UIViewController,UIGestureRecognizerDelegate{

    @IBOutlet weak var tableView: UITableView!
    
    @IBOutlet weak var byVarientView: UIView!
    @IBOutlet weak var byYearView: UIView!
    @IBOutlet weak var byRegionView: UIView!
    @IBOutlet weak var byVarientLabel: UILabel!
    @IBOutlet weak var byYearLabel: UILabel!
    @IBOutlet weak var byRegionlabel: UILabel!
    @IBOutlet weak var filterView: UIView!
    
    
    
    
    var CountryName = ["USA","France","Poland","Mexico","Greece","Italy","New Zealand"]
    var variety = ["Vodka","Spirit","Whiskey","Tequila"]
    var year = ["2012","1946","2015","2014"]
    var delegate : FilterControllerDelegate?
    var Filter = "ByRegion"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        updateLeftNavBarItems()
        let tapRegionguesture = UITapGestureRecognizer(target: self, action: #selector(ByRegionPressed))
        tapRegionguesture.delegate = self
        byRegionView.addGestureRecognizer(tapRegionguesture)
        
        let tapYearguesture = UITapGestureRecognizer(target: self, action: #selector(ByYearPressed))
        tapYearguesture.delegate = self
        byYearView.addGestureRecognizer(tapYearguesture)
        
        let tapVarientguesture = UITapGestureRecognizer(target: self, action: #selector(ByVarientPressed))
        tapVarientguesture.delegate = self
        byVarientView.addGestureRecognizer(tapVarientguesture)
        
        // Do any additional setup after loading the view.
    }
    
    func ByRegionPressed(){
        Filter = "ByRegion"
        tableView.reloadData()
    }
    
    func ByYearPressed(){
        Filter = "ByYear"
        tableView.reloadData()
    }
    
    func ByVarientPressed(){
        Filter = "ByVarient"
        tableView.reloadData()
    }
    
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    
    func updateLeftNavBarItems() {
        self.navigationController?.setupNavigationBar()
        let closeItem = UIBarButtonItem(barButtonSystemItem: .Stop, target: self, action: #selector(closeButtonPressed))
        
        navigationItem.leftBarButtonItems = [closeItem]
    }
    
    func closeButtonPressed(){
        dismissViewControllerAnimated(true, completion: nil)
    }

    @IBAction func clearAllButtonPressed(sender: AnyObject) {
        
    }
  
    @IBAction func applyButtonPressed(sender: AnyObject) {
        
    }
}

extension FilterController:UITableViewDelegate,UITableViewDataSource{
    
    
    
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        switch Filter{
        case "ByRegion":
           return CountryName.count
        case "ByVarient":
          return  variety.count
        case "ByYear":
           return  year.count
        default : return 0
            
        }
        
    }
    
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell {
        
        switch Filter{
        case "ByRegion":
            let filterCell = tableView.dequeueReusableCellWithIdentifier(String(FilterCell), forIndexPath: indexPath) as! FilterCell

              filterCell.updateCelldata(CountryName[indexPath.row],value: "")
            return filterCell

        case "ByVarient":
            let filterCell = tableView.dequeueReusableCellWithIdentifier(String(FilterCell), forIndexPath: indexPath) as! FilterCell

            filterCell.updateCelldata(variety[indexPath.row],value: "")
            return filterCell

        case "ByYear":
            let filterCell = tableView.dequeueReusableCellWithIdentifier(String(FilterCell), forIndexPath: indexPath) as! FilterCell

            filterCell.updateCelldata(year[indexPath.row],value: "")
            return filterCell

        default : return UITableViewCell()

        }
    }
}