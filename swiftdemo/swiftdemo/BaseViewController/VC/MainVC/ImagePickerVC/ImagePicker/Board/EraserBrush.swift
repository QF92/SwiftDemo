//
//  EraserBrush.swift
//  swiftdemo
//
//  Created by qf on 2020/9/1.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class EraserBrush: PencilBrush {
    override func drawInContext(_ context: CGContext) {
        context.setBlendMode(CGBlendMode.clear)
        
        super.drawInContext(context)
    }
}
