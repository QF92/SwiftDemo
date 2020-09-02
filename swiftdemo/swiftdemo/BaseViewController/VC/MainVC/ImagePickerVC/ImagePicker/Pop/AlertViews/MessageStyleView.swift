//
//  MessageStyleView.swift
//  swiftdemo
//
//  Created by qf on 2020/9/1.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class MessageStyleView: UIView {
        @objc var leftHendle: leftHendleClouse?
        @objc var rightHendle: rightHendleClouse?
        @objc var middleHendle: middleHendleClouse?

        @IBOutlet weak var middleBtn: UIButton!
        @IBOutlet weak var contentLableBottomYS: NSLayoutConstraint!
        @IBOutlet weak var btnsBottomView: UIView!
        @IBOutlet weak var rightBtn: UIButton!
        @IBOutlet weak var leftBtn: UIButton!
        @IBOutlet weak var contentLabel: UILabel!
        
        @objc static func show() -> MessageStyleView {
            return BundleUtil.getCurrentBundle().loadNibNamed("MessageStyleView", owner: nil, options: nil)?.last as! MessageStyleView
        }
        
        override func awakeFromNib() {
            super.awakeFromNib()
            self.layer.cornerRadius = 8
            self.layer.masksToBounds = true
        }
        
        @IBAction func clickRightBtn(_ sender: Any) {
            if rightHendle != nil {
                rightHendle!()
            }
            
        }
        @IBAction func clickLeftBtn(_ sender: Any) {
            if leftHendle != nil {
                leftHendle!()
            }
            
        }

        @IBAction func clickMiddleBtn(_ sender: Any) {
            if middleHendle != nil {
                middleHendle!()
            }
        }

    }
