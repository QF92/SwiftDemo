//
//  SwitchVC.swift
//  swiftdemo
//
//  Created by qf on 2020/9/2.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class SwitchVC: BaseViewController {

    @IBOutlet weak var view4: UIView!
    @IBOutlet weak var view3: UIView!
    @IBOutlet weak var view2: UIView!
    @IBOutlet weak var view1: UIView!
    
    /// IDSwitch 默认宽80高40
    lazy var mySwitch: BaseSwitch = {
        let s = BaseSwitch.init()
        s.frame.origin.y = 2
        s.frame.origin.x = KScreenWidth-90
        s.isOn = false
        return s
    }()
    lazy var mySwitch2: BaseSwitch = {
        let s = BaseSwitch.init()
        s.frame.origin.y = 2
        s.frame.origin.x = KScreenWidth-90
        s.isOn = true
        return s
    }()
    lazy var mySwitch3: BaseSwitch = {
        let s = BaseSwitch.init()
        s.frame.origin.y = 2
        s.frame.origin.x = KScreenWidth-90
        s.id_Enable = false
        return s
    }()
    lazy var mySwitch4: BaseSwitch = {
        let s = BaseSwitch.init()
        s.frame.origin.y = 2
        s.frame.origin.x = KScreenWidth-90
        s.id_mainColor = UIColor.red
        return s
    }()
    override func viewDidLoad() {
        super.viewDidLoad()

        self.id_navTitle = "Switch"

        self.view.backgroundColor = UIColor.systemGroupedBackground
        self.view1.addSubview(self.mySwitch)
        self.view2.addSubview(self.mySwitch2)
        self.view3.addSubview(self.mySwitch3)
        self.view4.addSubview(self.mySwitch4)

        self.mySwitch.valueChange = {(value) in
            print(value)
        }
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
