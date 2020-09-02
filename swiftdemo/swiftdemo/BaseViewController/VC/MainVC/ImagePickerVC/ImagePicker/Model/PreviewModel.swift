//
//  PreviewModel.swift
//  swiftdemo
//
//  Created by qf on 2020/9/1.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit
import Photos
import PhotosUI
class PreviewModel: NSObject {
    @objc var phAsset: PHAsset?
       @objc var downLoadProgress: CGFloat = 100  // 默认100
       @objc var index: Int = 0
       @objc var isCheck = true
       var img: UIImage?
}
