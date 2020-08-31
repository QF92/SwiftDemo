//
//  ToastUtils.swift
//  swiftdemo
//
//  Created by qf on 2020/8/31.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit
public enum ToastUtilsImageType {
    case success
    case fail
    case warning
}
class ToastUtils: Operation {
     private var _executing = false
         override open var isExecuting: Bool {
             get {
                 return self._executing
             }
             set {
                 self.willChangeValue(forKey: "isExecuting")
                 self._executing = newValue
                 self.didChangeValue(forKey: "isExecuting")
             }
         }
         
         private var _finished = false
         override open var isFinished: Bool {
             get {
                 return self._finished
             }
             set {
                 self.willChangeValue(forKey: "isFinished")
                 self._finished = newValue
                 self.didChangeValue(forKey: "isFinished")
             }
         }
         
         var textToastView: TextToast = TextToast()   // 纯文本
         var imageToastView: ImageToast = ImageToast()  // 含有图片
         
         var textMessage: String? {
             get { return self.textToastView.text }
             set { self.textToastView.text = newValue }
         }
         
         var imgMessage: String? {
             get { return self.imageToastView.text }
             set { self.imageToastView.text = newValue }
         }
         
         // 动画起始值
         var animationFromValue: CGFloat = 0
         var superComponent: UIView = UIView()
         var showSuccessToast: ToastUtilsImageType?
         var duration: CGFloat = 1.5  // 默认展示2秒
         var position = ToastPosition.middle

         init(msg: String,onView:UIView? = nil,success: ToastUtilsImageType? = nil,duration:CGFloat? = nil, position: ToastPosition? = .middle) {
             
             self.superComponent = onView ?? (UIApplication.shared.keyWindow ?? UIView())
             self.showSuccessToast = success
             self.duration = duration ?? 1.5
             self.position = position ?? ToastPosition.middle
             
             super.init()
             
             if self.showSuccessToast == nil {
                 self.textMessage = msg
                 self.textToastView.position = self.position
             } else {
                 self.imgMessage = msg
                 self.imageToastView.position = self.position
             }

             // 单利队列中每次都加入一个新建的Operation
             ToastManager.share.add(self)
         }
         
         open override func cancel() {
             super.cancel()
             self.dismiss()
         }
         override func start() {
             let isRunnable = !self.isFinished && !self.isCancelled && !self.isExecuting
             guard isRunnable else { return }
             guard Thread.isMainThread else {
                 DispatchQueue.main.async { [weak self] in
                     self?.start()
                 }
                 return
             }
             main()
         }
         override func main() {
             self.isExecuting = true
             
             DispatchQueue.main.async {
                 if self.showSuccessToast == nil {
                     self.textToastView.titleLabel.textColor = ToastManager.share.textColor
                     self.textToastView.titleLabel.font = ToastManager.share.textFont
                     self.textToastView.backgroundColor = ToastManager.share.bgColor
                     self.textToastView.layer.cornerRadius = ToastManager.share.cornerRadius

                     self.textToastView.setNeedsLayout()
                     self.superComponent.addSubview(self.textToastView)
                 } else {
                     self.imageToastView.titleLabel.textColor = ToastManager.share.textColor
                     self.imageToastView.titleLabel.font = ToastManager.share.textFont
                     self.imageToastView.backgroundColor = ToastManager.share.bgColor
                     self.imageToastView.layer.cornerRadius = ToastManager.share.cornerRadius
                     
                     self.imageToastView.setNeedsLayout()
                     self.superComponent.addSubview(self.imageToastView)
                     if self.showSuccessToast == .success {
                         self.imageToastView.iconView.image = ToastManager.share.successImage
                     }
                     if self.showSuccessToast == .fail {
                         self.imageToastView.iconView.image = ToastManager.share.failImage
                     }
                     if self.showSuccessToast == .warning {
                         self.imageToastView.iconView.image = ToastManager.share.warnImage
                     }
                 }
                 
                 let shakeAnimation = CABasicAnimation.init(keyPath: "opacity")
                 shakeAnimation.duration = 0.5
                 shakeAnimation.fromValue = self.animationFromValue
                 shakeAnimation.toValue = 1
                 shakeAnimation.delegate = self
                 
                 if self.showSuccessToast == nil {
                     self.textToastView.layer.add(shakeAnimation, forKey: nil)
                 } else {
                     self.imageToastView.layer.add(shakeAnimation, forKey: nil)
                 }
             }
         }
     }

extension ToastUtils: CAAnimationDelegate {
         func animationDidStop(_ anim: CAAnimation, finished flag: Bool) {
             if flag {
                 UIView.animate(withDuration: 0.5, delay: TimeInterval(self.duration), options: UIView.AnimationOptions.allowUserInteraction, animations: {
                     if self.showSuccessToast == nil {
                         self.textToastView.alpha = 0
                     } else {
                         self.imageToastView.alpha = 0
                     }
                 }) { (finish) in
                     self.dismiss()
                 }
             }
         }
         
         func dismiss() {
             self.textToastView.removeFromSuperview()
             self.imageToastView.removeFromSuperview()
             self.finish()
         }
         
         func finish() {
             self.isExecuting = false
             self.isFinished = true
             
             if ToastManager.share.supportQuene == false {
                 ToastManager.share.cancelAll()
             }
         }
     }

