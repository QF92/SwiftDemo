//
//  BaseProgressView.swift
//  swiftdemo
//
//  Created by qf on 2020/9/2.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class BaseProgressView: UIProgressView {
    override init(frame: CGRect) {
        super.init(frame: frame)
        
        self.common()
    }
    required init?(coder aDecoder: NSCoder) {
        super.init(coder: aDecoder)
        self.common()

    }
    
    func common() {
        self.progressTintColor = DealistConfig.share.mainColor
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
