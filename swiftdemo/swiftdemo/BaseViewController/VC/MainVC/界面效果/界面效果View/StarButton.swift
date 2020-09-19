//
//  StarButton.swift
//  Dealist
//
//  Created by xyh on 2019/7/3.
//  Copyright © 2019 xyh. All rights reserved.
//

import UIKit

class StarButton: UIButton {
    //path
    var maskPath:UIBezierPath = UIBezierPath()
    
    /// 制作小星星
    override func layoutSubviews() {
        super.layoutSubviews()
        //半径
        let radius = Double(self.bounds.size.width/2)
        
        //路径
        maskPath = UIBezierPath()
        maskPath.move(to: CGPoint(x: radius, y: 0))
        //弧度
        let angle = Double.pi*4/5
        //绘制五次
        for index in 1...5 {
            let x = radius - sin(angle*Double(index))*radius
            let y = radius - cos(angle*Double(index))*radius
            maskPath.addLine(to: CGPoint(x: x, y: y))
        }
        //mask
        let maskLayer = CAShapeLayer()
        maskLayer.path = maskPath.cgPath
        self.layer.mask = maskLayer
    }
    
    /// 判断点击
    ///
    /// - Parameters:
    ///   - point: 点击点
    ///   - event: 点击事件
    /// - Returns: Bool
    override func point(inside point: CGPoint, with event: UIEvent?) -> Bool {
        if maskPath.contains(point){
            return true
        }else{
            return false
        }
    }
    /*
    // Only override draw() if you perform custom drawing.
    // An empty implementation adversely affects performance during animation.
    override func draw(_ rect: CGRect) {
        // Drawing code
    }
    */

}
