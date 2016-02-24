//
//  AppDelegate.swift
//  BaseIOSComponent
//
//  Created by liyang on 15/12/27.
//  Copyright © 2015年 liyang. All rights reserved.
//

import UIKit

@UIApplicationMain
class AppDelegate: UIResponder, UIApplicationDelegate {

    var window: UIWindow?


    func application(application: UIApplication, didFinishLaunchingWithOptions launchOptions: [NSObject: AnyObject]?) -> Bool {
        // Override point for customization after application launch.
        /*
        
        [[UINavigationBar appearance] setTintColor:[UIColor whiteColor]];
        [[UINavigationBar appearance] setBarTintColor:[UIColor colorWithRed:0/255.0 green:175/255.0 blue:240/255.0 alpha:1]];
        [[UINavigationBar appearance] setTitleTextAttributes: [NSDictionary dictionaryWithObjectsAndKeys:
        [UIColor whiteColor], NSForegroundColorAttributeName, [UIFont systemFontOfSize:21], NSFontAttributeName, nil]];
        [[UIApplication sharedApplication] setStatusBarStyle:UIStatusBarStyleLightContent];
        */
//        UINavigationBar.appearance().tintColor = UIColor.redColor()
//        UINavigationBar.appearance().barTintColor =  UIColor(colorLiteralRed: 0/255.0, green: 175/255.0, blue: 240/255.0, alpha: 1)
        self.window?.backgroundColor = UIColor.whiteColor()
        let queue = dispatch_queue_create("myQueue", DISPATCH_QUEUE_CONCURRENT)
        NSLog("之前 - %@", NSThread.currentThread())
        dispatch_async(queue, { () -> Void in
            NSLog("sync之前 - %@", NSThread.currentThread())
            dispatch_sync(queue, { () -> Void in
                NSLog("sync - %@", NSThread.currentThread())
            })
            NSLog("sync之后 - %@", NSThread.currentThread())
        })
        NSLog("之后 - %@", NSThread.currentThread())
        return true
    }

   


}

