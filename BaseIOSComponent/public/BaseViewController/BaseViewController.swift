//
//  BaseViewController.swift
//  BaseIOSComponent
//
//  Created by liyang on 15/12/30.
//  Copyright © 2015年 liyang. All rights reserved.
//

import Foundation
import UIKit
class BaseViewController: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        self.navigationItem.leftBarButtonItem = UIBarButtonItem(image:UIImage(named: "fts_search_backicon_ios7"), style: UIBarButtonItemStyle.Plain, target: self, action: Selector("backAction"))
    }
    
    func backAction(){
        self.navigationController?.popViewControllerAnimated(true)
    }
    
}