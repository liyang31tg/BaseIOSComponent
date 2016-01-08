//
//  BaseGroupTableViewController.swift
//  BaseIOSComponent
//
//  Created by liyang on 16/1/8.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit
class BaseGroupTableViewController: BaseViewController,UITableViewDataSource,UITableViewDelegate {
    var dataArray:[[DiscoverTableViewCellDomain]] = []
    //MARK:TableViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray[section].count - 1//
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("DiscoverTableViewCellIdentifier") as! DiscoverTableViewCell
        cell.cellDomain = dataArray[indexPath.section][indexPath.row + 1]
        return cell
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return dataArray[section][0].sectionTitle
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 30
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0000001
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier(dataArray[indexPath.section][indexPath.row + 1].performIdentifier, sender: self)
    }

}
class DiscoverTableViewCell: UITableViewCell {
    var cellDomain:DiscoverTableViewCellDomain{
        get{
            return DiscoverTableViewCellDomain()
        }
        set{
            self.textLabel?.text = newValue.title
            self.accessoryType   = UITableViewCellAccessoryType.DisclosureIndicator
        }
    }
}

struct DiscoverTableViewCellDomain {
    var sectionTitle        = ""
    var title               = ""
    var performIdentifier   = ""
}