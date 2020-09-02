//
//  TextViewVC.swift
//  swiftdemo
//
//  Created by qf on 2020/9/1.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class TextViewVC: BaseViewController {

    lazy var textView2: BaseTextView = {
        let text = BaseTextView.init(frame: CGRect.init(x: 10, y: 150, width: KScreenWidth-20, height: 80))
        text.id_placehoder = "我是代码创建的"
        return text
    }()
    
    lazy var textView3: BaseTextView = {
        let text = BaseTextView.init(frame: CGRect.init(x: 10, y: 300, width: KScreenWidth-20, height: 50))
        text.id_placehoder = "支持高度自动增加"
        text.id_supportAutoHeight = true
        return text
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.id_navTitle = "TextView"
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
        
        self.view.addSubview(self.textView2)
        self.view.addSubview(self.textView3)
        
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
