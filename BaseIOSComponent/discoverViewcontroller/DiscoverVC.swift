//
//  DiscoverVC.swift
//  BaseIOSComponent
//
//  Created by liyang on 15/12/30.
//  Copyright © 2015年 liyang. All rights reserved.
//

import Foundation
import UIKit
class DiscoverVC: BaseGroupTableViewController{
    override func viewDidLoad() {
        super.viewDidLoad()
        dataArray = [[DiscoverTableViewCellDomain(sectionTitle: "图文混排", title: "",performIdentifier: ""),
            DiscoverTableViewCellDomain(sectionTitle: "nil", title: "TextKit",performIdentifier: "Discover2TextKitDetail")]]

    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = "Tool"
    }

}

