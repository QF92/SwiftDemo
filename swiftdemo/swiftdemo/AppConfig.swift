//
//  AppConfig.swift
//  swiftdemo
//
//  Created by qf on 2020/1/19.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit
/// 屏幕宽度
var KScreenHeight = UIScreen.main.bounds.height
/// 屏幕高度
var KScreenWidth = UIScreen.main.bounds.width
/// 屏幕比例
var kScale = UIScreen.main.scale
/// 导航栏高度+状态栏(iphonex 88)
var KNavgationBarHeight: CGFloat = UIDevice.id_isX() == true ? 88:64
/// tabbar高度(iphonex 83)
var KTabBarHeight: CGFloat = UIDevice.id_isX() == true ? 83:49
/// iphonex 底部间距
var IphoneXBottomSpace: CGFloat = UIDevice.id_isX() == true ? 34:0

func isiPhoneX() ->Bool {
    let screenHeight = UIScreen.main.nativeBounds.size.height;
    if screenHeight == 2436 || screenHeight == 1792 || screenHeight == 2688 || screenHeight == 1624 {
        return true
    }
    return false
}

var dialogWidth: CGFloat = 300

var RGBAColor: (CGFloat, CGFloat, CGFloat) -> UIColor = {red, green, blue in
    return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: 1);
}

var RGBAColorAlpha: (CGFloat, CGFloat, CGFloat, CGFloat) -> UIColor = {red, green, blue, alpha in
    return UIColor(red: red / 255, green: green / 255, blue: blue / 255, alpha: alpha);
}

/// 根据色值生成颜色(无透明度)(格式为0xffffff)
//var gof_ColorWithHex: (NSInteger) -> UIColor = { hex in
//    return UIColor(red: ((CGFloat)((hex & 0xFF0000) >> 16)) / 255.0, green: ((CGFloat)((hex & 0xFF00) >> 8)) / 255.0, blue: ((CGFloat)(hex & 0xFF)) / 255.0, alpha: 1);
//}

/// 系统普通字体
var gof_SystemFontWithSize: (CGFloat) -> UIFont = {size in
    return UIFont.systemFont(ofSize: size);
}

/// 系统加粗字体
var gof_BoldFontWithSize: (CGFloat) -> UIFont = {size in
    return UIFont.boldSystemFont(ofSize: size);
}

// MARK:- 设置圆角
func HDViewsBorder(_ view:UIView, borderWidth:CGFloat, borderColor:UIColor?=nil,cornerRadius:CGFloat){
    view.layer.borderWidth = borderWidth;
    view.layer.borderColor = borderColor?.cgColor
    view.layer.cornerRadius = cornerRadius
    view.layer.masksToBounds = true
}

let HDWindow = UIApplication.shared.keyWindow
let HDNotificationCenter = NotificationCenter.default
let HDUserDefaults = UserDefaults.standard

func keywindows() -> UIWindow? {
     
     var window:UIWindow? = nil
     
     if #available(iOS 13.0, *) {
     
        for windowScene:UIWindowScene in ((UIApplication.shared.connectedScenes as? Set<UIWindowScene>)!) {
     
        if windowScene.activationState == .foregroundActive {
         window = windowScene.windows.first
      break
       }
      }
         return window
      }else{
         return  UIApplication.shared.keyWindow
       }
     
    }
