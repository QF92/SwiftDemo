//
//  AppInfoVC.swift
//  swiftdemo
//
//  Created by qf on 2020/9/2.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class AppInfoVC: BaseViewController {

   lazy var tableView: UITableView = {
            let tableView = UITableView.init(frame: CGRect(x:0,y:KNavgationBarHeight,width:KScreenWidth,height:KScreenHeight-KNavgationBarHeight-KTabBarHeight), style: .plain)
            tableView.tableFooterView = UIView()
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = UITableView.automaticDimension
            tableView.estimatedRowHeight = 60
            return tableView
        }()
        
        var dataArr = ["通过指定的key获取app中infoplist文件的信息: IDPlistUtils.get('')",
                       "获取app版本号: IDPlistUtils.getVersionCode()",
                       "获取app Build版本号: IDPlistUtils.getBuildCode()"]
        override func viewDidLoad() {
            super.viewDidLoad()

            self.id_navTitle = "获取app信息"
            self.view.addSubview(self.tableView)
            print(PlistUtils.getBuildCode())
            print(PlistUtils.getVersionCode())
        }

    }
//MARK: - UITableViewDelegate,UITableViewDataSource
extension AppInfoVC:UITableViewDelegate,UITableViewDataSource{
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return dataArr.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var cell = tableView.dequeueReusableCell(withIdentifier: "ID")
            if cell == nil {
                cell = UITableViewCell.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "ID")
            }
            cell?.accessoryType = .none
            cell?.textLabel?.text = self.dataArr[indexPath.row]
            cell?.textLabel?.numberOfLines = 0
            return cell!
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            if indexPath.row == 1 {
            }
        }

}
