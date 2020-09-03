//
//  EmptyTestVC.swift
//  swiftdemo
//
//  Created by qf on 2020/9/1.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class EmptyTestVC: BaseViewController {

    lazy var tableView: UITableView = {
            let tableView = UITableView.init(frame: CGRect(x:0,y:KNavgationBarHeight,width:KScreenWidth,height:KScreenHeight-KNavgationBarHeight), style: .plain)
            tableView.tableFooterView = UIView()
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = 60
            return tableView
        }()
        
        var styles: [EmptyView.Style] = [.normal,
                                           .normalDeail("说明当前状态、提示解决方案。"),
                                           .normalOperational,
                                           .normalDetailOperational("说明当前状态、提示解决方案。"),
                                           .load,
                                           .loadDetail]
        var titleArr = ["normal", "normalDeail 空状态说明", "normalOperational 可操作空状态", "normalDetailOperational 可操作并有说明的空状态", "load 网络加载失败可操作", "loadDetail 网络环境不可操作"]

        override func viewDidLoad() {
            super.viewDidLoad()

            self.id_navTitle = "EmptyView"
            
            self.view.addSubview(tableView)
        }
    }

    //MARK: - UITableViewDelegate,UITableViewDataSource
extension EmptyTestVC:UITableViewDelegate,UITableViewDataSource{
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.titleArr.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var cell = tableView.dequeueReusableCell(withIdentifier: "ID")
            if cell == nil {
                cell = UITableViewCell.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "ID")
            }
            cell?.textLabel?.text = self.titleArr[indexPath.row]
            cell?.accessoryType = .disclosureIndicator
            cell?.textLabel?.numberOfLines = 0
            return cell!
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            let secondViewController = SecondVC()
            secondViewController.style = styles[indexPath.row]
            self.navigationController?.pushViewController(secondViewController, animated: true)
        }
    }
