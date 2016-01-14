//
//  ConstraintsVC.swift
//  BaseIOSComponent
//
//  Created by liyang on 16/1/14.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit
class ConstraintsVC: BasePlainTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        dataArray = [DiscoverTableViewCellDomain(sectionTitle:"",title:"约束初探",performIdentifier:"ConstraintDetail2PreTest"),
                     DiscoverTableViewCellDomain(sectionTitle:"",title:"几个重要的API",performIdentifier:"ConstraintDetail2ImportaintAPI")]
    }
}