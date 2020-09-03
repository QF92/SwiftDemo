//
//  ColorExtension.swift
//  swiftdemo
//
//  Created by qf on 2020/8/27.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

public extension UIColor{
    convenience init(hexString: String){
        let hex = hexString.trimmingCharacters(in: CharacterSet.alphanumerics.inverted)
        var int = UInt32()
        Scanner(string: hex).scanHexInt32(&int)
        let a, r, g, b: UInt32
        switch hex.count {
        case 3: // RGB (12-bit)
            (a, r, g, b) = (255, (int >> 8) * 17, (int >> 4 & 0xF) * 17, (int & 0xF) * 17)
        case 6: // RGB (24-bit)
            (a, r, g, b) = (255, int >> 16, int >> 8 & 0xFF, int & 0xFF)
        case 8: // ARGB (32-bit)
            (a, r, g, b) = (int >> 24, int >> 16 & 0xFF, int >> 8 & 0xFF, int & 0xFF)
        default:
            (a, r, g, b) = (255, 0, 0, 0)
        }
        self.init(red: CGFloat(r) / 255, green: CGFloat(g) / 255, blue: CGFloat(b) / 255, alpha: CGFloat(a) / 255)
    }
    
    /// 使用Int值快速创建颜色
    convenience init(redValue: Int, green: Int, blue: Int, alpha: CGFloat) {
        self.init(red: CGFloat(redValue) / 255.0, green: CGFloat(green) / 255.0, blue: CGFloat(blue) / 255.0, alpha: alpha)
    }
    
    /// rgb数组
    func convertRGB() -> [Int]? {
        var fRed : CGFloat = 0
        var fGreen : CGFloat = 0
        var fBlue : CGFloat = 0
        var fAlpha: CGFloat = 0
        if self.getRed(&fRed, green: &fGreen, blue: &fBlue, alpha: &fAlpha) {
            let iRed = Int(fRed * 255.0)
            let iGreen = Int(fGreen * 255.0)
            let iBlue = Int(fBlue * 255.0)
            //            let iAlpha = Int(fAlpha * 255.0)
            return [iRed, iGreen, iBlue]
        } else {
            // Could not extract RGBA components:
            return [13, 122, 255]
        }
    }
  /// 快捷构造器-RGBA色值，RGB取值范围是[0...255], alpha取值范围是[0...1]
        /// - Author: HouWan
        /// - Parameters:
        ///   - r: red
        ///   - g: green
        ///   - b: blue
        ///   - a: alpha, default: 1.0
    convenience init(r: CGFloat, g: CGFloat, b: CGFloat, a: CGFloat = 1.0) {
            self.init(red: r/255.0, green: g/255.0, blue:b/255.0, alpha:a)
        }
        
        /// Same as above!
    convenience init(_ r: CGFloat, _ g: CGFloat, _ b: CGFloat, _ a: CGFloat = 1.0) {
            self.init(red: r/255.0, green: g/255.0, blue:b/255.0, alpha:a)
        }
        
        /// 使用十六进制颜色码生成`UIColor`对象, eg:`UIColor(0xFF2D3A)`
        /// - Author: HouWan
        /// - Parameters:
        ///   - hexValue: 十六进制数值
        ///   - alpha: alpha, default: 1.0, alpha取值范围是[0...1]
    convenience init(_ hexValue: Int, alpha: Float = 1.0) {
            self.init(red: CGFloat((hexValue & 0xFF0000) >> 16) / 255.0,
                    green: CGFloat((hexValue & 0x00FF00) >> 8) / 255.0,
                     blue: CGFloat(hexValue & 0x0000FF) / 255.0,
                    alpha: CGFloat(alpha))
        }
        
        /// 使用十六进制颜色码生成`UIColor`对象, eg:`UIColor.hexColor(0xFF2D3A)`
        /// - Author: HouWan
        /// - Parameters:
        ///   - hexValue: 十六进制数值
        ///   - alpha: alpha, default: 1.0, alpha取值范围是[0...1]
        /// - Returns: 十六进制颜色
        class func hexColor(_ hexValue: Int, alpha: Float = 1.0) -> UIColor {
            return UIColor(hexValue, alpha: alpha)
    }
}

// MARK: - Properties
extension UIColor {
        /// 返回一个随机得出来的RGB颜色, 透明度为1.0
        class var random: UIColor {
            let red = CGFloat(Int.random(in: 0...255))
            let green = CGFloat(Int.random(in: 0...255))
            let blue = CGFloat(Int.random(in: 0...255))
            return UIColor.init(red, green, blue)
    }
}


