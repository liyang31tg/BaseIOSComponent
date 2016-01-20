//
//  UIColorEXTension.swift
//  BaseIOSComponent
//
//  Created by liyang on 16/1/20.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit

extension UIColor {

    //pragma mark  十六进制颜色
    class func colorWithHexColorString(hexColorString:String)->UIColor{
        
        return UIColor.colorWithHexColorString(hexColorString, alpha: 1.0)
    }
    //16位颜色转16进制
    class  func colorWithHexColorString(hexColorString:String,alpha:CGFloat)->UIColor{
        var red=0, green=0, blue=0;
        var range=NSRange();
        
        range.length = 2;
        range.location = 0;
        red = self.getHexIntWith((hexColorString as NSString).substringWithRange(range))
        
        
        range.location = 2;
        green = self.getHexIntWith((hexColorString as NSString).substringWithRange(range))
        
        
        
        range.location = 4;
        blue = self.getHexIntWith((hexColorString as NSString).substringWithRange(range))
        
        return UIColor(red: CGFloat(Double(red)/255.0), green: CGFloat(Double(green)/255.0), blue: CGFloat(Double(blue)/255.0), alpha: alpha);
    }
    
    class func colorWithRGB(r:CGFloat,g:CGFloat,b:CGFloat)->UIColor{
        
        return UIColor.colorWithRGBandAlpha(r, g: g, b: b, a: 1.0)
    }
    
    class func colorWithRGBandAlpha(r:CGFloat,g:CGFloat,b:CGFloat,a:CFloat)->UIColor{
        
        return UIColor(red: r/255.0, green: g/255.0, blue: b/255.0, alpha: CGFloat(a))
    }
    
    class func getHexIntWith(hexStr:String)->Int{
        var a:[Int]=[]
        for charactor in hexStr.characters {
            a.append(self.getIntBy(charactor))
        }
        let c = a.reverse()
        var result  = 0
        for (index,item) in c.enumerate() {
            let r   = Int(pow(16.0, Double(index))*Double(item))
            result  = result + r
        }
        return result
    }
    
    //TODO:16进制转10进制
    class func getIntBy(hex:Character)->Int{
        switch hex{
        case "1":
            return 1
        case "2":
            return 2
        case "3":
            return 3
        case "4":
            return 4
        case "5":
            return 5
        case "6":
            return 6
        case "7":
            return 7
        case "8":
            return 8
        case "9":
            return 9
        case "a","A":
            return 10
        case "b","B":
            return 11
        case "c","C":
            return 12
        case "d","D":
            return 13
        case "e","E":
            return 14
        case "f","F":
            return 15
        default :
            return 0
        }
        
    }


}
