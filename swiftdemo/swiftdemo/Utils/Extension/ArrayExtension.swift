//
//  ArrayExtension.swift
//  swiftdemo
//
//  Created by qf on 2020/9/2.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit
public extension Array {
    // 去重
    func id_filterDuplicates<E: Equatable>(_ filter: (Element) -> E) -> [Element] {
        var result = [Element]()
        for value in self {
            let key = filter(value)
            if !result.map({filter($0)}).contains(key) {
                result.append(value)
            }
        }
        return result
    }
}
