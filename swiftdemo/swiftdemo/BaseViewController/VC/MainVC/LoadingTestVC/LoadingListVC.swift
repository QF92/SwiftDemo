//
//  LoadingListVC.swift
//  swiftdemo
//
//  Created by qf on 2020/8/31.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class LoadingListVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.id_navTitle = "商品列表"
        
        self.view.backgroundColor = UIColor.init(redValue: 245, green: 245, blue: 245, alpha: 1)
        
        Loading.id_show(onView: self.view)
        // Do any additional setup after loading the view.
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
