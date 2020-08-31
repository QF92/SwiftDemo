//
//  DealistConfig.swift
//  swiftdemo
//
//  Created by qf on 2020/8/31.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class DealistConfig: NSObject {
  public static let share = DealistConfig()
  
  // loading展示时间最长为60秒
  public var maxShowInterval: Float = 60
  
  /// switch主题色、progressView主题色、
  public var mainColor: UIColor = UIColor.init(red: 13/255.0, green: 133/255.0, blue: 255/255.0, alpha: 1)
  
  public func id_setupMainColor(color: UIColor) {
      self.mainColor = color
  }
}
