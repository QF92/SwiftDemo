//
//  UtilsThemeVC.swift
//  swiftdemo
//
//  Created by qf on 2020/9/2.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class UtilsThemeVC: BaseViewController {
    @IBOutlet weak var view3: UIView!
       @IBOutlet weak var view2: UIView!
       @IBOutlet weak var view1: UIView!
    override func viewDidLoad() {
        super.viewDidLoad()
        self.id_navTitle = "更换主题"
        // Do any additional setup after loading the view.
    }
    
    @IBAction func clickDefault(_ sender: Any) {
         
             DealistConfig.share.id_setupMainColor(color: UIColor.init(redValue: 13, green: 13, blue: 255, alpha: 1))
         
           DialogTool.id_show(msg: "设置成功", leftActionTitle: nil, rightActionTitle: "确定", leftHandler: nil, rightHandler: nil)
     }
     @IBAction func clickCustom1(_ sender: Any) {
         DealistConfig.share.id_setupMainColor(color: UIColor.init(redValue: 115, green: 109, blue: 216, alpha: 1))
         DialogTool.id_show(msg: "设置成功", leftActionTitle: nil, rightActionTitle: "确定", leftHandler: nil, rightHandler: nil)

     }
     @IBAction func clickCustom2(_ sender: Any) {
        DealistConfig.share.id_setupMainColor(color: UIColor.red)
        DialogTool.id_show(msg: "设置成功", leftActionTitle: nil, rightActionTitle: "确定", leftHandler: nil, rightHandler: nil)
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
