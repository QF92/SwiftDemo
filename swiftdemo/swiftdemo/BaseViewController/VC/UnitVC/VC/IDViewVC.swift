//
//  IDViewVC.swift
//  swiftdemo
//
//  Created by qf on 2020/9/2.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class IDViewVC: BaseViewController {

     @IBOutlet weak var view3: UIView!
      @IBOutlet weak var VIEW2: UIView!
      @IBOutlet weak var view1: UIView!
      @IBOutlet weak var testView: UIView!
      override func viewDidLoad() {
          super.viewDidLoad()

          self.id_navTitle = "UIView属性扩展"
          
          self.testView.id_addGradientLayer(gradientColors: [UIColor.red, UIColor.blue], gradientDirection: UIViewGradientDirection.horizontally)
          
          self.view1.id_border(1,UIColor.red, 5)
          self.VIEW2.id_borderSpecified(UIRectCorner.topLeft, cornerRadius: 6)
          self.view3.id_borderSpecified(UIRectCorner.topRight, cornerRadius: 6)
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
