//
//  ConstraintsImportaintAPI.swift
//  BaseIOSComponent
//
//  Created by liyang on 16/1/14.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit
class ConstraintsImportaintAPI: BaseViewController {

    @IBOutlet weak var testUIViewA: UIView!
    @IBOutlet weak var testLabelA: UILabel!
    
    @IBOutlet weak var testLabelB: UILabel!
    @IBOutlet weak var testTextViewHeightConstraint: NSLayoutConstraint!
    @IBOutlet weak var testTextView: UITextView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.testLabelA.text = "以包含的另外一层这包含的另外一层意思包含的另外一层意思，即在布局完成前，我们是不能通过view.frame.size准确获取view的size的。但有时候，我们需要在auto layout system对view完成布局前就知道它的这包含的另外一层意思，即在布局完成前，我们是不能通过view.frame.size准确获取view的size的。但有时候，我们需要在auto layout system对"
        self.testLabelB.text = "这包含的另外一层意思，即在布局完成前，我们是不能通过view.frame.size准确获取view的size的。但有时候，我们需要在auto layout system对view完成布局前就知道它的这包含的另外一层意思，即在布局完成前，我们是不能通过view.frame.size准确获取view的size的。但有时候，我们需要在auto layout system对view完成布局前就知道它的"
       self.testLabelB.preferredMaxLayoutWidth = 300
       let outViewFitSize = self.testUIViewA.systemLayoutSizeFittingSize(UILayoutFittingExpandedSize)
        print("outViewFitSize:\(outViewFitSize)")
        
        
       let tmpsize = testTextView.sizeThatFits(self.testTextView.bounds.size)
        self.testTextViewHeightConstraint.constant = tmpsize.height
        
       
        
    }
    
   
}

class preTestLabel: UILabel {
//    override func awakeFromNib() {
//        super.awakeFromNib()
//    }
//    //MARK:这个方法比下面个方法先执行
//    override func textRectForBounds(bounds: CGRect, limitedToNumberOfLines numberOfLines: Int) -> CGRect {
//        var tmpRect = super.textRectForBounds(bounds, limitedToNumberOfLines: numberOfLines)
//        print("textRectForBoundsA:\(tmpRect)")
//        tmpRect.size.width  += 15
//        tmpRect.size.height += 15
//        print("textRectForBoundsB:\(tmpRect)")
//        return tmpRect
//    }
//    //下面这个方法只有UILable、UIButton和UIImage这种可以通过内容通过约束得出size，其他的不用都返回（－1，－1），可以通过重写这个方法让其约束更大
    override func intrinsicContentSize() -> CGSize {
        var contentSize = super.intrinsicContentSize() //这个方法就是通过约束来返回一个渲染时候需要的Size，会多次回调
        print("contentSizeA:\(contentSize)")
        contentSize.width  += 120
        contentSize.height += 20
        print("contentSizeA:\(contentSize)")
        return contentSize
    }
    override func layoutSubviews() {
        super.layoutSubviews()
        print("self.frame:\(self.frame)")
    }
    
    

}

class preTestTextView: UITextView {
    
}