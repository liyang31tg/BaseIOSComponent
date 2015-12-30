//
//  MeVC.swift
//  BaseIOSComponent
//
//  Created by liyang on 15/12/30.
//  Copyright © 2015年 liyang. All rights reserved.
//

import Foundation
import UIKit
class MeVC: UIViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        print(self.navigationController)
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = "UI"
    }
}