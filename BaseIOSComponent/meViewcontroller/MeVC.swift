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
         self.tabBarController?.title = "UI"
        print(self.navigationController)
    }
}