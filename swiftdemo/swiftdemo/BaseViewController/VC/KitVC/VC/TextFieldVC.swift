//
//  TextFieldVC.swift
//  swiftdemo
//
//  Created by qf on 2020/9/1.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class TextFieldVC: BaseViewController {

    @IBOutlet weak var BaseText1: BaseTextField!
        
    
    @IBOutlet weak var BaseText2: BaseTextField!

        
    @IBOutlet weak var BaseText3: BaseTextField!

    @IBOutlet weak var BaseText4: BaseTextField!

    
    @IBOutlet weak var BaseText5: BaseTextField!
        
        override func viewDidLoad() {
            super.viewDidLoad()
            self.id_navTitle = "IDTextField"

            self.view.backgroundColor = UIColor.groupTableViewBackground

            self.BaseText1.maxLength = 10

            self.BaseText2.onlyNumberAndPoint = true
            self.BaseText2.pointLength = 2

            self.BaseText3.onlyNumber = true

            self.BaseText4.allowEmoji = false

            self.BaseText5.predicateString = "^[a-z0－9A-Z]*$"
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
