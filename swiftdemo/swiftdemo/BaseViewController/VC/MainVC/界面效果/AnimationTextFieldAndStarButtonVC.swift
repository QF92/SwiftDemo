//
//  AnimationTextFieldAndStarButtonVC.swift
//  Dealist
//
//  Created by xyh on 2019/7/3.
//  Copyright © 2019 xyh. All rights reserved.
//

import UIKit
import AnyImageKit

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
        
        let btn = UIButton.init(type: UIButton.ButtonType.system)
        btn.frame = CGRect(x: 200, y: 580, width: 150, height: 50)
        btn.backgroundColor = UIColor.blue
        btn.setTitle("AnyImageKit 图片选择", for: UIControl.State.normal)
        btn.setTitleColor(UIColor.white, for:.normal)
        
        btn.addTarget(self, action: #selector(clickbtn(sender:)), for: .touchUpInside)
        self.view.addSubview(btn)
        // Do any additional setup after loading the view, typically from a nib.
    }
    @objc func btnSelector(sender: StarButton){
        print("我点到了")
    }
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        self.view.endEditing(true)
    }
    
    @objc func clickbtn(sender: UIButton){
        print("我点到了aaaa")
        let options = PickerOptionsInfo()
        let controller = ImagePickerController(options: options, delegate: self)
        controller.
        controller.modalPresentationStyle = .fullScreen
        present(controller, animated: true, completion: nil)
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

extension AnimationTextFieldAndStarButtonVC:ImagePickerControllerDelegate {
    
    /// 取消选择（该方法有默认实现，可以省略）
    func imagePickerDidCancel(_ picker: ImagePickerController) {
        // 你的业务代码，处理取消(存在默认实现，如果需要额外行为请自行实现本方法)
        picker.dismiss(animated: true, completion: nil)
    }

    /// 完成选择
    /// - Parameters:  - picker: 图片选择器    - result: 返回结果对象，内部包含所选中的图片资源
    func imagePicker(_ picker: ImagePickerController, didFinishPicking assets: [Asset], useOriginalImage: Bool) {
        
    }
   
}
