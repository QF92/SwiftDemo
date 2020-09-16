//
//  BaseTabBar.swift
//  swiftdemo
//
//  Created by qf on 2020/9/3.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit
// MARK: - 点击`BaseTabBar`事件代理回调
@objc protocol TabBarDelegate: NSObjectProtocol {
    
    /// 单击某个item的代理回调
    /// - Parameters:
    ///   - tabBar: BaseTabBar对象
    ///   - index: 点击Item的索引
    @objc func singleTap(tabBar:BaseTabBar, index: Int) -> Void
    
    /// 双击某个item的代理回调
    @objc optional func doubleTap(tabBar:BaseTabBar, index: Int) -> Void
}

// MARK: - 自定义`UITabBar`
class BaseTabBar: UITabBar {

    /// 当前选中的Item
        fileprivate var currentItem: TabBar_Item?
        /// 代理
        weak var tabBarDelegate: TabBarDelegate?
        
        
        ///=============================================================================
        /// - Note: Initialization 初始化
        ///=============================================================================
        
        override init(frame: CGRect) {
            super.init(frame: frame)
            createAndConfigUI()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            createAndConfigUI()
        }
        
        func createAndConfigUI() {
            isTranslucent = false
            backgroundColor = UIColor.white
            
            let list = [TabBarItemModel(t: "首页", i: "icn_nocolor_icn_components", s: "icn_color_icn_components"),
                        TabBarItemModel(t: "健身房", i: "icn_nocolor_icn_uikit", s: "icn_color_icn_uikit"),
                        TabBarItemModel(t: "光猪圈", i: "icn_nocolor_icn_utils", s: "icn_color_icn_utils")]
            
            let w: CGFloat = CGFloat(ceilf(Float(CGFloat(KScreenWidth / 3.0))))
            
            for (index, data) in list.enumerated() {
                let item = TabBar_Item(model: data)
                item.frame = CGRect(x: CGFloat(index) * w, y: 0.0, width: w, height: kTabBarHeight)
                addSubview(item)
                
                item.index = index;
                item.selected = index == 0;
                
                if index == 0 { currentItem = item }
                
                let singleTap = UITapGestureRecognizer(target: self, action: #selector(singleTap(tap:)))
                singleTap.numberOfTouchesRequired = 1
                singleTap.numberOfTapsRequired = 1
                item.addGestureRecognizer(singleTap)
                
                let doubleTap = UITapGestureRecognizer(target: self, action: #selector(doubleTap(tap:)))
                doubleTap.numberOfTouchesRequired = 1
                doubleTap.numberOfTapsRequired = 2
                item.addGestureRecognizer(doubleTap)
            }
        }
    }

// MARK: - TouchAction
extension BaseTabBar {
        
        /// 点击
        @objc func singleTap(tap: UITapGestureRecognizer) {
            let item = tap.view as! TabBar_Item
            guard item != currentItem else { return }
            
            currentItem?.selected = false
            item.selected = true
            currentItem = item
            
            animation(item: item)
            
            guard let d = tabBarDelegate else { return }
            
            if d.responds(to: #selector(d.singleTap(tabBar:index:))) {
                d.singleTap(tabBar: self, index: item.index!)
            }
        }
        
        /// 双击
        @objc func doubleTap(tap: UITapGestureRecognizer) {
            
            let item = tap.view as! TabBar_Item
            
            // 如果没有正在显示，按单击处理
            guard currentItem == item else {
                singleTap(tap: tap)
                return
            }
            
            guard let d = tabBarDelegate else { return }
            
            if d.responds(to: #selector(d.doubleTap(tabBar:index:))) {
                d.doubleTap?(tabBar: self, index: item.index!)
            }
        }
        
        /// 动画一下
        fileprivate func animation(item: TabBar_Item) {
            let pulse = CABasicAnimation(keyPath: "transform.scale")
            pulse.timingFunction = CAMediaTimingFunction(name: .easeInEaseOut)
            pulse.duration = 0.2
            pulse.autoreverses = true
            pulse.fromValue = 0.9
            pulse.toValue = 1.1
            item.iconView.layer.add(pulse, forKey: nil)
        }
    }


// MARK: - Override
extension BaseTabBar {
        // -------------------彻底移除系统items-------------------
        override var items: [UITabBarItem]? {
            get { return [] }
            set {}
        }
        override func setItems(_ items: [UITabBarItem]?, animated: Bool) {
        }
        // ----------------------------------------------------
}


    // MARK: - 自定义`UITabBar`的按钮
fileprivate class TabBar_Item: UIView {
        
        var model: TabBarItemModel?
        var index: Int?
        
        /// change UI style
        var selected: Bool = false {
            didSet {
                if selected {
                    iconView.image = UIImage(named: model!.selectedImage)
                    titleView.textColor = UIColor(0x2D2D2D)
                } else {
                    iconView.image = UIImage(named: model!.image)
                    titleView.textColor = UIColor(0xB0B0B0)
                }
            }
        }
        
        lazy var iconView: UIImageView = {
            let iconView = UIImageView()
            iconView.contentMode =  .bottom
            return iconView
        }()
        
        lazy var titleView: UILabel = {
            let title = UILabel.init(frame: CGRect.zero)
            title.textAlignment = .center
            title.font = UIFont.systemFont(ofSize: 10)
            title.textColor = UIColor(0x2D2D2D)
            return title
        }()
        
    lazy var NumBer:UILabel = {
        let num = UILabel.init()
        num.backgroundColor = UIColor.red
        num.layer.masksToBounds = true
        num.layer.cornerRadius = 5
        return num
    }()
        /// 设置Item显示所需数据
        /// - Parameters:
        ///   - model: 数据
        func configData(model: TabBarItemModel) {
            titleView.text = model.title
            iconView.image = UIImage(named: model.image)
            
            self.model = model
        }
        
        ///=============================================================================
        /// - Note: Initialization
        ///=============================================================================
        override init(frame: CGRect) {
            super.init(frame: frame)
            createUI()
        }
        
        required init?(coder: NSCoder) {
            super.init(coder: coder)
            createUI()
        }
        
        convenience init(model: TabBarItemModel) {
            self.init(frame: .zero)
            configData(model: model)
        }
        
        func createUI() {
            backgroundColor = UIColor.white
            addSubview(iconView)
            addSubview(titleView)
            addSubview(NumBer)
        }
        
        override func layoutSubviews() {
            super.layoutSubviews()
            iconView.frame = CGRect(x: 0, y: 0, width:id_width, height: 28)
            let y = iconView.id_bottom + 8
            titleView.frame = CGRect(x: 0, y: y, width:id_width, height: 12)
            NumBer.frame = CGRect.init(x: id_width/2-40, y: 0, width: 10, height: 10)
        }
    }


    /// 一个·TabBarItem·展示所需的全部数据
    fileprivate struct TabBarItemModel {
        var title: String
        var image: String
        var selectedImage: String

        /// Initialization
        /// - Parameters:
        ///   - t: title
        ///   - i: image name
        ///   - s: selectedImage name
        init(t: String, i: String, s: String) {
            title = t
            image = i
            selectedImage = s
        }
    }

