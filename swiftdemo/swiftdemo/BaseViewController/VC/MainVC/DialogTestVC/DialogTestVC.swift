//
//  DialogTestVC.swift
//  swiftdemo
//
//  Created by qf on 2020/8/31.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class DialogTestVC: BaseViewController {

        lazy var tableView: UITableView = {
            let tableView = UITableView.init(frame: CGRect(x:0,y:KNavgationBarHeight,width:KScreenWidth,height:KScreenHeight-KNavgationBarHeight), style: .grouped)
            tableView.tableFooterView = UIView()
            tableView.delegate = self
            tableView.dataSource = self
            tableView.rowHeight = 60
            return tableView
        }()
        
        let dataArr = ["基本使用", "带图片的Dialog", "带文本输入框的Dialog"]
        
        override func viewDidLoad() {
            super.viewDidLoad()
            
            self.view.addSubview(tableView)
            self.id_navTitle = "Dialog支持3种样式"
        }
    }
    //MARK: - UITableViewDelegate,UITableViewDataSource
//使用 extension 来为现有的类型添加功能，比如新的方法和计算属性。你可以使用扩展让某个在别处声明的类型来遵守某个协议，这同样适用于从外部库或者框架引入的类型。
extension DialogTestVC:UITableViewDelegate,UITableViewDataSource{
        func numberOfSections(in tableView: UITableView) -> Int {
            return dataArr.count
        }
        func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
            return 1
        }
        
        func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
            let cell = DialogCell.cellWithTableView(tableView: tableView)
            cell.titleLabel.text = self.dataArr[indexPath.section]
            cell.swichClouse = {() in
                self.showDialog(index: indexPath.section)
            }
            cell.detailClouse = {() in
                self.detailDialog(index: indexPath.section)
            }
            return cell
        }
        
        func detailDialog(index: Int) {
            if index == 0 {
                let vc = DialogBaseVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if index == 1 {
                let vc = DialogImageVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if index == 2 {
                let vc = DialogInputVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        
        func showDialog(index: Int) {
            if index == 0 {
                DialogTool.id_show(title: "温馨提示", msg: "确定要取消？", leftActionTitle: "确定", rightActionTitle: "取消", leftHandler: {
                    print("点击了左边")
                }) {
                    print("点击了右边")
                }
            }
            if index == 1 {
                DialogTool.id_showImg(success: .success, msg: "提交成功", leftActionTitle: "知道了", rightActionTitle: nil, leftHandler: nil, rightHandler: nil)
            }
            if index == 2 {
                DialogTool.id_showInput(msg: "请输入取消原因", leftActionTitle: "取消", rightActionTitle: "确定", leftHandler: { (text) in
                    print(text)
                }) { (text) in
                    print(text)
                }
            }
        }
}

