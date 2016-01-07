//
//  CoreTextView.swift
//  BaseIOSComponent
//
//  Created by liyang on 16/1/7.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit
class CoreTextView: UIView {
    var content = "askdfjlkjasdlf"
    
    override func drawRect(rect: CGRect) {
        print("coretextvie\(rect)")
        //设置NSMutableAttributedString的所有属性
        let context = UIGraphicsGetCurrentContext()
        //设置context的ctm，用于适应core text的坐标体系
        CGContextSaveGState(context);
        CGContextSetTextMatrix(context, CGAffineTransformIdentity);
        CGContextTranslateCTM(context, 0, rect.size.height);
        CGContextScaleCTM(context, 1.0, -1.0);
        //设置CTFramesetter
//        CFAttributedStringRef
        
        let framesetter =  CTFramesetterCreateWithAttributedString(NSAttributedString(string: content));
        let path = CGPathCreateMutable();
        CGPathAddRect(path, nil, CGRectMake(0, 0, rect.size.width, rect.size.height))
        //创建CTFrame
        
        let ctFrame = CTFramesetterCreateFrame(framesetter, CFRangeMake(0, NSString(string: content).length), path, nil);
        //把文字内容绘制出来
        CTFrameDraw(ctFrame, context!);
        //获取画出来的内容的行数
//        let lines = CTFrameGetLines(ctFrame);
        let linesNS: NSArray  = CTFrameGetLines(ctFrame)
        let linesAO: [AnyObject] = linesNS as [AnyObject]
        let lines: [CTLine] = linesAO as! [CTLine]
        print("lines\(lines)");
        //获取每行的原点坐标
        var lineOrigins = [CGPoint](count:CFArrayGetCount(lines), repeatedValue: CGPointZero)
        CTFrameGetLineOrigins(ctFrame, CFRangeMake(0, 0), &lineOrigins);
        for i in 0..<CFArrayGetCount(lines) {
            let line = lines[i]
            var lineAscent:CGFloat      = 0.0
            var lineDescent:CGFloat     = 0.0
            var lineLeading:CGFloat     = 0.0
            //获取每行的宽度和高度
            CTLineGetTypographicBounds(line, &lineAscent, &lineDescent, &lineLeading);
            //获取每个CTRun
            let runs = CTLineGetGlyphRuns(line) as CFArrayRef
            for j in 0 ..< CFArrayGetCount(runs) {
                var runAscent:CGFloat   = 0.0
                var runDescent:CGFloat  = 0.0
                let lineOrigin = lineOrigins[i] as CGPoint
                //获取每个CTRun
                let run = CFArrayGetValueAtIndex(runs, j) as! CTRunRef
                let attributes = CTRunGetAttributes(run) as Dictionary
                var runRect:CGRect = CGRectZero
                //调整CTRun的rect
                let dd =  CTRunGetTypographicBounds(run, CFRangeMake(0,0), &runAscent, &runDescent, nil)
                runRect.size.width = CGFloat(dd)
                
                
                runRect=CGRectMake(lineOrigin.x + CTLineGetOffsetForStringIndex(line, CTRunGetStringRange(run).location, nil), lineOrigin.y - runDescent, runRect.size.width, runAscent + runDescent);
                
                
                //图片渲染逻辑，把需要被图片替换的字符位置画上图片
                if let imageName = attributes["imageName"] {
                    
                    let image = UIImage(named:imageName as! String)
                    if ((image) != nil) {
                        var imageDrawRect:CGRect = CGRectZero
                        imageDrawRect.size = CGSizeMake(30, 30);
                        imageDrawRect.origin.x = runRect.origin.x + lineOrigin.x;
                        imageDrawRect.origin.y = lineOrigin.y;
                        CGContextDrawImage(context, imageDrawRect, image!.CGImage);
                    }
                }
            }
        }
        CGContextRestoreGState(context);
    }
    
}