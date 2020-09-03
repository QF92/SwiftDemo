//
//  BaseNavViewController.swift
//  swiftdemo
//
//  Created by qf on 2020/1/19.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class BaseNavViewController: UINavigationController {
    override open func viewDidLoad() {
        super.viewDidLoad()
    }
    
    //push时候自动隐藏bottomBar
    override open func pushViewController(_ viewController: UIViewController, animated: Bool) {
        
        if viewControllers.count > 0 {
//        if children.count > 0 {
            // push时隐藏tabBar if是为了解决push回来时，没有底部导航的问题
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    override open func popViewController(animated: Bool) -> UIViewController? {
        return  super.popViewController(animated: animated)
    }
}
