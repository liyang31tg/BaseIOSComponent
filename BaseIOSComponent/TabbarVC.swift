//
//  TabbarVC.swift
//  BaseIOSComponent
//
//  Created by liyang on 15/12/30.
//  Copyright © 2015年 liyang. All rights reserved.
//

import Foundation
import UIKit
class TabbarVC: BaseTabbarViewController ,UITabBarControllerDelegate{
    override func viewDidLoad() {
        self.delegate = self
    }
   
}