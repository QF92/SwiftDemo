//
//  File.swift
//  swiftdemo
//
//  Created by qf on 2020/9/1.
//  Copyright © 2020 qf. All rights reserved.
//

import Foundation
import UIKit
extension UIImage {
    // 对截取的长图进行压缩，因为项目中的长图是设置为背景颜色，如果不压缩到适当的尺寸图片就会平铺
    @objc static func scaleImage(image: UIImage) -> UIImage {
        let picBili: CGFloat = image.size.width/image.size.height

        // 图片大小   UIScreen.main.scale屏幕密度，不加这个图片会不清晰
        UIGraphicsBeginImageContextWithOptions(CGSize(width:KScreenWidth,height: KScreenWidth/picBili), false, UIScreen.main.scale)
        
        image.draw(in: CGRect(x: 0, y:0 , width: KScreenWidth, height: KScreenWidth/picBili))
        
        let scaledImage = UIGraphicsGetImageFromCurrentImageContext()
        
        UIGraphicsEndImageContext()
        
        return scaledImage!
    }
    
    // 截取一部分
    @objc static func screenShotForPart(view:UIView,size:CGSize) -> UIImage{
        var image = UIImage()
        UIGraphicsBeginImageContextWithOptions(size, true, 0)
        view.layer.render(in: UIGraphicsGetCurrentContext()!)
        image = UIGraphicsGetImageFromCurrentImageContext()!
        UIGraphicsEndImageContext()
        return image
    }
    
    // 生成马赛克图片
    @objc static func transToMosaicImage(orginImage: UIImage,level: NSInteger) -> UIImage{
        
        
        let context: CIContext = CIContext.init()
        let filter = CIFilter(name: "CIPixellate")!
        let inputImage = CIImage(image: orginImage)
        filter.setValue(inputImage, forKey: kCIInputImageKey)
        filter.setValue(level, forKey: kCIInputScaleKey) //值越大马赛克就越大(使用默认)
        let fullPixellatedImage = filter.outputImage
        let cgImage = context.createCGImage(fullPixellatedImage!,from: fullPixellatedImage!.extent)
        return UIImage.init(cgImage: cgImage!)
    }
    
    //创建打码区域
    @objc func createMaskImage(rect: CGRect ,centerX: CGFloat, centerY: CGFloat, radius:CGFloat)-> CIImage{
        let radialGradient = CIFilter(name: "CIRadialGradient",parameters: ["inputRadius0" : radius,"inputRadius1" : radius + 1,"inputColor0" : CIColor(red: 0, green: 1, blue: 0, alpha: 1),"inputColor1" : CIColor(red: 0, green: 0, blue: 0, alpha: 0),kCIInputCenterKey : CIVector(x: centerX, y: centerY)])
        let radialGradientOutputImage = radialGradient!.outputImage!.cropped(to: rect)
        return radialGradientOutputImage
    }

}


