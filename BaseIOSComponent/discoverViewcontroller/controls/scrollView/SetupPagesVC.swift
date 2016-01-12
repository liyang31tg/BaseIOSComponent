//
//  SetupPagesVC.swift
//  BaseIOSComponent
//
//  Created by liyang on 16/1/11.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit
class SetupPagesVC: BaseViewController {
    
    
    @IBOutlet weak var contentView: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        
    }
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.navigationController?.navigationBarHidden = true
        self.navigationController?.navigationBar.alpha = 0.0
        UIApplication.sharedApplication().setStatusBarHidden(true, withAnimation: UIStatusBarAnimation.None)
    }
    
}
