//
//  UrlExtension.swift
//  swiftdemo
//
//  Created by qf on 2020/9/2.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit
public extension URL {
    // 过滤字符串中的特殊字符
    static func id_init(string:String) -> URL? {
        let urlStrVaile = string.addingPercentEncoding(withAllowedCharacters: CharacterSet.urlQueryAllowed)
        return URL(string: urlStrVaile ?? "")
    }
}
