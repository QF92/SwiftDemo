//
//  MainViewController.swift
//  swiftdemo
//
//  Created by qf on 2020/3/9.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit

class MainViewController: BaseViewController {

override func viewDidLoad() {
        super.viewDidLoad()
    self.view.backgroundColor = RGBAColor(255,255,255)
         // Do any additional setup after loading the view.
    self.view.addSubview(tableView)
    self.tableView.contentInset = UIEdgeInsets.init(top: 10, left: 0, bottom: 0, right: 0)
    self.id_navTitle = "IDealist"
           
    self.id_rightBtn.setImage(UIImage(named: "icn_icn_imfomation"), for: .normal)
    
       self.view.addSubview(self.TimeLab)
       self.view.addSubview(self.TimeLab1)
       self.view.addSubview(self.timeBtn)
       self.view.addSubview(self.timeBtn2)
    
    
    // 假如 Swift 6.0 是 iOS 13.0 的 Swift 版本
       if #available(iOS 13.0, *) {
           // Swift 6.0 标准库中存在 A
         
        @dynamicMemberLookup  //@dynamicMemberLookup 可以用在协议，结构体，枚举，类，甚至标注为 @objc 的类，以及它们的继承者。
        struct Person5 {
            subscript(dynamicMember member: String) -> String {
                let properties = ["name": "Tylor Swift", "city" : "Nashville"]
                return properties[member, default: ""]
            }
            subscript(dynamicMember member: String) -> Int {
                let properties = ["age": 26, "height": 178]
                return properties[member, default: 0]
            }
         }

        let person5 = Person5()
        print("person5.name: \(person5.name)")
        print("person5.city: \(person5.city)")
        print("person5.favoriteIceCream: \(person5.favoriteIceCream)")
        
        
        print("person5.age: \(person5.age)")
        let age: Int = person5.age
        print("person5.age2: \(age)")
        
       } else {
           // 不存在 A 时的处理
       }
    
    }
            
        class InterviewTest {
           var name: String
           lazy var greeting : String = { return "Hello \(self.name)" }()
            // 这里没有循环引用 ..

           init(name: String) {
                self.name = name
            }
        }

        struct InterviewCandidate {
            var isIos:Bool?
            lazy var iOSResumeDescription:String = {
               return "I am an ios developer"
            }()
                
            lazy var androidResumeDescription:String = {
                return "I am an android developer"
            }()
           }
    
       lazy var TimeLab:UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 15, y: 600, width:100, height: 30))
        label.textColor = RGBAColor(155, 155, 155)
         label.font = UIFont.systemFont(ofSize: 12)
         label.text = "Time1:"
        return label
    }()
    
       lazy var TimeLab1:UILabel = {
        let label = UILabel.init(frame: CGRect.init(x: 150, y: 600, width:100, height: 30))
        label.textColor = RGBAColor(155, 155, 155)
         label.font = UIFont.systemFont(ofSize: 12)
         label.text = "Time2:"
        return label
    }()
    
    
    @objc func TimeClickBtn(btn:UIButton){
        CountdownTimer.startTimer(key: .test1, count: 60) { [weak self] (count, finish) in
            self?.TimeLab.text = finish ? "Time1:Finished" : "Time1:\(count)"
        }
        
    }
    @objc func TimeClickBtn2(){
        CountdownTimer.startTimer(key: .test2, count: 10) { [weak self] (count, finish) in
            self?.TimeLab1.text = finish ? "Time1:Finished" : "Time1:\(count)"
        }
        
    }
    lazy var timeBtn:UIButton = {
        let timebtn = UIButton.init(frame: CGRect.init(x: 15, y: 650, width: 100, height: 30))
        timebtn.setTitle("Start Timer1", for: UIControl.State.normal)
        timebtn.backgroundColor = UIColor.red
        timebtn.layer.cornerRadius = 20
        timebtn.layer.masksToBounds = true
        timebtn.addTarget(self, action: #selector(TimeClickBtn(btn:)), for: .touchUpInside)
        return timebtn
    }()
    
    lazy var timeBtn2:UIButton = {
        let timebtn = UIButton.init(frame: CGRect.init(x: 150, y: 650, width: 100, height: 30))
        timebtn.setTitle("Start Timer2", for: UIControl.State.normal)
        timebtn.backgroundColor = UIColor.red
        timebtn.layer.cornerRadius = 20
        timebtn.layer.masksToBounds = true
        timebtn.addTarget(self, action: #selector(TimeClickBtn2), for: .touchUpInside)
        return timebtn
    }()
    
    override func touchesBegan(_ touches: Set<UITouch>, with event: UIEvent?) {
        CountdownTimer.stopTimer(key: .test1)
    }
    
    lazy var tableView: UITableView = {
        let tableView = UITableView.init(frame:CGRect.init(x: 0, y: KNavgationBarHeight, width:KScreenWidth , height: KScreenHeight - KNavgationBarHeight-KTabBarHeight)  , style: .grouped);
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
    
    
    let dataArr = ["对话框组件 Dialog", "轻提示组件 Toast", "加载框组件 Loading", "空状态组件 EmptyView", "图片选择组件 ImagePicker", "扫描二维码组件 ScanCode", "基础控制器 BaseViewController"]
    let imageArr = ["icn_icn_dialog", "icn_icn_toast", "icn_icn_loading", "icn_icn_refresh", "icn_icn_emptyview", "icn_icn_update", "icn_icn_image", "icn_icn_scanning", "icn_icn_view"]
 
    override func rightBtnClick() {
//        let vc = IDInfoViewController.init(nibName: "IDInfoViewController", bundle: nil)
//        self.navigationController?.pushViewController(vc, animated: true)
    }
}

//MARK: - UITableViewDelegate,UITableViewDataSource
extension MainViewController:UITableViewDelegate,UITableViewDataSource{
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
                let vc = DialogTestVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.section == 1 {
                let vc = ToastTestVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.section == 2 {
                let vc = LoadingTestVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
    //        if indexPath.section == 3 {
    //            let vc = TestIDRefreshController()
    //            self.navigationController?.pushViewController(vc, animated: true)
    //        }
            if indexPath.section == 3 {
                let vc = EmptyTestVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            
    //        if indexPath.section ==  {
    //            let vc = IDUpdateManagerTestController()
    //            self.navigationController?.pushViewController(vc, animated: true)
    //        }
            if indexPath.section == 4 {
                let vc = ImagePickerVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.section == 5 {
                let vc = ScanQRCodeVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
            if indexPath.section == 6 {
                let vc = ShowBaseVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
        }
        func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
            return 5
        }
        func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
            return 0.1
        }}
/*
    // MARK: - Navigation

    // In a storyboard-based application, you will often want to do a little preparation before navigation
    override func prepare(for segue: UIStoryboardSegue, sender: Any?) {
        // Get the new view controller using segue.destination.
        // Pass the selected object to the new view controller.
    }
    */

