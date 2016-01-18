//
//  ScrollViewBannerVC.swift
//  BaseIOSComponent
//
//  Created by liyang on 16/1/15.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit
class ScrollViewBannerVC: BaseViewController,BannerViewDelegate {
    
    @IBOutlet weak var bannerScrollView: BannerView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.edgesForExtendedLayout = UIRectEdge.None
        self.bannerScrollView.delegate = self
        self.bannerScrollView.bannerViewCell = UIImageView.self
       
    }
    func cellForBannerView(cell:UIView,index:Int){
        let imageview = cell as! UIImageView
        imageview.image = UIImage(named: "image\(index)")
    }
    
    func numberOfBannerView() -> Int {
        return 3
    }
}


@objc
protocol BannerViewDelegate{
    
    func cellForBannerView(cell:UIView,index:Int)
    func numberOfBannerView() -> Int
    optional func didBannerView()

}

class BannerView: UIView,UIScrollViewDelegate {
    //config start ----
    var  bannerViewCell:AnyClass?{
        didSet{
            if let _ = self.delegate {
                self.fillContent()
            }
        }
    }
    var delegate:BannerViewDelegate?{
        didSet{
            if let _ =  self.bannerViewCell {
             self.fillContent()
            }
        }
    
    }
    //config end  ---
    lazy var cellViews:[UIView] = {
        return []
    }()
    let imageCount = 3 //不可修改
    lazy  var contentScrollView:UIScrollView = {
        let tmpScrollView = UIScrollView()
        tmpScrollView.delegate = self
        tmpScrollView.translatesAutoresizingMaskIntoConstraints = false
        tmpScrollView.bounces = false
        tmpScrollView.showsHorizontalScrollIndicator = false
        tmpScrollView.showsVerticalScrollIndicator = false
        tmpScrollView.pagingEnabled = true
        
//        tmpScrollView.contentOffset = CGPointMake(UISCREENWIDTH, 0);
//        tmpScrollView.contentSize = CGSizeMake(UISCREENWIDTH * 3, UISCREENHEIGHT);
        return tmpScrollView
        }()
    override func awakeFromNib() {
        super.awakeFromNib()
        self.addSubview(contentScrollView)
        contentScrollView.backgroundColor = UIColor.redColor()
        //add Constraints
        let actop       = NSLayoutConstraint(item: contentScrollView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
        let acleading   = NSLayoutConstraint(item: contentScrollView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
        let actrailing  = NSLayoutConstraint(item: contentScrollView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
        let acbottom    = NSLayoutConstraint(item: contentScrollView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: self, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
        self.addConstraints([actop,acleading,actrailing,acbottom])
    }
    func fillContent(){
        self.updateContentView()
        self.showPage(0)
    }
    //0开始
    func showPage(pageIndex:Int){
        let allCount = self.delegate!.numberOfBannerView()
        for (index,v) in self.cellViews.enumerate() {
        let tmpIndex = pageIndex + Int(index) - 1
            self.delegate!.cellForBannerView(v,index: tmpIndex < 0 ? allCount : tmpIndex > allCount ? 0 : tmpIndex)
        
        }
    }
    // 根据各种条件刷新View
    func updateContentView(){
        self.contentScrollView.removeConstraints(self.contentScrollView.constraints)
        for subview in self.contentScrollView.subviews{
                subview.removeFromSuperview()
        }
        if let cell = self.bannerViewCell{
            var preImageView:UIView!
            for t in 1...imageCount {
                let tmpImageView    = (cell as! UIView.Type).init() //这里是桥接了一个class
                self.cellViews.append(tmpImageView)
                tmpImageView.translatesAutoresizingMaskIntoConstraints = false
                self.contentScrollView.addSubview(tmpImageView)
                
                let titop       = NSLayoutConstraint(item: tmpImageView, attribute: NSLayoutAttribute.Top, relatedBy: NSLayoutRelation.Equal, toItem: contentScrollView, attribute: NSLayoutAttribute.Top, multiplier: 1, constant: 0)
                let tibottom    = NSLayoutConstraint(item: tmpImageView, attribute: NSLayoutAttribute.Bottom, relatedBy: NSLayoutRelation.Equal, toItem: contentScrollView, attribute: NSLayoutAttribute.Bottom, multiplier: 1, constant: 0)
                let tiwidth       = NSLayoutConstraint(item: tmpImageView, attribute: NSLayoutAttribute.Width, relatedBy: NSLayoutRelation.Equal, toItem: contentScrollView, attribute: NSLayoutAttribute.Width, multiplier: 1, constant: 0)
                let tiheight    = NSLayoutConstraint(item: tmpImageView, attribute: NSLayoutAttribute.Height, relatedBy: NSLayoutRelation.Equal, toItem: contentScrollView, attribute: NSLayoutAttribute.Height, multiplier: 1, constant: 0)
                self.contentScrollView.addConstraints([titop,tibottom,tiwidth,tiheight])
                
                //addConstraint
                if t == 1 {//the first picture
                    tmpImageView.backgroundColor = UIColor.yellowColor()
                    let tileading   = NSLayoutConstraint(item: tmpImageView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: contentScrollView, attribute: NSLayoutAttribute.Leading, multiplier: 1, constant: 0)
                    self.contentScrollView.addConstraints([tileading])
                }else if t == imageCount {//the last picture
                    tmpImageView.backgroundColor = UIColor.blueColor()
                    let pretileading   = NSLayoutConstraint(item: tmpImageView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: preImageView, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
                    let titrailing  = NSLayoutConstraint(item: tmpImageView, attribute: NSLayoutAttribute.Trailing, relatedBy: NSLayoutRelation.Equal, toItem: contentScrollView, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
                    self.contentScrollView.addConstraints([pretileading,titrailing])
                }else{//other
                    tmpImageView.backgroundColor = UIColor.brownColor()
                    let pretileading   = NSLayoutConstraint(item: tmpImageView, attribute: NSLayoutAttribute.Leading, relatedBy: NSLayoutRelation.Equal, toItem: preImageView, attribute: NSLayoutAttribute.Trailing, multiplier: 1, constant: 0)
                    self.contentScrollView.addConstraint(pretileading)
                }
                preImageView        = tmpImageView
            }
        }
    }
    
   
    
}
