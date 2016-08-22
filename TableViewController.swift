//
//  TableViewController.swift
//  
//
//  Created by Andreas Geisler on 22.08.16.
//  Copyright © 2016 Andreas Geisler. All rights reserved.
//
//  Original source: http://stackoverflow.com/questions/35394191/making-simple-accordion-tableview-in-swift

import UIKit

class TableViewController: UITableViewController {

    var arrayForBool = [false, false, false]
    let sectionTitleArray = ["Pool A","Pool B","Pool C"]
    var sectionContentDict = [String:NSArray]()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        // Do any additional setup after loading the view, typically from a nib.
        
        
        
        let tmp1 : NSArray = ["New Zealand","Australia","Bangladesh","Sri Lanka"]
        var string1 = self.sectionTitleArray[0]
        sectionContentDict[string1] = tmp1
        let tmp2 : NSArray = ["India","South Africa","UAE","Pakistan"]
        string1 = self.sectionTitleArray[1]
        sectionContentDict[string1] = tmp2
        
        
        self.tableView.registerClass(UITableViewCell.self, forCellReuseIdentifier: "Cell")
        
        
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        // Dispose of any resources that can be recreated.
    }
    
    override func numberOfSectionsInTableView(tableView: UITableView) -> Int {
        return sectionTitleArray.count
    }
    
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        
        if(self.arrayForBool[section] == true)
        {
            let tps = self.sectionTitleArray[section]
            let count1: NSArray? = self.sectionContentDict[tps]
            if ( count1 == nil ) {
                return 0
            } else {
                return count1!.count
            }
            
        }
        return 0;
    }
    
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return "ABC"
    }
    
    override func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        
        return 50
    }
    
    override func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 1
    }
    
    override func tableView(tableView: UITableView, heightForRowAtIndexPath indexPath: NSIndexPath) -> CGFloat {
        if( self.arrayForBool[indexPath.section] == true){
            return 100
        }
        
        return 2;
    }
    
    override func tableView(tableView: UITableView, viewForHeaderInSection section: Int) -> UIView? {
        
        let headerView = UIView(frame: CGRectMake(0, 0, tableView.frame.size.width, 40))
        headerView.backgroundColor = UIColor.grayColor()
        headerView.tag = section
        
        let headerString = UILabel(frame: CGRect(x: 10, y: 10, width: tableView.frame.size.width-10, height: 30)) as UILabel
        headerString.text = self.sectionTitleArray[section]
        headerView .addSubview(headerString)
        
        let headerTapped = UITapGestureRecognizer (target: self, action:#selector(TableViewController.sectionHeaderTapped(_:)))
        headerView .addGestureRecognizer(headerTapped)
        
        return headerView
    }
    
    func sectionHeaderTapped(recognizer: UITapGestureRecognizer) {
        print("Tapping working")
        print(recognizer.view?.tag)
        
        let indexPath : NSIndexPath = NSIndexPath(forRow: 0, inSection:(recognizer.view?.tag as Int!)!)
        if (indexPath.row == 0) {
            
            var collapsed = arrayForBool[indexPath.section]
            collapsed       = !collapsed;
            
            self.arrayForBool[indexPath.section] = collapsed
            //reload specific section animated
            let range = NSMakeRange(indexPath.section, 1)
            let sectionToReload = NSIndexSet(indexesInRange: range)
            self.tableView .reloadSections(sectionToReload, withRowAnimation:UITableViewRowAnimation.Fade)
        }
        
    }

    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{

        let CellIdentifier = "Cell"
        var cell :UITableViewCell
        cell = self.tableView.dequeueReusableCellWithIdentifier(CellIdentifier)!
        
        let manyCells: Bool = arrayForBool[indexPath.section]
        
        if (!manyCells) {
            //  cell.textLabel.text = @"click to enlarge";
        } else{
            let content = self.sectionContentDict[sectionTitleArray[indexPath.section]]
            cell.textLabel?.text = content![indexPath.row] as? String
            cell.backgroundColor = UIColor .greenColor()
        }
        
        return cell
    }
}
