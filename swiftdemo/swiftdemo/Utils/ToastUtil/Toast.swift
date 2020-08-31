//
//  Toast.swift
//  swiftdemo
//
//  Created by qf on 2020/8/31.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

public enum ToastPosition{
    case top
    case middle
    case bottom
}
class Toast: NSObject {
    // 默认纯文本、展示在window上、2秒消失、中间位置
    // onView: 可以指定显示在指定的view上
    // success=nil,展示纯文本，success=false展示错误的图片，success=true展示成功的图片
    // position: 展示的位置
    public static func id_show(msg: String, onView:UIView? = nil,success: ToastUtilsImageType? = nil,duration:CGFloat? = nil, position: ToastPosition? = .middle) {
        DispatchQueue.main.async {
            _ = ToastUtils.init(msg: msg, onView: onView, success: success, duration: duration, position: position)
        }
    }
}
