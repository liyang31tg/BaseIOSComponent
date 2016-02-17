//
//  PaymentPatternVC.swift
//  BaseIOSComponent
//
//  Created by liyang on 16/2/17.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
class PaymentPatternVC: BasePlainTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        dataArray = [DiscoverTableViewCellDomain(sectionTitle:"",title: "支付宝",performIdentifier: "")]
    }
}