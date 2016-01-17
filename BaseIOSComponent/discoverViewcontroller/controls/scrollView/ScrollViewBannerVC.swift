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
    func cellForBannerView(cell:UIView){
        let imageview = cell as! UIImageView
        imageview.image = UIImage(named: "image0")
    
    }
}


@objc
protocol BannerViewDelegate{
    
    func cellForBannerView(cell:UIView)
    
    
    optional func numberOfBannerView()
    optional func didBannerView()

}

class BannerView: UIView,UIScrollViewDelegate {
    //config start ----
    var  bannerViewCell:AnyClass?{
        didSet{
            self.updateContentView()
            if let d = self.delegate {
                for v in self.cellViews {
                    d.cellForBannerView(v)
                }
            }
        }
    }
    let imageCount = 3
    
    
    var delegate:BannerViewDelegate?
    //config end  ---
    lazy var cellViews:[UIView] = {
        return []
    }()
    
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
