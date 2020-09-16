//
//  ImageSelectedVC.swift
//  swiftdemo
//
//  Created by qf on 2020/9/16.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class ImageSelectedVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.view.addSubview(self.weiboBtn)
        
            
        }
    
    
    @objc func clickLeftbtn()  {
        
    }
        
    lazy var weiboBtn: UIButton = {
    let  weibob = UIButton.init(type: UIButton.ButtonType.system)
    weibob.setTitleColor(RGBAColor(23, 32, 46), for: .normal)
        weibob.titleLabel?.font = UIFont.systemFont(ofSize: 15)
        weibob.addTarget(self, action: #selector(clickLeftbtn), for: .touchUpInside)
        return weibob
    }()

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
