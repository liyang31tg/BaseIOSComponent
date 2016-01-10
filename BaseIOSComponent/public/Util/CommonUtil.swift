//
//  CommonUtil.swift
//  webuy
//
//  Created by liuqiang on 15/3/30.
//  Copyright (c) 2015年 IOMeeting. All rights reserved.
//

import Foundation
import UIKit


public class CommonUtil {
    static let IOS7:Float = 7
    class var IOS_SYSTEM_VERISON: Float {
        return Float(UIDevice.currentDevice().systemVersion) ?? 0
    }
    
    // MARK: 常用组件属性
    //GCD延迟执行
    class func runBlockAfterDelay(delay:NSTimeInterval, closure: () -> Void) {
        let dely : Int64            = Int64(delay) * Int64(NSEC_PER_SEC)
        let time : dispatch_time_t  = dispatch_time(DISPATCH_TIME_NOW, dely)
        let queue: dispatch_queue_t = dispatch_get_main_queue()
        dispatch_after(time, queue, closure)
    }
    //TODO:字符串转字节
    class func convertString2NSData(str: String) -> NSData {
        return str.dataUsingEncoding(NSUTF8StringEncoding)!
    }
    //MARK:字节转字符串
    class func convertNSData2String(nsData: NSData) -> String {
        return String(data: nsData, encoding: NSUTF8StringEncoding)!
    }
    
    //MARK:字节编码为64位字符串
    class func encodeBase64Data2Str(plainData: NSData) -> String {
        return plainData.base64EncodedStringWithOptions(NSDataBase64EncodingOptions.Encoding64CharacterLineLength)
    }
    //MARK:将字符串编码位64位字符串
    class func encodeBase64Str(plainString: String) -> String {
        return self.encodeBase64Data2Str(self.convertString2NSData(plainString))
    }
    

    
    class func compressData(inputData: NSData) -> NSData {
        return try! inputData.gzippedData()
    }
    
    class func uncompressData(inputData: NSData) -> NSData {
        return try! inputData.gunzippedData()
    }
}
//MARK屏幕尺寸
let sb = UIScreen.mainScreen().bounds
let ss = sb.size
let sw = ss.width
let sh = ss.height


