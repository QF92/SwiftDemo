//
//  PopViewUtil.swift
//  swiftdemo
//
//  Created by qf on 2020/9/1.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class PopViewUtil: NSObject {
    @objc static let share = PopViewUtil()
        @objc var activite: UIActivityIndicatorView?
        
        @objc func showLoading() {
            activite = UIActivityIndicatorView.init(style:UIActivityIndicatorView.Style.large)
            activite?.frame = CGRect(x: 100, y: 100, width: 100, height: 100)
            activite?.center = (UIApplication.shared.windows.first?.center)!
            activite?.color = UIColor.black
            UIApplication.shared.windows.first?.addSubview(activite!)
            self.activite?.startAnimating()
        }
        @objc func stopLoading() {
            self.activite?.stopAnimating()
            self.activite?.removeFromSuperview()
            self.activite = nil
        }
        
        //MARK: - Returns: 当前控制器
        @objc public static func getCurrentViewcontroller() -> UIViewController?{
            let rootController = UIApplication.shared.windows.first?.rootViewController
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
        
        //MARK: - 标准的样式(标题，内容，左按钮，右按钮)
        @objc static func  alert(title: String!,message: String!,leftTitle: String!,rightTitle: String!,leftHandler: (() -> ())?,rightHandler: (() -> ())?){
    //        let alertVC = HDAlertVC()
    //        alertVC.alert(title: title, message: message, leftTitle: leftTitle, rightTitle: rightTitle, leftHandler: leftHandler, rightHandler: rightHandler)
            let alertView = HDAlertWindowView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height))
            alertView.alert(title: title, message: message, leftTitle: leftTitle, rightTitle: rightTitle, leftHandler: leftHandler, rightHandler: rightHandler)
        }
        
        //MARK: - 只有内容，左按钮，右按钮 或者只显示一个按钮
        @objc static func alert(message: String!,leftTitle: String!,rightTitle: String!,leftHandler: (() -> ())?,rightHandler: (() -> ())?){
    //        let alertVC = HDAlertVC()
    //        alertVC.alert(message: message, leftTitle: leftTitle, rightTitle: rightTitle, leftHandler: leftHandler, rightHandler: rightHandler)
            let alertView = HDAlertWindowView.init(frame: CGRect(x: 0, y: 0, width: UIScreen.main.bounds.width, height:  UIScreen.main.bounds.height))
            alertView.alert(message: message, leftTitle: leftTitle, rightTitle: rightTitle, leftHandler: leftHandler, rightHandler: rightHandler)
        }
    }

    //MARK: - toast相关
    extension PopViewUtil {
        
    }
