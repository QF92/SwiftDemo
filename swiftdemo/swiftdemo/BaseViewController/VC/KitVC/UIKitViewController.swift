//
//  UIKitViewController.swift
//  swiftdemo
//
//  Created by qf on 2020/3/9.
//  Copyright © 2020 qf. All rights reserved.
//

import UIKit
import Kingfisher
class UIKitViewController: BaseViewController {

     override func viewDidLoad() {
         super.viewDidLoad()
         
         self.view.addSubview(tableView)
         self.tableView.contentInset = UIEdgeInsets.init(top: 10, left: 0, bottom: 0, right: 0)
         self.id_navTitle = "Dealist"
         self.id_rightBtn.setImage(UIImage(named: "icn_icn_imfomation"), for: .normal)
        
        let imagevie = UIImageView.init(frame: CGRect.init(x: 100, y: 600, width: 100, height: 100))
        self.view.addSubview(imagevie)
        let url = URL(string: "http://mvimg2.meitudata.com/55fe3d94efbc12843.jpg")
//        imagevie.kf.setImage(with: url)
        
        let placeholderImage = UIImage(named: "ic_ssearch")
        imagevie.kf.setImage(with: url, placeholder: placeholderImage)
        
        imagevie.kf.setImage(with: url, placeholder: placeholderImage, options: nil, progressBlock: nil) { (result) in
           
        }
//        imagevie.kf.setImage(with: <#T##ImageDataProvider?#>, placeholder: <#T##Placeholder?#>, options: <#T##KingfisherOptionsInfo?#>, progressBlock: <#T##DownloadProgressBlock?##DownloadProgressBlock?##(Int64, Int64) -> Void#>, completionHandler: <#T##((Result<RetrieveImageResult, KingfisherError>) -> Void)?##((Result<RetrieveImageResult, KingfisherError>) -> Void)?##(Result<RetrieveImageResult, KingfisherError>) -> Void#>)
//
//
//        imagevie.kf.setImage(with: <#T##Resource?#>, placeholder: <#T##Placeholder?#>, options: <#T##KingfisherOptionsInfo?#>, progressBlock: <#T##DownloadProgressBlock?##DownloadProgressBlock?##(Int64, Int64) -> Void#>) { (<#Result<RetrieveImageResult, KingfisherError>#>) in
//            <#code#>
//        }

     }
    
     lazy var tableView: UITableView = {
             let tableView = UITableView.init(frame: CGRect(x:0,y:KNavgationBarHeight,width:KScreenWidth,height:KScreenHeight-KNavgationBarHeight-KTabBarHeight), style: .grouped)
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
         
         let dataArr = ["按钮 Button", "文本 Label", "图片 Image", "气泡 PopView","文本输入框 TextField", "多行文本输入框 IDTextView", "搜索框 SearchBar","开关按钮Switch","选择控件 SegmentedControl", "进度条 ProgressView","网络请求","QF网络请求"]
         let imageArr = ["icn_icn_button", "icn_icn_label", "icn_icn_image", "icn_icn_popview", "icn_icn_textfield", "icn_icn_textview", "icn_icn_searchbar", "icn_icn_switch", "icn_icn_segmentview", "icn_icn_progressview", "icn_icn_progressview", "icn_icn_progressview"]
         
         
         override func rightBtnClick() {
//             let vc = InfoViewController.init(nibName: "InfoViewController", bundle: nil)
//             self.navigationController?.pushViewController(vc, animated: true)
         }
    
    
     
   // #pragma mark -  Swift 中 set 和 get 方法
    
  //  在Swift中有计算属性set{}和get{}和存储属性didSet{}和willSet{},
  //  与OC不同的是，在Swift中get与set方法并不常用，也不会重写getter也setter方法，非要重写的话，可以这样：

    
    // 1. 只重写get方法，不写set方法，默认为readOnly
          public var  number: Int{
             get{
                return 1;
            }
          }
     //2.swift 中我们不能使用_C来表示OC中@property 修饰的变量值
         var numbers : Int{
            get{
                //1、不能写成number 或者self.number都会造成crash，原因不用多说大家都懂的，死循环
                //2、不能像Obj那样写成return _number
                //3、不能写成return numbers 或者 return self.numbers
                return 1 ;
            }
            set{
                //写上 self.number = newValue 和 不写都会造成crash
                            //而且 不能像ObjC中写上 ObjC
                            //number = newValue造成crash  原因是方法的死循环
                let a = newValue;
                print(a);
            }
        }
    //3、由于2提到的原因重写的时候，我们使用额外的一个变量来重写
    var _numberd :Int = 0
       var numberd : Int{
           get{
               return _numberd;
           }set{
               _numberd = newValue;
           }
       }
    
    //4、Swift中使用了willset 和 didSet这2个特性，来见识属性的除初始化之外的属性值变化
        var numberset : Int = 0{
            didSet{
                //UI 操作
            }
            willSet{
                
            }
        }
      //5、懒加载写法
        lazy var titleLab : UILabel = {
              return UILabel.init();
         }()
     }

     //MARK: - UITableViewDelegate,UITableViewDataSource
extension UIKitViewController:UITableViewDelegate,UITableViewDataSource{
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
                 let vc = ButtonVC()
                 self.navigationController?.pushViewController(vc, animated: true)
             }
             if indexPath.section == 1 {
                 let vc = LabelVC()
                 self.navigationController?.pushViewController(vc, animated: true)
             }
             if indexPath.section == 2 {
                 let vc = ImageVC()
                 self.navigationController?.pushViewController(vc, animated: true)
                
             }
             if indexPath.section == 3 {
                 let vc = PopVC.init(nibName: "PopVC", bundle: nil)
                 self.navigationController?.pushViewController(vc, animated: true)
             }
             if indexPath.section == 4 {
                let vc = TextFieldVC.init(nibName: "TextFieldVC", bundle: nil)
                 self.navigationController?.pushViewController(vc, animated: true)
             }
             if indexPath.section == 5 {
                 let vc =  TextViewVC()
                 self.navigationController?.pushViewController(vc, animated: true)
             }
             if indexPath.section == 6 {
                 let vc = SearchBarVC.init(nibName: "SearchBarVC", bundle: nil)
                 self.navigationController?.pushViewController(vc, animated: true)
                 
             }
             if indexPath.section == 7 {
                 let vc = SwitchVC.init(nibName: "SwitchVC", bundle: nil)
                 self.navigationController?.pushViewController(vc, animated: true)
                 
             }
             if indexPath.section == 8 {
                 let vc = SegmentVC.init(nibName: "SegmentVC", bundle: nil)
                 self.navigationController?.pushViewController(vc, animated: true)
             }
             if indexPath.section == 9 {
                 let vc = ProgressVC.init(nibName: "ProgressVC", bundle: nil)
                 self.navigationController?.pushViewController(vc, animated: true)
             }
             if indexPath.section == 10 {
                let vc = NetWorkVC()
                 self.navigationController?.pushViewController(vc, animated: true)
             }
            if indexPath.section == 11 {
               let vc = QFNetWorkVC()
                self.navigationController?.pushViewController(vc, animated: true)
            }
         }
         func tableView(_ tableView: UITableView, heightForFooterInSection section: Int) -> CGFloat {
             return 5
         }
         func tableView(_ tableView: UITableView, heightForHeaderInSection section: Int) -> CGFloat {
             return 0.1
    }
}
