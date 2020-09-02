//
//  SecondVC.swift
//  swiftdemo
//
//  Created by qf on 2020/9/1.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class SecondVC: BaseViewController {

   var style: EmptyView.Style?

    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.id_navTitle = "IDEmptyView"
        
        view.backgroundColor = UIColor.white
        view.id_empty = EmptyView.create().configStyle(style)
        view.id_empty?.backgroundColor = UIColor.init(white: 1.0, alpha: 0.92)
        
        self.view.bringSubviewToFront(self.id_customNavBar)
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
