//
//  BaseImagePickerViewController.swift
//  swiftdemo
//
//  Created by qf on 2020/9/1.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class BaseImagePickerViewController: UIViewController {

    // 自定义导航栏
        lazy var customNavBar: CustomNavgationViews = {
            let nav = CustomNavgationViews()
            return nav
        }()
        // 右边第一个按钮
        lazy var rightBtn: UIButton = {
            let btn = UIButton()
            btn.adjustsImageWhenHighlighted = false
            btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: 10, bottom: 0, right: 0)
            btn.setTitleColor(UIColor.black, for: .normal)
            btn.titleLabel?.font = UIFont.systemFont(ofSize: 16)
            btn.addTarget(self, action: #selector(BaseImagePickerViewController.rightBtnClick), for: UIControl.Event.touchUpInside)
            return btn
        }()
        // 标题
        var navTitle = "" {
            didSet{
                customNavBar.titleLable.text = navTitle
            }
        }
        // 返回按钮
        lazy var backBtn: UIButton = {
            let btn = UIButton()
            btn.imageEdgeInsets = UIEdgeInsets(top: 0, left: -12, bottom: 0, right: 0)
            btn.setImage(UIImage(named: "icn_icn_back_white", in: BundleUtil.getCurrentBundle(), compatibleWith: nil), for:UIControl.State())
            btn.addTarget(self, action: #selector(BaseImagePickerViewController.backBtnclick), for: .touchUpInside)
            return btn
        }()
        
        lazy var toobar: UIToolbar = {
            // 添加磨玻璃
            let toolBar = UIToolbar.init()
            toolBar.barStyle = .default
            return toolBar
        }()
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.view.backgroundColor = UIColor.white
            if #available(iOS 11.0, *) {
                UIScrollView.appearance().contentInsetAdjustmentBehavior  = .never
            }else {
                self.automaticallyAdjustsScrollViewInsets = false;
             }
            
            self.navigationController?.navigationBar.isHidden = true
            self.navigationController?.navigationBar.isTranslucent = false
            
            self.setupNav()
            initLayout()
        }
        
        func initLayout() {
            let titleY: CGFloat = UIDevice.id_isX() == true ? 40:20

            self.customNavBar.translatesAutoresizingMaskIntoConstraints = false
            self.toobar.translatesAutoresizingMaskIntoConstraints = false
            self.rightBtn.translatesAutoresizingMaskIntoConstraints = false
            self.backBtn.translatesAutoresizingMaskIntoConstraints = false

            // 导航栏
            self.customNavBar.addConstraint(NSLayoutConstraint.init(item: self.customNavBar, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: KNavgationBarHeight))
            self.view.addConstraints([
                NSLayoutConstraint.init(item: self.customNavBar, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0),
                NSLayoutConstraint.init(item: self.customNavBar, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0),
                NSLayoutConstraint.init(item: self.customNavBar, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.view, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
                ])
            // toolbar
            self.toobar.addConstraint(NSLayoutConstraint.init(item: self.toobar, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: KNavgationBarHeight))
            self.customNavBar.addConstraints([
                NSLayoutConstraint.init(item: self.toobar, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.customNavBar, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0),
                NSLayoutConstraint.init(item: self.toobar, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.customNavBar, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: 0),
                NSLayoutConstraint.init(item: self.toobar, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.customNavBar, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
                ])
            // 右边的按钮
            self.rightBtn.addConstraint(NSLayoutConstraint.init(item: self.rightBtn, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: 44))
            self.rightBtn.addConstraint(NSLayoutConstraint.init(item: self.rightBtn, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: 64))
            self.customNavBar.addConstraints([
                NSLayoutConstraint.init(item: self.rightBtn, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.customNavBar, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: titleY),
                NSLayoutConstraint.init(item: self.rightBtn, attribute: NSLayoutConstraint.Attribute.trailing, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.customNavBar, attribute: NSLayoutConstraint.Attribute.trailing, multiplier: 1, constant: 0)
                ])
            
            // 返回按钮
            self.backBtn.addConstraint(NSLayoutConstraint.init(item: self.backBtn, attribute: NSLayoutConstraint.Attribute.height, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: 44))
            self.backBtn.addConstraint(NSLayoutConstraint.init(item: self.backBtn, attribute: NSLayoutConstraint.Attribute.width, relatedBy: NSLayoutConstraint.Relation.equal, toItem: nil, attribute: NSLayoutConstraint.Attribute.notAnAttribute, multiplier: 0, constant: 50))
            self.customNavBar.addConstraints([
                NSLayoutConstraint.init(item: self.backBtn, attribute: NSLayoutConstraint.Attribute.top, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.customNavBar, attribute: NSLayoutConstraint.Attribute.top, multiplier: 1, constant: titleY),
                NSLayoutConstraint.init(item: self.backBtn, attribute: NSLayoutConstraint.Attribute.leading, relatedBy: NSLayoutConstraint.Relation.equal, toItem: self.customNavBar, attribute: NSLayoutConstraint.Attribute.leading, multiplier: 1, constant: 0)
                ])
        }
        
        // 先不要写在initview中，因为如果写在initview中就需要在子类中必须实现initView方法，并且调用super.initView()
        fileprivate func setupNav(){
            // 添加导航栏
            self.view.addSubview(self.customNavBar)
            // 右边按钮
            self.customNavBar.addSubview(self.rightBtn)
            
            // 毛玻璃效果
            self.customNavBar.addSubview(self.toobar)
            self.customNavBar.sendSubviewToBack(self.toobar)
            
            self.customNavBar.addSubview(self.backBtn)
            self.backBtn.isHidden = true
            
            // 设置位置，适配iphonex
            let titleY: CGFloat = UIDevice.id_isX() == true ? 40:20
            self.rightBtn.id_y = titleY
            self.backBtn.id_y = titleY
        }
        override func viewWillAppear(_ animated: Bool) {
            super.viewWillAppear(animated)
            if CLPickersTools.instence.navColor == nil {
                self.toobar.isHidden = false
                self.customNavBar.backgroundColor = UIColor.clear
            } else {
                self.customNavBar.backgroundColor = CLPickersTools.instence.navColor
                self.toobar.isHidden = true
            }
            
            if CLPickersTools.instence.navTitleColor != nil {
                self.backBtn.imageView?.tintColor = CLPickersTools.instence.navTitleColor
                let img = self.backBtn.image(for: .normal)?.withRenderingMode(.alwaysTemplate)
                self.backBtn.setImage(img, for: .normal)
                
                self.customNavBar.titleLable.textColor = CLPickersTools.instence.navTitleColor
                self.rightBtn.setTitleColor(CLPickersTools.instence.navTitleColor, for: .normal)
            } else {
                self.backBtn.imageView?.tintColor = UIColor.black
                let img = self.backBtn.image(for: .normal)?.withRenderingMode(.alwaysTemplate)
                self.backBtn.setImage(img, for: .normal)
                
                self.customNavBar.titleLable.textColor = UIColor.black
                self.rightBtn.setTitleColor(UIColor.black, for: .normal)
            }
        }

        override var preferredStatusBarStyle: UIStatusBarStyle {
            if  CLPickersTools.instence.statusBarType == .black {
                return .default
            }
            return .lightContent
        }
        @objc func rightBtnClick(){
            
        }
        @objc func backBtnclick(){
            
        }
    }


