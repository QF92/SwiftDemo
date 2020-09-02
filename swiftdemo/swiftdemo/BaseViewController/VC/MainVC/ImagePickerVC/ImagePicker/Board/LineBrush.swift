//
//  LineBrush.swift
//  swiftdemo
//
//  Created by qf on 2020/9/1.
//  Copyright © 2020 qf. All rights reserved.
//
//  直线
import UIKit

class LineBrush: BaseBrush {
    override func drawInContext(_ context: CGContext) {
        context.move(to: CGPoint(x: beginPoint.x, y: beginPoint.y))
        context.addLine(to: CGPoint(x: endPoint.x, y: endPoint.y))
    }
}
