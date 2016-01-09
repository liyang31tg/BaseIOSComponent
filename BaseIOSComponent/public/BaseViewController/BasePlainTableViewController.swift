//
//  BasePlainTableViewController.swift
//  BaseIOSComponent
//
//  Created by liyang on 16/1/9.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit
class BasePlainTableViewController: BaseViewController {
    var dataArray:[DiscoverTableViewCellDomain] = []
    //MARK:TableViewDelegate
    func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        return dataArray.count
    }
    
    func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        let cell = tableView.dequeueReusableCellWithIdentifier("DiscoverTableViewCellIdentifier") as! DiscoverTableViewCell
        cell.cellDomain = dataArray[indexPath.row]
        return cell
        
    }
    
    func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String? {
        return nil
    }
    
    func tableView(tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
        return 0.0000001
    }
    
    func tableView(tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
        return 0.0000001
    }
    
    func numberOfSectionsInTableView(tableView: UITableView) -> Int{
        return 1
    }
    
    func tableView(tableView: UITableView, didSelectRowAtIndexPath indexPath: NSIndexPath) {
        tableView.deselectRowAtIndexPath(indexPath, animated: true)
        self.performSegueWithIdentifier(dataArray[indexPath.row].performIdentifier, sender: self)
    }
}
