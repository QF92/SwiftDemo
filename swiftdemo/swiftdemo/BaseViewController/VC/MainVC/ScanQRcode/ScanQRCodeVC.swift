//
//  ScanQRCodeVC.swift
//  swiftdemo
//
//  Created by qf on 2020/9/1.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class ScanQRCodeVC: BaseViewController {

   lazy var tableView: UITableView = {
            let tableView = UITableView.init(frame: CGRect(x:0,y:KNavgationBarHeight,width:KScreenWidth,height:KScreenHeight-KNavgationBarHeight), style: .plain)
            tableView.tableFooterView = UIView()
            tableView.delegate = self
            tableView.dataSource = self
            return tableView
        }()
        
        var titleArr = ["默认样式", "修改导航栏属性"]

        override func viewDidLoad() {
            super.viewDidLoad()

            self.id_navTitle = "IDScanQrcode"
            
            self.view.addSubview(tableView)
        }
    }

    //MARK: - UITableViewDelegate,UITableViewDataSource
    extension ScanQRCodeVC:UITableViewDelegate,UITableViewDataSource{
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return titleArr.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            var cell = tableView.dequeueReusableCell(withIdentifier: "ID")
            if cell == nil {
                cell = UITableViewCell.init(style: UITableViewCell.CellStyle.value1, reuseIdentifier: "ID")
            }
            cell?.textLabel?.text = self.titleArr[indexPath.row]
            cell?.accessoryType = .disclosureIndicator
            return cell!
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            tableView.deselectRow(at: indexPath, animated: true)
            if indexPath.row == 0 {
                let vc = ScanCodeController()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.row == 1 {
                let vc =  QRcodeVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
            
        }
    }
