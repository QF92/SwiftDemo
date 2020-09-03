//
//  OtherTabBarVC.swift
//  swiftdemo
//
//  Created by qf on 2020/9/3.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

/// [Notification key] 双击`TabBar`通知key
let NDoubleTapTabBarNotification = NSNotification.Name("DoubleTapTabBar")

class OtherTabBarVC: UITabBarController,TabBarDelegate {

    override func viewDidLoad() {
        super.viewDidLoad()

// KVC替换自己的`tabBar`
        let tabBar = BaseTabBar()
        tabBar.tabBarDelegate = self
        setValue(tabBar, forKeyPath: "tabBar")
        
        // 自定义了`TabBar`，所以下面的title和image参数是没啥用的，这里仅为了记录正常创建ChildVC的方法
        addChild("首页", "icn_nocolor_icn_components", "icn_color_icn_components",  MainViewController.self)
        addChild("健身房", "icn_nocolor_icn_uikit", "icn_color_icn_uikit", UIKitViewController.self)
        addChild("光猪圈", "icn_nocolor_icn_utils", "icn_color_icn_utils", UnitViewController.self)

    }
    /// 初始化并添加一个子控制器
    /// - Parameters:
    ///   - title: 标题
    ///   - image: 图标
    ///   - selectedImage: 选中时的图标
    ///   - type: 控制器
    func addChild(_ title: String,
                  _ image: String,
                  _ selectedImage: String,
                  _ type: UIViewController.Type) {
        let vc = BaseNavViewController(rootViewController: type.init())
        vc.title = title
        vc.tabBarItem.image = UIImage(named: image)
        vc.tabBarItem.selectedImage = UIImage(named: selectedImage)
        vc.tabBarItem.setTitleTextAttributes([.foregroundColor: UIColor.black], for: .selected)
        addChild(vc)
    }
}


// MARK: - TabBarDelegate
extension OtherTabBarVC{
    
    /// 单击某个item的代理回调
    /// - Parameters:
    ///   - tabBar: DTabBar对象
    ///   - index: 点击Item的索引
    @objc func singleTap(tabBar:BaseTabBar, index: Int)  {
        selectedIndex = index
    }
    
    /// 双击某个item的代理回调
    /// - Parameters:
    ///   - tabBar: DTabBar对象
    ///   - index: 点击Item的索引
    @objc func doubleTap(tabBar:BaseTabBar, index: Int) {
        // 通知刷新数据，eg: 圈子，我的
        NotificationCenter.default.post(name: NDoubleTapTabBarNotification, object: nil)
    }

}
