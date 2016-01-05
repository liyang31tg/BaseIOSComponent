//
//  ChatTableView.swift
//  BaseIOSComponent
//
//  Created by liyang on 16/1/6.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit
class ChatTableView: UITableViewController {
    override func viewDidLoad() {
        self.title = "chat wit customer"
        let refreshControl = UIRefreshControl()
        refreshControl.attributedTitle = NSAttributedString(string: "刷新")
        refreshControl.addTarget(self, action: Selector("refresh"), forControlEvents: UIControlEvents.ValueChanged)
        self.refreshControl = refreshControl
    }
    
    func refresh(){
        print("refresh")
    }
    
    override func tableView(tableView: UITableView, numberOfRowsInSection section: Int) -> Int{
        return 1;
    }
    

    
   
    override func tableView(tableView: UITableView, cellForRowAtIndexPath indexPath: NSIndexPath) -> UITableViewCell{
        return UITableViewCell()
    }
    

    
   
    override func tableView(tableView: UITableView, titleForHeaderInSection section: Int) -> String?{
        return nil
    
    }
   
    override func tableView(tableView: UITableView, titleForFooterInSection section: Int) -> String?{
        return nil
    
    }
    
}