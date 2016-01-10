//
//  ScrollViewController.swift
//  BaseIOSComponent
//
//  Created by liyang on 16/1/9.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit

class ScrollViewController: BaseViewController,UIScrollViewDelegate {
    var istrue = false
    @IBOutlet weak var contentScrollView: UIScrollView!
    override func viewDidLoad() {
        super.viewDidLoad()
    }
    
//    func scrollViewWillBeginDragging(scrollView: UIScrollView) {
//        istrue = false
//        scrollView.contentInset.top = 0
//    }
//    
//    func scrollViewDidScroll(scrollView: UIScrollView) {
//        print("contentOffset:\(scrollView.contentOffset)")
//        print("contentInset:\(scrollView.contentInset)")
//        
//        if scrollView.contentOffset.y >= -44 && istrue{
//            scrollView.contentInset.top = 44
//        }
//    }
    
    func scrollViewDidEndDecelerating(scrollView: UIScrollView) {
        scrollView.contentInset.top = 44
    }
    

    
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        print("scrollViewWillEndDragging,velocity:\(velocity),targetContentOffset:\(targetContentOffset)")
        istrue = true
        scrollView.contentInset.top = 44
        targetContentOffset.memory = CGPointMake(0, -44)
       
       
//        targetContentOffset -> y = 44
    }
    
//    func scrollViewDidEndDragging(scrollView: UIScrollView, willDecelerate decelerate: Bool) {
//        print("scrollViewDidEndDragging");
//        if decelerate {
//           
//            if scrollView.contentOffset.y == 44 {
//                scrollView.contentInset.top = 44
//            
//            }
//            
//        
//        }
//    }
}