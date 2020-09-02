//
//  ProgressVC.swift
//  swiftdemo
//
//  Created by qf on 2020/9/2.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class ProgressVC: BaseViewController {

    @IBOutlet weak var circleView: BaseProgressCircleView!
    @IBOutlet weak var nibProgressView: BaseProgressCircleView!
    
    override func viewDidLoad() {
        super.viewDidLoad()
    
        self.id_navTitle = "IDProgressView"
        self.view.backgroundColor = UIColor.groupTableViewBackground
        self.nibProgressView.id_value = 50
        
        // circleView的宽高是80
        self.circleView.id_type = .pie
        self.circleView.id_value = 50
    }
    @IBAction func clickSider(_ sender: Any) {
        let value = (sender as! UISlider).value * 100
        
        self.nibProgressView.id_value = CGFloat(value)
    }
    @IBAction func clickSlider2(_ sender: Any) {
        let value = (sender as! UISlider).value * 100
        self.circleView.id_value = CGFloat(value)
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
