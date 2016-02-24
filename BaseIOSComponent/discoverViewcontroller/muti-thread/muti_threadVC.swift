//
//  muti_threadVC.swift
//  BaseIOSComponent
//
//  Created by liyang on 16/2/24.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation

class muti_threadVC: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
         print("1\(NSThread.currentThread())")
//        dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//                print("2\(NSThread.currentThread())")
//            })
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//                NSThread.sleepForTimeInterval(1)
//                print("4\(NSThread.currentThread())")
//            })
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//                print("5\(NSThread.currentThread())")
//            })
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//                print("6\(NSThread.currentThread())")
//            })
//            dispatch_async(dispatch_get_global_queue(DISPATCH_QUEUE_PRIORITY_DEFAULT, 0), {
//                print("7\(NSThread.currentThread())")
//            })
//        })
        
        let newqueue =  dispatch_queue_create("liyang", DISPATCH_QUEUE_CONCURRENT)
       
        dispatch_async(newqueue, {
            print("4\(NSThread.currentThread())")
            dispatch_sync(newqueue, {
                NSThread.sleepForTimeInterval(1)
                print("55\(NSThread.currentThread())")
            })
            dispatch_sync(newqueue, {
                print("56\(NSThread.currentThread())")
            })
            dispatch_sync(newqueue, {
                print("57\(NSThread.currentThread())")
            })
            print("6\(NSThread.currentThread())")
        })
         print("3\(NSThread.currentThread())")
        
    }
}
