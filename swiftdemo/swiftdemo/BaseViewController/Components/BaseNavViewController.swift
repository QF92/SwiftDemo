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
        
        if children.count > 0 {
            // push时隐藏tabBar
            viewController.hidesBottomBarWhenPushed = true
        }
        super.pushViewController(viewController, animated: animated)
    }
    override open func popViewController(animated: Bool) -> UIViewController? {
        return  super.popViewController(animated: animated)
    }
}
