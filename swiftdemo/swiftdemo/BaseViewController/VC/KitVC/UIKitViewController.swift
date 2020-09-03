//
//  UIKitViewController.swift
//  swiftdemo
//
//  Created by qf on 2020/3/9.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class UIKitViewController: BaseViewController {

     override func viewDidLoad() {
         super.viewDidLoad()
         
         self.view.addSubview(tableView)
         self.tableView.contentInset = UIEdgeInsets.init(top: 10, left: 0, bottom: 0, right: 0)
         self.id_navTitle = "Dealist"
         self.id_rightBtn.setImage(UIImage(named: "icn_icn_imfomation"), for: .normal)
     }
    
     lazy var tableView: UITableView = {
             let tableView = UITableView.init(frame: CGRect(x:0,y:KNavgationBarHeight,width:KScreenWidth,height:KScreenHeight-KNavgationBarHeight-KTabBarHeight), style: .grouped)
             tableView.tableHeaderView = UIView.init(frame: CGRect.init(x: 0, y: 0, width: 0, height: 0.1))
             tableView.tableFooterView = UIView()
             tableView.separatorStyle = .none
             tableView.delegate = self
             tableView.dataSource = self
             tableView.estimatedRowHeight = 64
             tableView.estimatedSectionFooterHeight = 0
             tableView.estimatedSectionHeaderHeight = 0
             tableView.rowHeight = 64
             return tableView
         }()
         
         let dataArr = ["按钮 Button", "文本 Label", "图片 Image", "气泡 PopView","文本输入框 TextField", "多行文本输入框 IDTextView", "搜索框 SearchBar","开关按钮Switch","选择控件 SegmentedControl", "进度条 ProgressView","网络请求"]
         let imageArr = ["icn_icn_button", "icn_icn_label", "icn_icn_image", "icn_icn_popview", "icn_icn_textfield", "icn_icn_textview", "icn_icn_searchbar", "icn_icn_switch", "icn_icn_segmentview", "icn_icn_progressview", "icn_icn_progressview"]
         
         
         override func rightBtnClick() {
//             let vc = InfoViewController.init(nibName: "InfoViewController", bundle: nil)
//             self.navigationController?.pushViewController(vc, animated: true)
         }
     }

     //MARK: - UITableViewDelegate,UITableViewDataSource
     extension UIKitViewController:UITableViewDelegate,UITableViewDataSource{
         func numberOfSections(in tableView: UITableView) -> Int {
             return dataArr.count
         }
         func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
             return 1
         }
         
         func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
             let cell = HomeListCell.cellWithTableView(tableView: tableView)
             cell.titleLabel.text = self.dataArr[indexPath.section]
             cell.iconView.image = UIImage(named: self.imageArr[indexPath.section])
             return cell
         }
         
         func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
             
             if indexPath.section == 0 {
                 let vc = ButtonVC()
                 self.navigationController?.pushViewController(vc, animated: true)
             }
             if indexPath.section == 1 {
                 let vc = LabelVC()
                 self.navigationController?.pushViewController(vc, animated: true)
             }
             if indexPath.section == 2 {
                 let vc = ImageVC()
                 self.navigationController?.pushViewController(vc, animated: true)
                
             }
             if indexPath.section == 3 {
                 let vc = PopVC.init(nibName: "PopVC", bundle: nil)
                 self.navigationController?.pushViewController(vc, animated: true)
             }
             if indexPath.section == 4 {
                let vc = TextFieldVC.init(nibName: "TextFieldVC", bundle: nil)
                 self.navigationController?.pushViewController(vc, animated: true)
             }
             if indexPath.section == 5 {
                 let vc =  TextViewVC()
                 self.navigationController?.pushViewController(vc, animated: true)
             }
             if indexPath.section == 6 {
                 let vc = SearchBarVC.init(nibName: "SearchBarVC", bundle: nil)
                 self.navigationController?.pushViewController(vc, animated: true)
                 
             }
             if indexPath.section == 7 {
                 let vc = SwitchVC.init(nibName: "SwitchVC", bundle: nil)
                 self.navigationController?.pushViewController(vc, animated: true)
                 
             }
             if indexPath.section == 8 {
                 let vc = SegmentVC.init(nibName: "SegmentVC", bundle: nil)
                 self.navigationController?.pushViewController(vc, animated: true)
             }
             if indexPath.section == 9 {
                 let vc = ProgressVC.init(nibName: "ProgressVC", bundle: nil)
                 self.navigationController?.pushViewController(vc, animated: true)
             }
             if indexPath.section == 10 {
                let vc = NetWorkVC()
                 self.navigationController?.pushViewController(vc, animated: true)
             }
         }
         func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
             return 5
         }
         func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
             return 0.1
    }
}
