//
//  NetWorkVC.swift
//  swiftdemo
//
//  Created by qf on 2020/9/1.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit
import MJRefresh
class NetWorkVC: BaseViewController , UITableViewDataSource, UITableViewDelegate {

    fileprivate var currentTabelView:UITableView?
    fileprivate var dataModel:MyActivityListModel?
    fileprivate var dataArray:NSMutableArray?
    
    override func viewDidLoad() {
        super.viewDidLoad()

        // Do any additional setup after loading the view.
        self.view.backgroundColor = UIColor.white
        
        //headerView
        let headerView = UILabel.init()
        headerView.text = "我的活动"
        if  isiPhoneX(){
            headerView.frame = CGRect(x: 0, y: KNavgationBarHeight, width: KScreenWidth, height: 88)
        } else {
            headerView.frame = CGRect(x: 0, y: KNavgationBarHeight, width: KScreenWidth, height: 64)
        }
        self.view.addSubview(headerView)
        
        self.currentTabelView = UITableView.init(frame: CGRect(x: 0, y: headerView.frame.maxY, width: KScreenWidth, height: self.view.frame.size.height - headerView.frame.height-KNavgationBarHeight-KTabBarHeight))
        self.view.addSubview(self.currentTabelView!)
        self.currentTabelView!.backgroundColor = UIColor.white
        self.currentTabelView!.separatorStyle = UITableViewCell.SeparatorStyle.none
        //设置数据源
        self.currentTabelView!.dataSource = self
        //设置代理
        self.currentTabelView!.delegate = self
        self.currentTabelView!.register(UITableViewCell.classForCoder(), forCellReuseIdentifier: "MyactivityTableViewCell")
        
        self.dataArray = NSMutableArray.init()
        
        weak var weakSelf = self
        self.currentTabelView?.mj_header =  MJRefreshHeader.init(refreshingBlock: {
            //请求数据
            weakSelf?.loadNewData()
        })
        self.currentTabelView?.mj_header?.beginRefreshing()
    }
    //MARK:请求新的数据
    func loadNewData(){
        let urlString = String(format: "%@%@", "http://m.shejiaotest.pro", "/prestige/following/rabies.do")
        //加密
//        let serverString  = EncryptUrl.sharedInstance.encryptUrlWithOriginalUrl(originalUrl: urlString)
        let parameters:[String : Any] = [:]
//        let paramedic:Dictionary = ["type":"1","name":"customer","password":"123456"]
        weak var weakSelf = self
        NetWorkingTool.sharedInstance.postRequest(urlString: urlString, params: parameters, success: { (dictResponse) in
//            print("我参加活动的数据是\(jsonString)")
            weakSelf?.currentTabelView?.mj_header?.endRefreshing()
            let loaclData = dictResponse as Data
            do {
            weakSelf?.dataModel = try JSONDecoder().decode(MyActivityListModel.self, from: loaclData)

                weakSelf?.currentTabelView?.reloadData()
            } catch {
//                debugPrint("student===ERROR")
            }
        }) { (error) in
            if error._code == NSURLErrorTimedOut {
                //超时
//                FSHUDMananger.showMessage("请求超时，请稍后再试", completion: nil)
            } else {
//                FSHUDMananger.showMessage("服务器出了点小问题，请稍后再试", completion: nil)
            }
        }
    }
    //MARK:加载tabelView
    func tableView(_ tableView: UITableView, numberOfRowsInSection section: Int) -> Int {
        
        if self.dataModel == nil{
            return 4
        }
        if self.dataModel!.activityList.count != 0  {
            return self.dataModel!.activityList.count
        }
        return 0;
    }
    func tableView(_ tableView: UITableView, cellForRowAt indexPath: IndexPath) -> UITableViewCell {
        let indentifier = "MyactivityTableViewCell"
        
        var cell:MyactivityTableViewCell! = tableView.dequeueReusableCell(withIdentifier: indentifier)as?MyactivityTableViewCell
        if cell == nil {
            cell = MyactivityTableViewCell(style: .default, reuseIdentifier: indentifier)
        }
        cell.selectionStyle = UITableViewCell.SelectionStyle.none
//        cell.detailModel = self.dataModel!.activityList[indexPath.row] as DetailModel
        return cell
    }
    
    //MARK:加载tabelView的代理
    func tableView(_ tableView: UITableView, didSelectRowAt indexPath: IndexPath) {
//        let detailModel = self.dataModel!.activityList[indexPath.row] as DetailModel
//        let detailVC : XWActivityDetailViewController =  XWActivityDetailViewController.init(activityName: detailModel.name, url: detailModel.url)
//        self.navigationController?.pushViewController(detailVC, animated: true)
    }
    func tableView(_ tableView: UITableView, heightForRowAt indexPath: IndexPath) -> CGFloat {
        return MyactivityTableViewCell.myactivityTableViewCellHeight()
    }
    
    override func didReceiveMemoryWarning() {
        super.didReceiveMemoryWarning()
        
    }
    deinit {
        
    }
}
