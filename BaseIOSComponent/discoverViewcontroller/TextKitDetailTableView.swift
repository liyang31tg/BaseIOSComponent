//
//  TextKitTableView.swift
//  BaseIOSComponent
//
//  Created by liyang on 16/1/9.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
class TextKitDetailTableView: BasePlainTableViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        dataArray = [DiscoverTableViewCellDomain(sectionTitle:"",title:"链接和手机号",performIdentifier:"TextKitDetail2MailOrPhone") ]
    }
}
