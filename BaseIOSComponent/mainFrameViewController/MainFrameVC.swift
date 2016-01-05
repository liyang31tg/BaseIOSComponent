//
//  MainFrameVC.swift
//  BaseIOSComponent
//
//  Created by liyang on 15/12/30.
//  Copyright © 2015年 liyang. All rights reserved.
//

import Foundation
import UIKit
class MainFrameVC : UIViewController{
    var socket:SocketIOClient!
    override func viewDidLoad() {
        super.viewDidLoad()

        self.navigationController!.interactivePopGestureRecognizer!.delegate = nil
        print(self.navigationController)
        socket = SocketIOClient(socketURL: "localhost:3000", options: [.Log(true), .ForcePolling(true)])
        
       
        socket.on("connections") { (data:[AnyObject], ack:SocketAckEmitter) -> Void in

            print("socket connected:\((data[0] as! Dictionary<String,String>)["data"]!)")
        }


        socket.connect()
    }
    

    @IBAction func rightBtnAction(sender: AnyObject) {
        self.performSegueWithIdentifier("people2chatView", sender: self);
    }
    
    override func viewWillAppear(animated: Bool) {
        super.viewWillAppear(animated)
        self.tabBarController?.title = "chat"
    }
    
    
}