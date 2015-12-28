//
//  WSClient.swift
//  BaseIOSComponent
//
//  Created by liyang on 15/12/27.
//  Copyright © 2015年 liyang. All rights reserved.
//

import Foundation

class WSClient: NSObject, WebSocketDelegate {
    class var WS_URI:String { return "websocket" }
    
    class var INTERVAL_KEEP_ALIVE:Double { return 15.0 } // 15's
    class var RECONNECT_WS_TIMEOUT:Double { return 5.0 } // 5's
    class var LOOP_CHECK_TIME:Double { return 2.0 } // 2's
    
    class var PDU_LOST_TIMEOUT:Double { return 180.0 } // 180's
    
    private var socket:WebSocket?
    private var url:NSURL?
    private var c2sQueue:dispatch_queue_t!
    private var s2cQueue:dispatch_queue_t!
//    private var outC2SPDUs: [C2S_PDUProtocol] = []
    private var checkOutC2SPDUtimer:NSTimer?
    private var lastPDUOutTime      = Double()
    private var lastReconnectTime   = Double()
    //    private var lastInS2CPDUId      = 0
    private var semaphore: dispatch_semaphore_t!
    
    override init() {
        super.init()
        self.c2sQueue = dispatch_queue_create("com.webuy.WSClientC2SQueue", DISPATCH_QUEUE_SERIAL)
        self.s2cQueue = dispatch_queue_create("com.webuy.WSClientS2CQueue", DISPATCH_QUEUE_SERIAL)
        self.semaphore = dispatch_semaphore_create(1)
    }
    
    deinit {
        self.url = nil
        self.socket?.disconnect()
        self.socket = nil
        self.checkOutC2SPDUtimer?.invalidate()
    }
    
     func startConnect(url: NSURL) {
        self.url = url
        self.createWS()
        
        print(self.socket?.isConnected)
//        self.checkOutC2SPDUtimer = NSTimer.scheduledTimerWithTimeInterval(WSClient.LOOP_CHECK_TIME, target: self, selector: Selector("onCheckOutPDUTimerHandler"), userInfo: nil, repeats: true)
    }
    
     func stopConnect() {
        self.checkOutC2SPDUtimer?.invalidate()
        self.checkOutC2SPDUtimer = nil
        if(self.socket != nil) {
            self.socket?.disconnect()
            self.socket!.delegate = nil
            self.socket = nil
        }
    }
    
    private func createWS() {
        if(self.socket != nil) {
            self.socket?.disconnect()
            self.socket!.delegate = nil
            self.socket = nil
        }
        self.socket = WebSocket(url: self.url!)
        self.socket!.delegate = self
        self.socket!.queue = dispatch_queue_create("com.webuy.wsqueue", nil)
        self.socket!.connect()
        self.lastReconnectTime = NSDate().timeIntervalSince1970
        print("start connect websocket!")
    }
    
    private func reconnect() {
        print("reconnect websokct")
        self.createWS()
    }
    
     func isStoped() -> Bool {
        if(self.checkOutC2SPDUtimer == nil) {
            return true
        }
        return false
    }
    
//     func onCheckOutPDUTimerHandler() {
//        //print("chekc out pdu time handler ws connected: \(self.isConnected())")
//        let now = NSDate().timeIntervalSince1970
//        if(!self.isConnected()) {
//            if(self.lastReconnectTime > 0 && now - self.lastReconnectTime >= WSClient.RECONNECT_WS_TIMEOUT) { // do reconnect websocket
//                self.cleanOutC2SPDUsOfNotAutResend()
//                self.reconnect()
//            }
//        }
//        else {
//            let count = self.getOutC2SPDUsCount()
//            if(count == 0) {
//                if(self.lastPDUOutTime > 0 && now - self.lastPDUOutTime >= WSClient.INTERVAL_KEEP_ALIVE) { // send keep alive pdu
//                    print("send keep alive pdu")
////                    Application.sharedInstance.c2sCtrl.addPDU(C2S_KeepAlive())
//                }
//            }
//            else {
//                if(self.lastPDUOutTime > 0 && now - self.lastPDUOutTime >= WSClient.PDU_LOST_TIMEOUT) { // resend pdu
//                    print("resend first pdu because timeout:\(WSClient.PDU_LOST_TIMEOUT)")
//                    for var i=0; i<self.outC2SPDUs.count; i++ {
//                        let c2sPdu = self.outC2SPDUs[i]
//                        if c2sPdu.getPDU().pduType != PDU.C2S.C2S_PUSH_ACK && c2sPdu.getPDU().bSended == true {
//                            if !c2sPdu.isAutoResend() {
//                                self.outC2SPDUs.removeAtIndex(i)
//                                i--
//                            }
//                            c2sPdu.didSendFailed()
//                        }
//                    }
//                    
//                    self.reconnect()
//                    //self.sendOutC2SPDU()
//                }
//            }
//        }
//    }
    
     func isConnected() -> Bool {
        if(self.socket == nil) {
            return false;
        }
        else {
            return self.socket!.isConnected
        }
    }
    
     func disconnect() {
        self.socket?.disconnect()
    }
    
//    public func doC2SHandler(c2sPdu: C2S_PDUProtocol) {
//        //print("add c2s pdu id: \(c2sPdu.getPDU().pduID);type:\(c2sPdu.getPDU().pduType)")
//        if(c2sPdu.getPDU().pduType == PDU.C2S.C2S_PUSH_ACK) {
//            self.insertPDU2OutC2SPDUsFirst(c2sPdu) // insert first position
//        }
//        else if(c2sPdu.getPDU().pduType == PDU.C2S.C2S_FG_STATUS) {
//            if(self.isExistedPDUByType(PDU.C2S.C2S_FG_STATUS)) {
//                self.removeOutC2SPUDByType(PDU.C2S.C2S_FG_STATUS)
//            }
//            self.insertPDU2OutC2SPDUsFirst(c2sPdu)
//        }
//        else {
//            self.appendPDU2OutC2SPDUs(c2sPdu) // append last position
//        }
//        
//        self.sendOutC2SPDU()
//        print("out pdu size: \(self.outC2SPDUs.count)")
//    }
    
//    private func sendOutC2SPDU() {
//        if !self.isConnected() {
//            print("websocket has not connected!")
//            return
//        }
//        
//        if let c2sPdu = self.getFirstNotSendedOutC2SPDU() {
//            print("send c2s pdu id: \(c2sPdu.getPDU().pduID); type: \(c2sPdu.getPDU().pduType); data:\(PDUUtil.getStringFormatPDUData(c2sPdu.getPDU().pduData))")
//            
//            let pduOfNSData = PDUUtil.toNSData(c2sPdu.getPDU())
//            print("send c2s pdu length:\(pduOfNSData.length)")
//            
//            self.lastPDUOutTime = NSDate().timeIntervalSince1970
//            self.writeData(pduOfNSData)
//            c2sPdu.getPDU().bSended = true
//            
//            if(c2sPdu.getPDU().pduType == PDU.C2S.C2S_PUSH_ACK) {
//                self.removeOutC2SPDUsById(c2sPdu.getPDU().pduID)
//                
//                self.sendOutC2SPDU()
//            }
//        }
//    }
    
//    private func doS2CHandler(pdu: PDU) {
//        print("receive s2c pdu id:\(pdu.pduID); pdu type:\(pdu.pduType); pdudata:\(PDUUtil.getStringFormatPDUData(pdu.pduData))")
//        
//        if(pdu.pduType == PDU.S2C.S2C_PDU_ACK) {
//            let sendedPduId = PDUUtil.getIntOfPDUValue(pdu.pduData[0])
//            self.doSendSuccess(sendedPduId)
//            self.removeOutC2SPDUsById(sendedPduId)
//            
//            self.sendOutC2SPDU()
//        } else {
//            Application.sharedInstance.c2sCtrl.addPDU(C2S_PushAck(pduID: pdu.pduID))
//            // if had received duplicated pdu ingore
//            //            if pdu.pduID > self.lastInS2CPDUId || pdu.pduID == -1 {
//            //                self.lastInS2CPDUId = pdu.pduID
//            
//            dispatch_sync(self.s2cQueue, {
//                Application.sharedInstance.s2cCtrl.doPDU(pdu)
//            })
//            //            }
//        }
//    }
    
//    private func doSendSuccess(id: Int) {
//        dispatch_semaphore_wait(self.semaphore, 1)
//        for var i=0; i<self.outC2SPDUs.count; i++ {
//            let c2sPdu = self.outC2SPDUs[i]
//            if c2sPdu.getPDU().pduID == id {
//                c2sPdu.didSendSuccess()
//                break;
//            }
//        }
//        dispatch_semaphore_signal(self.semaphore)
//    }
    
//    func getFirstNotSendedOutC2SPDU() -> C2S_PDUProtocol? {
//        dispatch_semaphore_wait(self.semaphore, 1)
//        for c2sPdu in self.outC2SPDUs {
//            if c2sPdu.getPDU().bSended == false {
//                return c2sPdu
//            }
//        }
//        
//        dispatch_semaphore_signal(self.semaphore)
//        return nil
//    }
    
//    func getFirstSendedOutC2SPDU() -> C2S_PDUProtocol? {
//        dispatch_semaphore_wait(self.semaphore, 1)
//        for c2sPdu in self.outC2SPDUs {
//            if c2sPdu.getPDU().bSended == true {
//                return c2sPdu
//            }
//        }
//        dispatch_semaphore_signal(self.semaphore)
//        return nil
//    }
    
//    private func getOutC2SPDUsCount() -> Int {
//        var count = 0
//        dispatch_semaphore_wait(self.semaphore, 1)
//        
//        count = self.outC2SPDUs.count
//        
//        dispatch_semaphore_signal(self.semaphore)
//        
//        return count
//    }
    
//    public func getMaxPduId() -> Int {
//        dispatch_semaphore_wait(self.semaphore, 1)
//        var pduId = 0
//        for var i=0; i<self.outC2SPDUs.count; i++ {
//            let c2sPdu = self.outC2SPDUs[i]
//            pduId = max(c2sPdu.getPDU().pduID, pduId)
//        }
//        
//        dispatch_semaphore_signal(self.semaphore)
//        return pduId
//    }
    
    // MARK:- out pdus handler
//    private func removeOutC2SPDUsById(id: Int) {
//        dispatch_semaphore_wait(self.semaphore, 1)
//        for var i=0; i<self.outC2SPDUs.count; i++ {
//            let c2sPdu = self.outC2SPDUs[i]
//            if(c2sPdu.getPDU().pduID == id) {
//                self.outC2SPDUs.removeAtIndex(i)
//                break
//            }
//        }
//        
//        dispatch_semaphore_signal(self.semaphore)
//    }
    
//    func removeOutC2SPUDByType(type: Int) {
//        dispatch_semaphore_wait(self.semaphore, 1)
//        for var i=0; i<self.outC2SPDUs.count; i++ {
//            let c2sPdu = self.outC2SPDUs[i]
//            if(c2sPdu.getPDU().pduType == type) {
//                self.outC2SPDUs.removeAtIndex(i)
//                break
//            }
//        }
//        dispatch_semaphore_signal(self.semaphore)
//    }
//    
//    func isExistedPDUByType(type: Int) -> Bool {
//        var result = false
//        dispatch_semaphore_wait(self.semaphore, 1)
//        
//        for var i=0; i<self.outC2SPDUs.count; i++ {
//            let c2sPdu = self.outC2SPDUs[i]
//            if(c2sPdu.getPDU().pduType == type) {
//                result = true
//                break;
//            }
//        }
//        
//        dispatch_semaphore_signal(self.semaphore)
//        
//        return result
//    }
    
//    private func cleanOutC2SPDUsOfNotAutResend() {
//        dispatch_semaphore_wait(self.semaphore, 1)
//        for var i=0; i<self.outC2SPDUs.count; i++ {
//            let c2sPdu = self.outC2SPDUs[i]
//            if !c2sPdu.isAutoResend() {
//                self.outC2SPDUs.removeAtIndex(i)
//                i--
//            }
//            c2sPdu.didSendFailed()
//        }
//        dispatch_semaphore_signal(self.semaphore)
//    }
    
//    func appendPDU2OutC2SPDUs(c2sPdu: C2S_PDUProtocol) {
//        dispatch_semaphore_wait(self.semaphore, 1)
//        
//        self.outC2SPDUs.append(c2sPdu)
//        
//        dispatch_semaphore_signal(self.semaphore)
//    }
    
//    func insertPDU2OutC2SPDUsFirst(c2sPdu: C2S_PDUProtocol) {
//        dispatch_semaphore_wait(self.semaphore, 1)
//        if self.outC2SPDUs.count == 0 {
//            self.outC2SPDUs.append(c2sPdu)
//        }
//        else {
//            let oldArray = self.outC2SPDUs
//            self.outC2SPDUs = [c2sPdu] + oldArray
//        }
//        dispatch_semaphore_signal(self.semaphore)
//    }
    
//    func cleanAllSendedStatus() {
//        dispatch_semaphore_wait(self.semaphore, 1)
//        for c2sPdu in self.outC2SPDUs {
//            if c2sPdu.getPDU().pduType != PDU.C2S.C2S_PUSH_ACK {
//                c2sPdu.getPDU().bSended = false
//            }
//        }
//        dispatch_semaphore_signal(self.semaphore)
//    }
    
    // MARK:- Websocket Delegate Methods
    /*****************Websocket Delegate Methods***********************/
    func writeData(data: NSData) {
        weak var weakSelf = self
        dispatch_sync(self.c2sQueue, {
            weakSelf!.socket?.writeData(data)
        })
    }
    
    func websocketDidConnect(ws: WebSocket) {
        print("websocket is connected")
        //        self.lastInS2CPDUId = 0
//        self.cleanAllSendedStatus()
//        self.sendOutC2SPDU()
    }
    
     func websocketDidDisconnect(ws: WebSocket, error: NSError?) {
        print("websocket is disconnected")
        if let e = error {
            print("websocket is disconnected: \(e.localizedDescription)")
        }
    }
    
     func websocketDidReceiveMessage(ws: WebSocket, text: String) {
        print("Received text: \(text)")
    }
    
     func websocketDidReceiveData(ws: WebSocket, data: NSData) {
        
        if data.length > 0 {
//            let bytesPDU = PDUCipher.decryptData(CommonUtil.uncompressData(data))
//            if bytesPDU.length > 0 {
//                self.doS2CHandler(PDUUtil.toPDU(bytesPDU)!)
//            }
        }
    }
    /*****************Websocket Delegate Methods***********************/
}