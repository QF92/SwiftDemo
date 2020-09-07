//
//  ToastManager.swift
//  swiftdemo
//
//  Created by qf on 2020/8/31.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class ToastManager{
    public static let share = ToastManager()

    public var successImage = UIImage(named: "ic_toast_success", in: BundleUtil.getCurrentBundle(), compatibleWith: nil)
    public var failImage = UIImage(named:"icn_icn_fail", in: BundleUtil.getCurrentBundle(), compatibleWith: nil)
    public var warnImage = UIImage(named:"icon_sign", in: BundleUtil.getCurrentBundle(), compatibleWith: nil)

    public var bgColor = UIColor.black
    public var textColor = UIColor.white
    public var textFont = UIFont.systemFont(ofSize: 16)
    public var cornerRadius: CGFloat = 5
    public var supportQuene: Bool = true

    private let queue: OperationQueue = {
        let queue = OperationQueue()
        queue.maxConcurrentOperationCount = 1
        return queue
    }()
    
    public func id_resetDefaultProps() {
        self.common()
    }
    
    @available(*, deprecated, message: "Use 'cl_reset' instead.")
    public func reset() {
        self.common()
    }
    
    func common() {
        self.bgColor = UIColor.black
        self.textColor = UIColor.white
        self.textFont = UIFont.systemFont(ofSize: 16)
        self.cornerRadius = 5
        self.successImage = UIImage(named: "ic_toast_success", in: BundleUtil.getCurrentBundle(), compatibleWith: nil)
        self.failImage = UIImage(named: "icn_icn_fail", in: BundleUtil.getCurrentBundle(), compatibleWith: nil)
        self.warnImage = UIImage(named: "icon_sign", in: BundleUtil.getCurrentBundle(), compatibleWith: nil)
        
        self.supportQuene = true
    }
    
    func add(_ toast: ToastUtils) {
        self.queue.addOperation(toast)
    }
    public func cancelAll() {
        self.queue.cancelAllOperations()
    }
}
