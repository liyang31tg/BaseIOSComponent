//
//  ScrollViewDetailVC.swift
//  BaseIOSComponent
//
//  Created by liyang on 16/1/10.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit
class ScrollViewDetailVC: BasePlainTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        dataArray = [DiscoverTableViewCellDomain(sectionTitle: "", title: "scrollview - pullToRefresh",performIdentifier: "scrollView2pullToRefresh"),
        DiscoverTableViewCellDomain(sectionTitle: "", title: "scrollview - 启动页",performIdentifier: "scrollView2pages")]
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBar.alpha = 1.0
    }
    
}
