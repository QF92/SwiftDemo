//
//  UnitViewController.swift
//  swiftdemo
//
//  Created by qf on 2020/3/9.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit
import Photos
class UnitViewController: UIViewController {

    override func viewDidLoad() {
        super.viewDidLoad()

        
//        获取图片,获取视频首帧
        let option = PHImageRequestOptions()
        option.isNetworkAccessAllowed = true //允许下载iCloud的图片
        option.resizeMode = .fast
        option.deliveryMode = .fastFormat
//        PHImageManager.default().requestImage(for: asset,
//                                              targetSize: self.bounds.size,
//                                              contentMode: .aspectFill,
//                                              options: option)
//        { (image, nil) in
//             //image就是图片
//        }
        // Do any additional setup after loading the view.
    }
    

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
