//
//  DialogImageVC.swift
//  swiftdemo
//
//  Created by qf on 2020/8/31.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class DialogImageVC: BaseViewController {

    lazy var tableView: UITableView = {
            let tableView = UITableView.init(frame: CGRect(x:0,y:KNavgationBarHeight,width:KScreenWidth,height:KScreenHeight-KNavgationBarHeight), style: .plain)
            tableView.tableFooterView = UIView()
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = 60
            return tableView
        }()
        
        var titleArr = ["展示默认成功图片", "展示默认失败图片", "自定义图片"]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.view.addSubview(self.tableView)
            self.id_navTitle = "带有图片的Dialog"
        }
        
    }

    //MARK: - UITableViewDelegate,UITableViewDataSource
    extension DialogImageVC:UITableViewDelegate,UITableViewDataSource{
        func numberOfSections(in tableView: UITableView) -> Int {
            return 1
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return self.titleArr.count
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let ID = "ID"
            var cell = tableView.dequeueReusableCell(withIdentifier: ID)
            if cell == nil {
                cell = UITableViewCell(style: .default, reuseIdentifier: ID)
            }
            cell?.textLabel?.numberOfLines = 0
            cell?.textLabel?.font = UIFont.systemFont(ofSize: 14)
            cell?.textLabel?.text = self.titleArr[indexPath.row]
            return cell!
        }
        
        func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
            if indexPath.row == 0 {
                DialogTool.id_showImg(success: .success, msg: "提交成功", leftActionTitle: "知道了", rightActionTitle: nil, leftHandler: nil, rightHandler: nil)
            }
            if indexPath.row == 1 {
                DialogTool.id_showImg(success: .fail, msg: "提交失败", leftActionTitle: "知道了", rightActionTitle: "确定", leftHandler: nil, rightHandler: nil)
            }
            if indexPath.row == 2 {
                DialogManager.share.successImage = UIImage.init(named: "message_success")
                DialogTool.id_showImg(success: .success, msg: "提交成功", leftActionTitle: "知道了", rightActionTitle: nil, leftHandler: nil, rightHandler: nil)
            }
        }
    }
