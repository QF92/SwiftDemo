//
//  ImageVC.swift
//  swiftdemo
//
//  Created by qf on 2020/9/1.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class ImageVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.id_navTitle = "IDImage"
        self.view.addSubview(self.label)
        self.view.addSubview(self.imgView)
        self.view.addSubview(self.label2)

        let img = UIImage.id_renderImageWithColor(UIColor.purple, size: CGSize.init(width: 80, height: 80))
        self.imgView.image = img
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
    lazy var imgView: UIImageView = {
        let img = UIImageView.init(frame: CGRect.init(x: 10, y:  KNavgationBarHeight + 40 + 40, width: 90, height: 90))
        return img
    }()
    lazy var label: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 10, y: KNavgationBarHeight + 40, width: KScreenWidth, height: 30))
        label.text = "通过颜色生成一张图片"
        return label
    }()
    lazy var label2: UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 10, y: KNavgationBarHeight + 160, width: KScreenWidth-20, height: 80))
        label.text = "self.imgView.image = UIImage.id_renderImageWithColor(UIColor.purple, size: CGSize.init(width: 80, height: 80))"
        label.numberOfLines = 0
        label.textColor = UIColor.lightGray
        return label
    }()

}
public extension UIImage{

    /// 通过颜色生成图片
    class func id_renderImageWithColor(_ color: UIColor, size: CGSize) -> UIImage {
        UIGraphicsBeginImageContext(size)
        guard let context = UIGraphicsGetCurrentContext() else {
            UIGraphicsEndImageContext()
            return UIImage()
        }
        context.setFillColor(color.cgColor);
        context.fill(CGRect(x: 0, y: 0, width: size.width, height: size.height));
        let img = UIGraphicsGetImageFromCurrentImageContext()
        UIGraphicsEndImageContext()
        return img ?? UIImage()
    }
}
