//
//  BaseColorVC.swift
//  swiftdemo
//
//  Created by qf on 2020/9/2.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class BaseColorVC: BaseViewController {

     @IBOutlet weak var view1: UIView!
       
      @IBOutlet weak var view2: UIView!
       override func viewDidLoad() {
           super.viewDidLoad()
           
           self.id_navTitle = "颜色设置"

           self.view1.layer.cornerRadius = 40
           self.view2.layer.cornerRadius = 40

           
           self.view1.backgroundColor = UIColor.init(redValue: 13, green: 133, blue: 133, alpha: 1)
           self.view2.backgroundColor = UIColor.init(hexString: "#3423df")
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
