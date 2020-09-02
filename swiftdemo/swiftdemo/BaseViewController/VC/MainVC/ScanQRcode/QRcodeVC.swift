//
//  QRcodeVC.swift
//  swiftdemo
//
//  Created by qf on 2020/9/1.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class QRcodeVC: ScanCodeController {
     override func viewDidLoad() {
            super.viewDidLoad()

            self.customNavBar.backgroundColor = UIColor.white
            self.customNavBar.titleLable.textColor = UIColor.black
            self.rightBtn.setTitleColor(UIColor.black, for: .normal)
            self.backBtn.setImage(UIImage(named: "ic_back_grey"), for: .normal)
        }
        
        override var preferredStatusBarStyle: UIStatusBarStyle {
            return .default
        }
}
