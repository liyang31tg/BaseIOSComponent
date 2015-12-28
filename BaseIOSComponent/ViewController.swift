//
//  ViewController.swift
//  BaseIOSComponent
//
//  Created by liyang on 15/12/27.
//  Copyright © 2015年 liyang. All rights reserved.
//

import UIKit
import Foundation

class ViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        let client = WSClient()
        client.startConnect(NSURL(string: "ws://192.168.0.102:3000")!)
        
//        let socket = SocketIOClient(socketURL: "localhost:8880")
//        socket.on("important message") {data, ack in
//            println("Message for you! \(data?[0])")
//            ack?("I got your message, and I'll send my response")
//            socket.emit("response", "Hello!")
//        }
//        socket.connect()
        
    
    }

}

