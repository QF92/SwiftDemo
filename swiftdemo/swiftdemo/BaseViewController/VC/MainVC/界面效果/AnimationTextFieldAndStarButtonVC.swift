//
//  AnimationTextFieldAndStarButtonVC.swift
//  Dealist
//
//  Created by xyh on 2019/7/3.
//  Copyright © 2019 xyh. All rights reserved.
//

import UIKit

class AnimationTextFieldAndStarButtonVC: BaseViewController {
    var id = AnimationTextFieldView ()
    var pas = AnimationTextFieldView ()
    override func viewDidLoad() {
        super.viewDidLoad()

        id = AnimationTextFieldView (frame: CGRect(x: 40, y: 400, width: 300, height: 40))
        id.placeHoderColor = UIColor.lightGray
        id.placeStr = " 请输入您的手机号码或者邮箱"
        id.textField.delegate = self as? UITextFieldDelegate
        id.animationType = DKAnimationType.DKAnimationUp
        
        id.textColor = UIColor.red
        
        pas = AnimationTextFieldView (frame: CGRect(x: 40, y: 500, width: 300, height: 40))
        pas.placeHoderColor = UIColor.lightGray
        pas.placeStr = " 请输入您的手机号码或者邮箱"
        pas.textField.delegate = self as? UITextFieldDelegate
        pas.animationType = DKAnimationType.DKAnimationSnake
        
        pas.textColor = UIColor.red
        
        self.view.addSubview(id)
        self.view.addSubview(pas)
        
        
        let wujiaoxingbtn = StarButton.init(type: .custom)//定义buttom为custom类型
        wujiaoxingbtn.frame = CGRect(x: 100, y: 580, width: 50, height: 50)
        wujiaoxingbtn.backgroundColor = UIColor.blue
        wujiaoxingbtn.addTarget(self, action: #selector(btnSelector(sender:)), for: .touchUpInside)
        self.view.addSubview(wujiaoxingbtn)
        // Do any additional setup after loading the view, typically from a nib.
    }
    @objc func btnSelector(sender: StarButton){
        print("我点到了")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
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
