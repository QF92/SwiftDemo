//
//  LabelVC.swift
//  swiftdemo
//
//  Created by qf on 2020/9/1.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class LabelVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.id_navTitle = "BaseLabel"
        self.view.backgroundColor = UIColor.groupTableViewBackground
        
        self.view.addSubview(self.title1)
        self.view.addSubview(self.bottomView1)
        self.view.addSubview(self.title2)
        self.view.addSubview(self.bottomView2)
        
        self.bottomView1.addSubview(self.label2)
        self.bottomView1.addSubview(self.label3)
        self.bottomView1.addSubview(self.label4)
        
        self.bottomView2.addSubview(self.titleLabel)
        self.bottomView2.addSubview(self.tef)
        // Do any additional setup after loading the view.
    }
    
    lazy var titleLabel: BaseLabel = {
        let label =  BaseLabel.init(frame: CGRect.init(x: 30, y: 20, width: 160, height: 30))
        label.text = "测试复制功能"
        label.id_canCopy = true
        return label
    }()
    
    lazy var tef: UITextField = {
        let tes = UITextField.init(frame: CGRect.init(x: 30, y: 70, width: 160, height: 30))
        tes.placeholder = "测试复制,粘贴到此"
        return tes
    }()
    
    lazy var label2: BaseLabel = {
        let label =  BaseLabel.init(frame: CGRect.init(x: 30, y: 20, width: 160, height: 30))
        label.text = "测试富文本"
        label.id_canCopy = true
        label.textColor = UIColor.black
        label.id_setupAttbutImage(img: UIImage(named: "ic_new")!, index: 5)
        return label
    }()
    lazy var label3: BaseLabel = {
        let label =  BaseLabel.init(frame: CGRect.init(x: 30, y: self.label2.frame.maxY + 20, width: 160, height: 30))
        label.text = "测试富文本"
        label.id_canCopy = true
        label.textColor = UIColor.black
        label.id_setupAttbutImage(img: UIImage(named: "ic_new")!, index: 0)
        return label
    }()
    
    lazy var label4: BaseLabel = {
        let label =  BaseLabel.init(frame: CGRect.init(x: 30, y: self.label3.frame.maxY + 20, width: 160, height: 30))
        label.text = "测试富文本"
        label.textColor = UIColor.black
        label.id_setupAttbutImage(img: UIImage(named: "ic_new")!, index: 3)
        return label
    }()
    
    lazy var title1: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 10, y: 90, width: 100, height: 30))
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "图文混排"
        return label
    }()
    lazy var bottomView1: UIView = {
        let bottom = UIView.init(frame: CGRect.init(x: 0, y: self.title1.frame.maxY, width: KScreenWidth, height: 200))
        bottom.backgroundColor = UIColor.white
        return bottom
    }()
    lazy var title2: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 10, y: self.bottomView1.frame.maxY+10, width: 100, height: 30))
        label.textColor = UIColor.lightGray
        label.font = UIFont.systemFont(ofSize: 15)
        label.text = "长按复制"
        return label
    }()
    lazy var bottomView2: UIView = {
        let bottom = UIView.init(frame: CGRect.init(x: 0, y: self.title2.frame.maxY, width: KScreenWidth, height: 200))
        bottom.backgroundColor = UIColor.white
        return bottom
    }()
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
