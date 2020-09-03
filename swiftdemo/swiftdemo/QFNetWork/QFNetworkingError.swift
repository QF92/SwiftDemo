//
//  QFNetworkingError.swift
//  swiftdemo
//
//  Created by qf on 2020/9/3.
//  Copyright © 2020 qf. All rights reserved.
//

import Foundation
/// 请求的错误反馈，继承`NSObject`为了让OC也能调用
public class QFNetworkingError: NSObject {
    /// 错误码
    @objc var code = -1
    /// 错误描述
    @objc var localizedDescription: String

    init(code: Int, desc: String) {
        self.code = code
        self.localizedDescription = desc
        super.init()
    }
}
