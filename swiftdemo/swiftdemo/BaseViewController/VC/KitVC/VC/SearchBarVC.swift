//
//  SearchBarVC.swift
//  swiftdemo
//
//  Created by qf on 2020/9/1.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class SearchBarVC: BaseViewController {

    @IBOutlet weak var searchBar3: BaseSearchBar!
    @IBOutlet weak var searchBar2: BaseSearchBar!
    @IBOutlet weak var nibSearchBar: BaseSearchBar!
    
    lazy var searchBar4: BaseSearchBar = {
        let search = BaseSearchBar.init(frame: CGRect.init(x: 0, y: 300, width: KScreenWidth, height: 60))
        return search
    }()
    
    override func viewDidLoad() {
        super.viewDidLoad()
        
        self.id_navTitle = "IDSearchBar"
        
        self.view.backgroundColor = UIColor.init(redValue: 245, green: 245, blue: 249, alpha: 1)
        
        self.view.addSubview(self.searchBar4)
        
        self.searchBar2.id_placeHolder = "搜索"
        self.searchBar2.id_containerBgColor = UIColor.white
        
        self.searchBar3.id_showRightBtn = true
        
        self.searchBar4.id_showRightBtn = true
        self.searchBar4.id_cancelButtonTitle = "文本"
        self.searchBar4.id_cornerRadius = 20
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
