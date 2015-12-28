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
        let client = WSClient()//wep.webuy-china.com/websocket
        client.startConnect(NSURL(string: "ws://wep.webuy-china.com/websocket?accountId=100238&password=54A09E52FE7E064F&deviceId=7A11056B-522C-47DE-A12B-C81263226C05&pduVersion=44&deviceToken=&iOSVppClient=0&appVersion=3973&pduParserVersion=2&deviceType=ios/")!)
        
//        let socket = SocketIOClient(socketURL: "localhost:8880")
//        socket.on("important message") {data, ack in
//            println("Message for you! \(data?[0])")
//            ack?("I got your message, and I'll send my response")
//            socket.emit("response", "Hello!")
//        }
//        socket.connect()
        
    
    }

}

