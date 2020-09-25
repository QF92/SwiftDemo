//
//  CardListVC.swift
//  swiftdemo
//
//  Created by qf on 2020/9/25.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class CardListVC: BaseViewController {

    var cellCount:Int = 10
    lazy var cardLayout: CardLayout = {
        let layout = CardLayout()
        layout.visibleCount = 4
        layout.maxAngle = 15.0
        layout.isRepeat = false
        layout.isPanAnimatedEnd = false //必须动画结束才可再次拖拽，为true时可不停的拖拽
        layout.maxRemoveDistance = self.view.frame.width/4
        layout.cardInsets = UIEdgeInsets(top: 10, left: 10, bottom: -10, right: 10)
        return layout
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()

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
