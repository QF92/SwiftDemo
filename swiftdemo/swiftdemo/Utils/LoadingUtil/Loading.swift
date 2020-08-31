//
//  Loading.swift
//  swiftdemo
//
//  Created by qf on 2020/8/31.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit
public enum LoadingUtilLoadingType {
    case wait  // 会阻止用户交互， 需要等待加载完成
    case nav // 一条进度线条
    case free // 不会阻止用户交互
}

// 默认展示可以与用户交互的视图
// 支持3种类型
class Loading: NSObject {
     static var gifUtil: LoadingGifUtil?
         static var freeUtil: LoadingFreeUtil?
         static var waitUtil: LoadingWaitUtil?
         static var navUtil: LoadingNavUtil?
         
         // 默认展示不会阻止用户交互的控件
         public static func id_show(onView: UIView? = nil) {
             if self.freeUtil != nil {
                 self.id_dismiss()
             }
             self.freeUtil = LoadingFreeUtil.init(onView: onView)
         }
         // 展示阻止用户交互的控件
         public static func id_showWithWait(onView: UIView? = nil) {
             if self.waitUtil != nil {
                 self.id_dismissWait()
             }
             self.waitUtil = LoadingWaitUtil.init(onView: onView)
         }
         
         // 展示进度条
         public static func id_showProgressLine(onView: UIView, colors: [CGColor]? = nil) {
             if self.navUtil != nil {
                 self.id_dismissNav()
             }
             self.navUtil = LoadingNavUtil(onView: onView, colors: colors)
         }
         
         // 展示自定义的gif图
         public static func id_showGif(gifName: String? = nil,type: LoadingUtilLoadingType? = nil, onView: UIView? = nil) {
             if self.gifUtil != nil {
                 self.id_dismissGif()
             }
             self.gifUtil = LoadingGifUtil.init(gifName: gifName,type: type,  onView: onView)
         }

         // 对应id_show
         public static func id_dismiss() {
             self.freeUtil?.dismiss()
             self.freeUtil = nil
         }
         // 对应id_showGif
         public static func id_dismissGif() {
             self.gifUtil?.dismiss()
             self.gifUtil = nil
         }
         // 对应id_showWithOverlay
         public static func id_dismissWait() {
             self.waitUtil?.dismiss()
             self.waitUtil = nil
         }
         
         public static func id_dismissNav() {
             self.navUtil?.dismiss()
             self.navUtil = nil
         }
         
     }
