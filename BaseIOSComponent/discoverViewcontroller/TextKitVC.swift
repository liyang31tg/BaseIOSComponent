//
//  CoreTextView.swift
//  BaseIOSComponent
//
//  Created by liyang on 16/1/7.
//  Copyright © 2016年 liyang. All rights reserved.
//

import Foundation
import UIKit
class TextKitVC: BaseViewController,UITextViewDelegate {
    
    @IBOutlet weak var contentTextView: UITextView!
    let content = "11月的最后www.apple.com一天，起的不算早今天要去报道了，但是有些没自信即使需要面对巨额信用卡账单，我相信我能www.baidu.com搞定人生就是这样，为什么要选择逃避呢我就是我，不一样的烟火。现在很多人不了解我的一些秘密那就成为永久的秘密了慢慢的不去猜测别人怎么看我我正慢慢成长在外成长的好快，父母的担心慢慢变成了溺爱不去和父母吵13408633032架而是去想办法让他们接受感谢空调，没有你我昨晚得冻死了昨晚在看微博微地址:信的时候，发现人应该读书但是完全相信书里面的内容不如无书好吧，质疑是每个人都要做的事情好吧，去做而不是去吵架好吧，你是不是觉得我对人生很无奈你错了，我很开心。"
    
    override func viewDidLoad() {
        super.viewDidLoad()
        self.contentTextView.attributedText = NSAttributedString(string: content)
        self.contentTextView.font = UIFont.systemFontOfSize(18);
        self.contentTextView.dataDetectorTypes = UIDataDetectorTypes.All
        self.contentTextView.delegate = self
    }
    
    func textView(textView: UITextView, shouldInteractWithURL URL: NSURL, inRange characterRange: NSRange) -> Bool {
        print(URL)
        return false
    }
}