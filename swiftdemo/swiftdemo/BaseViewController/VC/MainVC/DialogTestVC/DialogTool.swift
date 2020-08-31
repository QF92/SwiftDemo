//
//  DialogTool.swift
//  swiftdemo
//
//  Created by qf on 2020/8/31.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class DialogTool: NSObject {
    /// 普通弹框
        public static func id_show(
                                   title: String? = nil,
                                   msg: String? = nil,
                                   countDownNumber: Int? = nil,
                                   leftActionTitle: String?,
                                   rightActionTitle: String?,
                                   leftHandler: (()->())? = nil,
                                   rightHandler:(()->())? = nil) {
            _ = DialogUtil.init(title: title, msg: msg, leftActionTitle: leftActionTitle, rightActionTitle: rightActionTitle, leftHandler: leftHandler, rightHandler: rightHandler,countDownNumber: countDownNumber,type: DialogUtilType.normal)
        }
        /// 带图片
        public static func id_showImg(
                                   success: DialogUtilImageType? = nil,
                                   msg: String? = nil,
                                   leftActionTitle: String?,
                                   rightActionTitle: String?,
                                   leftHandler: (()->())? = nil,
                                   rightHandler:(()->())? = nil) {
            _ = DialogUtil.init(msg: msg, leftActionTitle: leftActionTitle, rightActionTitle: rightActionTitle, leftHandler: leftHandler, rightHandler: rightHandler,success: success,type: DialogUtilType.image)
        }
        
        public static func id_showInput(
                                      msg: String? = nil,
                                      leftActionTitle: String?,
                                      rightActionTitle: String?,
                                      leftHandler: ((String)->())? = nil,
                                      rightHandler:((String)->())? = nil) {
            _ = DialogUtil.init(msg: msg, leftActionTitle: leftActionTitle, rightActionTitle: rightActionTitle, leftHandler: leftHandler, rightHandler: rightHandler, type: DialogUtilType.input)
        }
        
        /// 自定义内容
        public static func id_showCustom(
            msg: String? = nil,
            leftActionTitle: String?,
            rightActionTitle: String?,
            customView: UIView?,
            leftHandler: ((UIView?)->())? = nil,
            rightHandler:((UIView?)->())? = nil) {
            _ = DialogUtil.init(msg: msg, leftActionTitle: leftActionTitle, rightActionTitle: rightActionTitle,customView: customView, leftHandler: leftHandler, rightHandler: rightHandler, type: DialogUtilType.custom)
        }
    }
