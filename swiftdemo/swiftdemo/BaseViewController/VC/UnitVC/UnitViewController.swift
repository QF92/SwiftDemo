//
//  UnitViewController.swift
//  swiftdemo
//
//  Created by qf on 2020/3/9.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit
import Photos
class UnitViewController: BaseViewController {

    var dataArr = ["统一设置组件库的主题颜色", "快速实现颜色设置", "获取App信息", "字符串截取封装函数", "日期封装", "UIView属性扩展", "Url特殊字符串处理", "数组去重"]
    
    override func viewDidLoad() {
        super.viewDidLoad()

        self.id_navTitle = "公共方法、扩展方法集合"
        self.view.addSubview(tableView)
        self.id_rightBtn.setImage(UIImage(named: "icn_icn_imfomation"), for: .normal)
    }
    override func rightBtnClick() {
           
    }

    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame: CGRect.init(x:0,y:KNavgationBarHeight,width:KScreenWidth,height:KScreenHeight-KNavgationBarHeight-KTabBarHeight), style: .plain)
        tableView.tableFooterView = UIView()
        tableView.delegate = self
        tableView.dataSource = self
        tableView.rowHeight = 60
        return tableView
    }()
    /*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

}
//MARK:- UITableViewDelegate,UITableViewDataSource
extension UnitViewController:UITableViewDelegate,UITableViewDataSource{
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
        cell?.accessoryType = .disclosureIndicator
        cell?.textLabel?.text = self.dataArr[indexPath.row]
        return cell!
    }
    
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
        tableView.deselectRow(at: indexPath, animated: true)
        if indexPath.row == 0 {
            let vc = UtilsThemeVC.init(nibName: "UtilsThemeVC", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 1 {
            let vc = BaseColorVC.init(nibName: "BaseColorVC", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 2 {
            let vc = AppInfoVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 3 {
            let vc = StringVC.init(nibName: "StringVC", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 4 {
            let vc = TimeDateVC()
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 5 {
            let vc = IDViewVC.init(nibName: "IDViewVC", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 6 {
            let vc = URLVC.init(nibName: "URLVC", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
        if indexPath.row == 7 {
            let vc = ArrayVC.init(nibName: "ArrayVC", bundle: nil)
            self.navigationController?.pushViewController(vc, animated: true)
        }
    }
}
