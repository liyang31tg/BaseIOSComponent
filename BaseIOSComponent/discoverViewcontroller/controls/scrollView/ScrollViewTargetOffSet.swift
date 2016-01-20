//
//  ScrollViewTargetOffSet.swift
//  BaseIOSComponent
//
//  Created by liyang on 16/1/20.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit
class ScrollViewTargetOffSet: BaseViewController,UIScrollViewDelegate {
    
    let pageCount           = 100
    let itemWidth:CGFloat   = 60
    let itemHeight:CGFloat  = 60
    

    let otherItemOffsetX:CGFloat = 20
    let lastItemTrailing:CGFloat = 20
    
    
    @IBOutlet weak var contentScrollView: UIScrollView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.setPages()
    }
    
    func setPages(){
        var preLable:UILabel!
        for  page in 0...pageCount{
            let label                   = UILabel()
            label.translatesAutoresizingMaskIntoConstraints = false
            self.contentScrollView.addSubview(label)
            label.font                  = UIFont.systemFontOfSize(20.0)
            label.textAlignment         = NSTextAlignment.Center
            label.text                  = "#\(page)"
            label.textColor             = UIColor.whiteColor()
            label.backgroundColor       = UIColor.colorWithHexColorString("5a62d2")
            label.layer.cornerRadius    = itemWidth / 2.0
            label.layer.masksToBounds   = true
            
            
           let itemWithConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: itemWidth)
          let itemHeightConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: nil, attribute: NSLayoutAttribute.NotAnAttribute, multiplier: 1, constant: itemHeight)
          let itemCenterYConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.CenterY, relatedBy: NSLayoutRelation.Equal, toItem: self.contentScrollView, attribute: NSLayoutAttribute.CenterY, multiplier: 1, constant: 0)
            self.contentScrollView.addConstraints([itemWithConstraint,itemHeightConstraint,itemCenterYConstraint])
            if page == 0 {//第一个
         let itemLeftConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.CenterX, relatedBy: NSLayoutRelation.Equal, toItem:self.contentScrollView, attribute: NSLayoutAttribute.CenterX, multiplier: 1, constant: 0)
            self.contentScrollView.addConstraints([itemLeftConstraint])
            }else if page == pageCount{//最后一个
                let itemLeftConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem:preLable, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: lastItemTrailing)
                let itemTrailingConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem:self.contentScrollView, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: otherItemOffsetX)
                self.contentScrollView.addConstraints([itemLeftConstraint,itemTrailingConstraint])
            
            }else{//其他
                let itemLeftConstraint = NSLayoutConstraint(item: label, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem:preLable, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 20)
                self.contentScrollView.addConstraint(itemLeftConstraint)
            
            }
            preLable = label

        }
    }
    
    func nearestTargetOffsetForOffset(offset:CGPoint) -> CGPoint {
        let pageSize = itemWidth + otherItemOffsetX
        let page = round(offset.x / pageSize)
        let targetX = pageSize * page;
        return CGPointMake(targetX, offset.y);
    }
    
    func scrollViewWillEndDragging(scrollView: UIScrollView, withVelocity velocity: CGPoint, targetContentOffset: UnsafeMutablePointer<CGPoint>) {
        
        let targetOffset = self.nearestTargetOffsetForOffset(CGPointMake(targetContentOffset.memory.x, targetContentOffset.memory.y))
        targetContentOffset.memory.x = targetOffset.x;
        targetContentOffset.memory.y = targetOffset.y;
    }
    
}