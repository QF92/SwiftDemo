//
//  ArrayVC.swift
//  swiftdemo
//
//  Created by qf on 2020/9/2.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class ArrayVC: BaseViewController {

     @IBOutlet weak var label3: UILabel!
      @IBOutlet weak var label2: UILabel!
      @IBOutlet weak var label1: UILabel!
      override func viewDidLoad() {
          super.viewDidLoad()

          self.id_navTitle = "数组处理"
          
          self.label1.text = "[1,1,2,2,3,3,4,4]"
          
          self.label2.text = "[1, 2, 3, 4]"
          
          let arr = [1,1,2,2,3,3,4,4]
          let arr2 = arr.id_filterDuplicates({$0})
          print(arr2)
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
