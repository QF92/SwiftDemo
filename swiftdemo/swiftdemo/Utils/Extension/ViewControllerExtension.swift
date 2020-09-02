//
//  ViewControllerExtension.swift
//  swiftdemo
//
//  Created by qf on 2020/9/2.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit
public extension UIViewController {
    //MARK: - Returns: 当前控制器
    func id_getCurrentViewcontroller() -> UIViewController?{
        let rootController = UIApplication.shared.windows[0].rootViewController
        if let tabController = rootController as? UITabBarController   {
            if let navController = tabController.selectedViewController as? UINavigationController{
                return navController.children.last
            }else{
                return tabController
            }
        }else if let navController = rootController as? UINavigationController {
            
            return navController.children.last
        }else{
            
            return rootController
        }
    }
}
