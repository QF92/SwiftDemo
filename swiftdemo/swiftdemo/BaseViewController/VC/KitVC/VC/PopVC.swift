//
//  PopVC.swift
//  swiftdemo
//
//  Created by qf on 2020/9/1.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class PopVC: BaseViewController {
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.id_navTitle = "PopView"
        
        self.view.backgroundColor = UIColor.systemGroupedBackground

    }
    lazy var contentView: UIView = {
            let content = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 81))
            let btn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 150, height: 40))
            btn.setTitle("测试1", for: .normal)
            btn.addTarget(self, action: #selector(clickBtnTest), for: .touchUpInside)
            content.addSubview(btn)
            btn.setTitleColor(UIColor.black, for: .normal)
            let line = UIView.init(frame: CGRect.init(x: 0, y: 40, width: btn.frame.width, height: 1))
            line.backgroundColor = UIColor.systemGroupedBackground
            content.addSubview(line)
            let btn2 = UIButton.init(frame: CGRect.init(x: 0, y: 41, width: 150, height: 40))
            btn2.setTitle("测试2", for: .normal)
            btn2.addTarget(self, action: #selector(clickBtnTest), for: .touchUpInside)
            content.addSubview(btn2)
            btn2.setTitleColor(UIColor.black, for: .normal)
            return content
        }()
        lazy var contentView2: UIView = {
            let content = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 81))
            let btn = UIButton.init(frame: CGRect.init(x: 0, y: 0, width: 150, height: 40))
            btn.setTitle("测试1", for: .normal)
            btn.addTarget(self, action: #selector(clickBtnTest), for: .touchUpInside)
            content.addSubview(btn)
            btn.setTitleColor(UIColor.white, for: .normal)
            let line = UIView.init(frame: CGRect.init(x: 0, y: 40, width: btn.frame.width, height: 1))
            line.backgroundColor = UIColor.systemGroupedBackground
            content.addSubview(line)
            let btn2 = UIButton.init(frame: CGRect.init(x: 0, y: 41, width: 150, height: 40))
            btn2.setTitle("测试2", for: .normal)
            btn2.addTarget(self, action: #selector(clickBtnTest), for: .touchUpInside)
            content.addSubview(btn2)
            btn2.setTitleColor(UIColor.white, for: .normal)
            return content
        }()
        
        @IBAction func clickRight(_ sender: Any) {
            let pop = PopView.init(frame:CGRect.zero , contentView: self.contentView)
            pop.id_arrowPosition = .custom
            pop.id_trianglePoint = CGPoint.init(x: KScreenWidth-30, y: 120)
            pop.showInRect(rect: CGRect.init(x: KScreenWidth-160-10, y: 128, width: 160, height: self.contentView.frame.height + 16))
        }
        @IBAction func clickLeft(_ sender: Any) {
            let pop = PopView.init(frame: CGRect.zero, contentView: self.contentView)
            pop.id_arrowPosition = .left
            pop.showInRect(rect: CGRect.init(x: 10, y: 128 + 56, width: 160, height: self.contentView.frame.height + 16))
        }
        @IBAction func clickM(_ sender: Any) {
            let pop = PopView.init(frame: CGRect.zero, contentView: self.contentView)
            pop.id_arrowPosition = .center
            pop.showInRect(rect: CGRect.init(x: KScreenWidth*0.5-80, y: 128 + 56 + 56, width: 160, height: self.contentView.frame.height + 16))
        }
        @IBAction func clickCustom(_ sender: Any) {
            let pop = PopView.init(frame: CGRect.zero, contentView: self.contentView)
            pop.id_arrowPosition = .custom
            pop.id_trianglePoint = CGPoint.init(x: KScreenWidth-70, y: 120+56+56+56)
            pop.showInRect(rect: CGRect.init(x: KScreenWidth-160-30, y: 128 + 56 + 56 + 56, width: 160, height: self.contentView.frame.height + 16))
        }
        @IBAction func clickColor(_ sender: Any) {
    //        let pop = PopView.init(contentView: self.contentView)
    //        pop.id_triangleSize = CGSize.init(width: 5, height: 5)
    //        pop.id_arrowPosition = .custom
    //        pop.id_trianglePoint = CGPoint.init(x: 0.5*(KScreenWidth-150) + 60, y: 490)
    //        pop.id_bgColor = UIColor.black
    //        pop.showInRect(rect: CGRect.init(x:  0.5*(KScreenWidth-150), y: 495, width: 160, height: self.contentView.frame.height + 16))
            
            let pop = PopView.init(frame: CGRect.zero, contentView: self.contentView2)
            pop.id_triangleSize = CGSize.init(width: 5, height: 5)
            pop.id_arrowPosition = .custom
            pop.id_bgColor = UIColor.black
            pop.id_trianglePoint = CGPoint.init(x: KScreenWidth-30, y: 120 + 56 + 56 + 56 + 56)
            pop.showInRect(rect: CGRect.init(x: KScreenWidth-160-10, y: 128 + 56 + 56 + 56 + 53, width: 160, height: self.contentView.frame.height + 16))
        }
        
        @objc func clickBtnTest() {
            print("22222")
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
