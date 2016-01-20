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
        
        dataArray = [DiscoverTableViewCellDomain(sectionTitle: "", title: "scrollview - 轮播banner",performIdentifier: "scrollview2Banner"),                     DiscoverTableViewCellDomain(sectionTitle: "", title: "scrollview - pullToRefresh",performIdentifier: "scrollView2pullToRefresh"),
        DiscoverTableViewCellDomain(sectionTitle: "", title: "scrollview - 分页(引导页)",performIdentifier: "scrollView2pages"),
        DiscoverTableViewCellDomain(sectionTitle: "", title: "scrollview - 分页(targetContentOffset)",performIdentifier: "scrollView2TargetOffSet")]
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = false
        self.navigationController?.navigationBar.alpha = 1.0
         UIApplication.sharedApplication().setStatusBarHidden(false, withAnimation: UIStatusBarAnimation.Fade)
    }
    
}
