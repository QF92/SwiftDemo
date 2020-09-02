//
//  SegmentVC.swift
//  swiftdemo
//
//  Created by qf on 2020/9/2.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class SegmentVC: BaseViewController {

    @IBOutlet weak var moreBtn: UIButton!
       @IBOutlet weak var seg:  BaseSegmentedControl!
       @IBOutlet weak var seg1: BaseSegmentedControl!
       
       lazy var selectView: BaseSelectView = {
           let select = BaseSelectView.init(frame: CGRect.init(x: 0, y: 290, width: KScreenWidth, height: 50))
           select.id_titles = ["待支付", "已支付", "待发货"]
           return select
       }()
       override func viewDidLoad() {
           super.viewDidLoad()
           
           self.id_navTitle = "IDSegmentedView"
           self.view.backgroundColor = UIColor.groupTableViewBackground

           self.seg.setImage(UIImage(named: "ic_new"), forSegmentAt: 0)
           
           self.seg1.id_setSegmentStyle(normalColor: UIColor.white, selectedColor: UIColor.red, dividerColor: UIColor.groupTableViewBackground)
           
           self.view.addSubview(self.selectView)
           
           self.moreBtn.layer.cornerRadius = 15
       }

       @IBAction func clickMoreBtrn(_ sender: Any) {
           let vc = BaseSelectVC()
           self.navigationController?.pushViewController(vc, animated: true)
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
