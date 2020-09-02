//
//  TimeDateVC.swift
//  swiftdemo
//
//  Created by qf on 2020/9/2.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class TimeDateVC: BaseViewController {

    override func viewDidLoad() {
        super.viewDidLoad()
        self.id_navTitle = "日期封装"
        self.view.addSubview(self.tableView)
        // Do any additional setup after loading the view.
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect(x:0,y:KNavgationBarHeight,width:KScreenWidth,height:KScreenHeight-KNavgationBarHeight-KTabBarHeight), style: .plain)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = UITableView.automaticDimension
        tableView.estimatedRowHeight = 60
        return tableView
    }()
    
    var dataArr = ["是否是今天:\(Date().id_isToday())",
        "是否是今年:\(Date().id_isThisYear())",
        "是否是昨天：\(Date().id_isYesterday())",
        "是否是3天内：\(Date().id_isBetween(dateNum: 3))",
        "日期格式化：\(Date().format("yyyy/MM/dd"))",
        "日期格式化开始时间：\(Date().start.format("yyyy/MM/dd HH:mm:ss"))",
        "日期格式化结束时间：\(Date().end.format("yyyy/MM/dd HH:mm:ss"))"
    ]

    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//MARK: - UITableViewDelegate,UITableViewDataSource
extension TimeDateVC:UITableViewDelegate,UITableViewDataSource{
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
