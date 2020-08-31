//
//  LoadingTestVC.swift
//  swiftdemo
//
//  Created by qf on 2020/8/31.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class LoadingTestVC: BaseViewController {

    lazy var tableView: UITableView = {
            let tableView = UITableView.init(frame: CGRect(x:0,y:KNavgationBarHeight,width:KScreenWidth,height:KScreenHeight-KNavgationBarHeight), style: .grouped)
            tableView.tableFooterView = UIView()
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = 50
            return tableView
        }()
        
        let dataArr = ["进入列表界面", "进入webView页面", "提交订单，阻止与用户交互"]

        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.view.addSubview(tableView)
            self.id_navTitle = "加载框演示"
        }
    }

    //MARK: - UITableViewDelegate,UITableViewDataSource
extension LoadingTestVC:UITableViewDelegate,UITableViewDataSource{
        func numberOfSections(in tableView: UITableView) -> Int {
            return dataArr.count
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var cell = tableView.dequeueReusableCell(withIdentifier: "cell")
            if cell == nil {
                cell = UITableViewCell.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "cell")
            }
            cell?.accessoryType = .disclosureIndicator
            cell?.textLabel?.text = self.dataArr[indexPath.section]
            return cell!
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)

            if indexPath.section == 0 {
                let vc = LoadingListVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.section == 1 {
                let vc = LoadingWebVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.section == 2 {
                Loading.id_showWithWait()
                DispatchQueue.main.asyncAfter(deadline: DispatchTime.now() + 3) {
                    Loading.id_dismissWait()
                }
            }
        }
    }
