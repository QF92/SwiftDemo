//
//  UIView+IDeal.swift
//  swiftdemo
//
//  Created by qf on 2020/9/1.
//  Copyright © 2020 qf. All rights reserved.
//

import Foundation
import UIKit

extension UIView {

    static var EmptyViewKey: UInt8 = 0
    public var id_empty: EmptyView? {
        
        get {
            return (objc_getAssociatedObject(self, &UIView.EmptyViewKey) as? EmptyView)
        }
        
        set {
            if let view = newValue {
                self.id_empty?.removeFromSuperview()
                self.insertSubview(view, at: self.subviews.count)
                objc_setAssociatedObject(self, &UIView.EmptyViewKey, newValue, .OBJC_ASSOCIATION_RETAIN)
            }
        }
    }
}
